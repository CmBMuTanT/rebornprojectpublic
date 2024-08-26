local PLUGIN = PLUGIN

PLUGIN.name = "меню для командиров"
PLUGIN.author = "hoobsug"
PLUGIN.description = "aa"

--юзергруппы которые могут использовать меню
local cmd_groups = {
	["superadmin"] = true,
	["cmd"] = true
}

local invite_radius = 512

local WhoCanInvite = {
	[FACTION_CITIZENMETRO] = true
}

ix.command.Add("FactionInvite", {
    arguments = {
        ix.type.player,
        ix.type.number
    },
    description = "Пригласить во фракцию",
    OnRun = function(self, client, target, faction)
        local character = target:GetCharacter()

        if !cmd_groups[client:GetUserGroup()] or not WhoCanInvite[character:GetFaction()]   then return end
        
        if SERVER then
        
			local tbl = {
				inviter = client,
				faction = faction
			}
        
			target.invite_faction = faction
        
			net.Start("SendFactionInvite")
				net.WriteTable(tbl)
			net.Send(target)
        end
        
    end
})

if SERVER then
	util.AddNetworkString("SendFactionInvite")
	
	net.Receive( "SendFactionInvite", function(len, ply)
	
		if ply.invite_faction and ix.faction.indices[ply.invite_faction] then
			local char = ply:GetCharacter()
			char:SetFaction(ply.invite_faction)
			char:SetRank(1)
			ply:SetWhitelisted(ply.invite_faction, true)
			ply.invite_faction = nil
		end
		
	end)
	
end

if CLIENT then

	local function GetFactionPlayers(faction)
	
		local tbl = {}
	
		for i, v in ipairs( player.GetAll() ) do
			if v:GetCharacter() and v:GetCharacter():GetFaction() == faction then
				tbl[#tbl+1] = v
			end
		end
		
		return tbl
		
	end
	
	local function GetNibbasToInvite(pos)
		
		local tbl = {}
	
		for i, v in ipairs( player.GetAll() ) do
			if v:GetCharacter() and WhoCanInvite[v:GetCharacter():GetFaction()]  then
				if v:GetPos():Distance(pos) < invite_radius then
					tbl[#tbl+1] = v
				end
			end
		end
		
		return tbl
		
	end
	
	local panel = nil
	local buttons_list = nil
	
	local function SettingsPopup(client, ply_button, ptype)
	
		local char = client:GetCharacter()
		local factionTable = ix.faction.Get(char:GetFaction())
	
		local panel2 = panel:Add("DFrame")
		if ptype == 1 then
			panel2:SetTitle( "Изменить Ранг" )
			panel2:SetSize(ply_button:GetWide(), 256)
		elseif ptype == 2 then
			panel2:SetTitle( "Изменить Ник" )
			panel2:SetSize(ply_button:GetWide(), 64)
		elseif ptype == 3 then
			panel2:SetTitle( "Пригласить" )
			panel2:SetSize(ply_button:GetWide(), 512)
		else
			panel2:SetTitle( "" )
		end
		panel2:ShowCloseButton(false)
		panel2:SetDraggable( false )
		local x, y = ply_button:LocalToScreen()
		
		if ptype == 3 then
			panel2:SetPos(x, y-512)
		else
			panel2:SetPos(x, y+64)
		end
		
		panel2.NxtFocusCheck = CurTime() + 0.2
		panel2:MakePopup()
		
		function panel2:Think()
			if !panel2:HasHierarchicalFocus() and panel2.NxtFocusCheck < CurTime() then
				panel2:Remove()
				panel2 = nil
			end
		end
		
		if ptype == 1 then
			local list = vgui.Create( "DScrollPanel", panel2 )
			list:Dock( FILL )
			list:DockMargin( 8, 8, 8, 8 )
			
			for k, v in pairs(factionTable.Ranks) do
			
				local ply_button = list:Add( "DButton" )
				
				ply_button:SetText( v[1] )
				
				ply_button:SetSize( 64, 64 )
				ply_button:Dock(TOP)
				
				function ply_button:DoClick()
					ix.command.Send("CharRank", client:GetName(), k)
					panel.RebuildDelay = CurTime() + 0.1
					panel.ToRebuild = true
					panel2:Remove()
					panel2 = nil
				end
				
			end
		
		elseif ptype == 2 then
			local TextEntry = vgui.Create( "DTextEntry", panel2 )
			TextEntry:Dock( TOP )
			TextEntry:SetText(client:GetName())
			
			TextEntry.OnEnter = function( self )
				ix.command.Send("CharSetName", client:GetName(), TextEntry:GetValue())
				panel.RebuildDelay = CurTime() + 0.1
				panel.ToRebuild = true
				panel2:Remove()
				panel2 = nil
			end
		elseif ptype == 3 then
		
			local list = vgui.Create( "DScrollPanel", panel2 )
			list:Dock( FILL )
			list:DockMargin( 8, 8, 8, 8 )
			
			local players = GetNibbasToInvite(client:GetPos())
			
			for k, target in pairs(players) do
			
				local model = target:GetModel()
				local skin = target:GetSkin()
				local name = target:GetName()
			
				local ply_button = list:Add( "DButton" )
				
				ply_button:SetText( "" )
				ply_button:SetSize( 64, 64 )
				ply_button:Dock(TOP)
				ply_button.CurBool = false
				
				function ply_button:Paint( w, h )
				
					if not IsValid(target) or target == nil or !target then
						draw.SimpleText( "Вышел", "ixBigFont", 96, 16, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
						return
					end
				
					draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
					
					if ply_button.CurBool or ply_button.Pressed then
						draw.RoundedBox( 0, 0, h-6, w, 6, Color( 255, 255, 153, 255 ) )
					end
					
					draw.SimpleText( name, "ixBigFont", 96, 16, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					
				end
				
				function ply_button:DoClick()
				
					ix.command.Send("FactionInvite", target:GetName(), char:GetFaction())
				
					panel2:Remove()
					panel2 = nil
				end
				
				ply_button.OnCursorEntered = function() ply_button.CurBool = true end
				ply_button.OnCursorExited = function() ply_button.CurBool = false end
				
				local icon = ply_button:Add("ixScoreboardIcon")
				icon:SetMouseInputEnabled(false)
				for _, v in pairs(target:GetBodyGroups()) do
					icon:SetBodygroup(v.id, target:GetBodygroup(v.id))
				end

				if (icon:GetModel() != model or icon:GetSkin() != skin) then
					icon:SetModel(model, skin)
					icon:SetTooltip(nil)
				end
				
			end
		
		end
		
	end
	
	local function BuildPlayerList()
	
		if buttons_list != nil then
			buttons_list:Remove()
			buttons_list = nil
		end
		
		local char = LocalPlayer():GetCharacter()
		local players = GetFactionPlayers(char:GetFaction())
	
		buttons_list = vgui.Create( "DScrollPanel", panel )
		buttons_list:Dock( FILL )
		buttons_list:DockMargin( 32, 32, ScrW()/3, 128 )
		
		for k, client in pairs(players) do
		
			if IsValid(client) and client != nil then
			
				local model = client:GetModel()
				local skin = client:GetSkin()
				local name = client:GetName()
			
				local char = client:GetCharacter()
				local factionTable = ix.faction.Get(char:GetFaction())
			
				local rank = char:GetRank()
			
				local ply_button = buttons_list:Add( "DButton" )
				
				ply_button:SetText( "" )
				ply_button.CurBool = false
				ply_button.Pressed = false
				ply_button:SetSize( 64, 64 )
				ply_button:Dock(TOP)
				
				function ply_button:Paint( w, h )
				
					if not IsValid(client) or client == nil or !client then
						panel.RebuildDelay = 0
						panel.ToRebuild = true
						return
					end
				
					draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
					
					if ply_button.CurBool or ply_button.Pressed then
						draw.RoundedBox( 0, 0, h-6, w, 6, Color( 255, 255, 153, 255 ) )
					end
					
					draw.SimpleText( name, "ixBigFont", 120, 16, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					
					if factionTable.Ranks then
						if factionTable.Ranks[rank] then
							draw.SimpleText( factionTable.Ranks[rank][1], "ixToolTipText", 120, 40, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
							if factionTable.Ranks[rank][2] then
								surface.SetDrawColor( 255, 255, 255, 255 )
								surface.SetTexture( surface.GetTextureID(factionTable.Ranks[rank][2]) )
								surface.DrawTexturedRect( 80, 0, 32, 32 )
							end
						end
					end
					
				end
				
				function ply_button:DoClick()
					
					local menu = DermaMenu()
					
					menu:AddOption( "Изменить Ник", function()
						SettingsPopup(client, ply_button, 2)
					end)
						
					if factionTable.Ranks then
						menu:AddOption( "Изменить Ранг", function()
							SettingsPopup(client, ply_button, 1)
						end)
					end
					
					menu:AddOption( "Выгнать из фракции", function()
						ix.command.Send("FactionKick", client:GetName())
					end)
					
					menu:Open()
					
				end
			
				ply_button.OnCursorEntered = function() ply_button.CurBool = true end
				ply_button.OnCursorExited = function() ply_button.CurBool = false end
			
				local icon = ply_button:Add("ixScoreboardIcon")
				icon:SetMouseInputEnabled(false)
				for _, v in pairs(client:GetBodyGroups()) do
					icon:SetBodygroup(v.id, client:GetBodygroup(v.id))
				end

				if (icon:GetModel() != model or icon:GetSkin() != skin) then
					icon:SetModel(model, skin)
					icon:SetTooltip(nil)
				end
				
			end
			
		end	
	
	end

	hook.Add("CreateMenuButtons", "ixCmdMenu", function(tabs)
	
		local ply = LocalPlayer()
		if !cmd_groups[ply:GetUserGroup()] then
			return
		end

		tabs["cmd"] = function(container)
		
			local char = ply:GetCharacter()
			local faction = ix.faction.Get(char:GetFaction())
		
			panel = container:Add("DFrame")
			panel:Dock(FILL)
			panel:ShowCloseButton(false)
			panel:SetPos(0, 0)
			panel:SetTitle( "" )
			panel:SetDraggable( false )
			
			panel.RebuildDelay = 0
			panel.ToRebuild = true
			
			panel.Paint = function( self, w, h )
				--draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0, 100) )
				draw.SimpleText( faction.name, "ixBigFont", 32, 18, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
				if panel.RebuildDelay < CurTime() and panel.ToRebuild then
					BuildPlayerList()
					panel.ToRebuild = false
				end
			end

			local invite_button = panel:Add( "DButton" )
			
			invite_button:SetText( "" )
			invite_button.CurBool = false
			invite_button:SetSize( (ScrW()/3)-32, 64 )
			invite_button:SetPos(38, container:GetTall()-96)
			
			function invite_button:Paint( w, h )
			
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
				
				if invite_button.CurBool then
					draw.RoundedBox( 0, 0, h-6, w, 6, Color( 153, 255, 102, 255 ) )
				end
				
				draw.SimpleText( "Пригласить во фракцию", "ixBigFont", 32, 32, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
				
			end

			invite_button.OnCursorEntered = function() invite_button.CurBool = true end
			invite_button.OnCursorExited = function() invite_button.CurBool = false end

			function invite_button:DoClick()
				SettingsPopup(ply, invite_button, 3)
			end
			
			local offline_button = panel:Add( "DButton" )
			
			offline_button:SetText( "" )
			offline_button.CurBool = false
			offline_button:SetSize( (ScrW()/3)-50, 64 )
			offline_button:SetPos(ScrW() * 0.4, container:GetTall()-96)
			
			function offline_button:Paint( w, h )
			
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
				
				if offline_button.CurBool then
					draw.RoundedBox( 0, 0, h-6, w, 6, Color( 153, 255, 102, 255 ) )
				end
				
				draw.SimpleText( "Игроки оффлайн", "ixBigFont", 32, 32, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
				
			end

			offline_button.OnCursorEntered = function() offline_button.CurBool = true end
			offline_button.OnCursorExited = function() offline_button.CurBool = false end

			function offline_button:DoClick()
				ix.command.Send("OfflineChar")
			end

		end
				
	end)
	
	local function OpenFactionInvite(tbl)
	
		local faction = ix.faction.Get(tbl.faction)
	
		local panel = vgui.Create("DFrame")
		panel:SetSize(512, 256)
		panel:ShowCloseButton(true)
		panel:SetTitle( "" )
		panel:SetDraggable( true )
		panel:Center()
		panel:MakePopup()
		
		panel.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0, 200) )
			draw.SimpleText( "Вас пригласили во фракцию:", "ixBigFont", 256, 64, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( faction.name, "ixBigFont", 256, 96, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		
		local accept = panel:Add( "DButton" )
		
		accept:SetText( "" )
		accept.CurBool = false
		accept:SetSize( 240, 32 )
		accept:SetPos(256-245, panel:GetTall()-64)
		
		function accept:Paint( w, h )
		
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
			
			if accept.CurBool then
				draw.RoundedBox( 0, 0, 0, w, h, Color( 153, 255, 102, 50 ) )
			end
			
			draw.SimpleText( "Принять", "ixMenuButtonLabelFont", 120, 16, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end

		accept.OnCursorEntered = function() accept.CurBool = true end
		accept.OnCursorExited = function() accept.CurBool = false end

		function accept:DoClick()
			net.Start("SendFactionInvite")
			net.SendToServer()
			panel:Close()
		end
		
		--==============================================================
		
		local decline = panel:Add( "DButton" )
		
		decline:SetText( "" )
		decline.CurBool = false
		decline:SetSize( 240, 32 )
		decline:SetPos(256+5, panel:GetTall()-64)
		
		function decline:Paint( w, h )
		
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
			
			if decline.CurBool then
				draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 80, 80, 50 ) )
			end
			
			draw.SimpleText( "Отклонить", "ixMenuButtonLabelFont", 120, 16, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end

		decline.OnCursorEntered = function() decline.CurBool = true end
		decline.OnCursorExited = function() decline.CurBool = false end

		function decline:DoClick()
			panel:Close()
		end
		
	end
	
	net.Receive( "SendFactionInvite", function(len)
	
		local ply = LocalPlayer()
		local tbl = net.ReadTable()
		
		OpenFactionInvite(tbl)
		
	end)
	
end
