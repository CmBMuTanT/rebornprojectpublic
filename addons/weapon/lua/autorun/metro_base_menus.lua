
AddCSLuaFile()
--AddCSLuaFile( "metro_base_attachments.lua" )

AddCSLuaFile( "cfg/metro_base_attachments.lua" )
include( "cfg/metro_base_attachments.lua" )

AddCSLuaFile( "cfg/attachments_addon.lua" )
include("cfg/attachments_addon.lua")

hook.Add( "PostGamemodeLoaded", "PostGamemodeLoadedAtt", function()
	MakeAtts()
end)

--MakeAtts()

if CLIENT then
	
surface.CreateFont( "MetroInventoryFont4", {
    font = "Impact",
    extended = true,
    size = 15,
    weight = 250,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
} )

surface.CreateFont( "MetroInventoryFont1", {
    font = "Impact",
    extended = true,
    size = 20,
    weight = 250,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
} )

surface.CreateFont( "MetroInventoryFont2", {
    font = "Impact",
    extended = true,
    size = 25,
    weight = 250,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
} )

surface.CreateFont( "MetroInventoryFont3", {
    font = "Impact",
    extended = true,
    size = 35,
    weight = 250,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
} )
	
	local nxt_menu = 0
	
	local function GetDmg(wep)
		return math.Clamp( ((wep.Primary.Damage*(wep.Primary.NumShots*0.5))*wep.Primary.TakeAmmo) , 1, 30 )
	end
	
	local function GetAccuracy(wep)
		return math.Clamp(25-((wep.Primary.Recoil+wep.SightsConeMul+wep.Primary.Cone)*10), 1, 30)
	end
	
	local function GetFireRate(wep)
		return math.Clamp((1 - wep.Primary.Delay)*10, 1, 30)
	end
	
	local function GetMagSize(wep)
		return math.Clamp(wep.Primary.ClipSize*0.4, 1, 30)
	end
	
	function OpenAttMenu(wep)
		
		local ply = LocalPlayer()
		--local wep = ply:GetActiveWeapon()
		if ( not IsValid(wep) ) or wep:GetNextReload() > CurTime() or !ply:OnGround() then return end
		
		ply.inventory = true
		wep.InMenu = true
		
		nxt_menu = CurTime() + 0.3
		local nxt_att = 0
	
		local panel = vgui.Create( "DFrame" )
		panel:SetTitle( "" )
		panel:SetSize( ScrW(), ScrH() )
		panel:ShowCloseButton( true )
		panel:SetDraggable( false )
		panel:SetDeleteOnClose( true )

		panel:Center()
		panel:MakePopup()
		
		surface.PlaySound("weapons/weapon_change_interface.mp3")
	
		local richtext = vgui.Create( "RichText", panel )
		richtext:SetPos( 370, ScrH()-150 )
		richtext:SetSize( 340, 140 )

		local cur_att = ""

		function richtext:PerformLayout()
			richtext:SetFontInternal( "MetroInventoryFont1" ) 													
		end
		
		--LocalPlayer().inventory = true
		
		local attachments = {}
		local cat_num = 0
		local cur_atts = wep.CurrentAttachments
		local cur_butt = nil
		
		local inv = ply:GetCharacter():GetInventory()
		
		local last_acc = 0
		local last_dmg = 0
		local last_frate = 0
		local last_mag = 0
		
			for k, v in pairs(wep.PossibleAttachments) do
				if all_attachments[k] != nil then
					
					local atype = all_attachments[k].atype
					
					if atype != "planka" then
						if attachments[atype] == nil then
							attachments[atype] = {}
						end
						
						if ((inv:GetItemCount(all_attachments[k].item) > 0) or v.default) and !v.verstak then
							attachments[atype][k] = v
						end
					end
				end
			end
		
			for k, v in pairs(attachments) do

				if not table.IsEmpty(attachments[k]) then
		
					local button = panel:Add( "DButton" )
					button:SetText( "" )
					button:SetPos(64, ScrH()/2 -200 + (75*cat_num))
					button:SetSize( 70, 70 )
					
					if cat_num >= 5 then
						button.x = button.x + 80
						button.y = button.y - (75*5)
					end
					
					button.atts = {}
					button.frst_att = nil
					button.cat = k
					
					button.selected = nil
					
					button.pressed = false
					
					button.catlerp = 0
					button.num = 0
					
					cat_num = cat_num + 1
					
					for k, v in pairs(attachments[k]) do
						button.atts[k] = v
						if button.frst_att == nil then button.frst_att = k end
					end
					
					button.Paint = function()
						
						if cur_atts[k] != nil then
							surface.SetTexture( surface.GetTextureID( all_attachments[cur_atts[k].name].cl_data.icon ) )				
						else
							surface.SetTexture( surface.GetTextureID( all_attachments[button.frst_att].cl_data.icon ) )					
						end
						
						if button.pressed then
							surface.SetDrawColor( Color(177, 82, 24, 255 ) )
							button.catlerp = math.Approach(button.catlerp, 1, FrameTime()*10)
						else
							if cur_atts[k] != nil then
								surface.SetDrawColor( Color(255,255,255,255) )
							else
								surface.SetDrawColor( Color(120,120,120,255) )
							end
							button.catlerp = math.Approach(button.catlerp, 0, FrameTime()*10)
							
						end
						
						surface.DrawTexturedRectRotated( button:GetWide()/2, button:GetTall()/2, button:GetWide() - (15-(15*button.catlerp)), button:GetTall() - (15-(15*button.catlerp)), 0 )
						
					end
					
					button.DoClick = function()
					
						if nxt_att > CurTime() then return end
						
						if button.pressed then 
							button.pressed = false
							button.selected = nil
							nxt_att = CurTime() + 0.1
							return 
						else
							if cur_butt != nil then
								cur_butt.pressed = false
								cur_butt = nil
							end
						end
						
						button.pressed = true
						
						cur_butt = button
						
						button.num = 0
						nxt_att = CurTime() + 0.1
						
						for k, v in pairs(button.atts) do
							button.num = button.num + 1
							
							local x, y = button.x, button.y

							local att = panel:Add( "DButton" )
							
							att:SetText( "" )
							att:SetSize( 70, 70 )	
							att:SetPos(x, y)			
							att.num = button.num
							
							local icon = all_attachments[k].cl_data.icon
							
							att.DoClick = function()
							
								--if (v.default and #button.atts <= 0) then return end
								if nxt_att > CurTime() or button.catlerp < 0.5 then return end
								nxt_att = CurTime() + 0.1
								
								if wep.CurrentAttachments[button.cat] != nil and wep.CurrentAttachments[button.cat].name == k then
									if button.cat != "mag" then
									
										surface.PlaySound("weapons/weapon_change_interface_1.mp3")
									
										net.Start( "SetAttachment" )
											net.WriteString(button.cat)
											net.WriteString("none")
										net.SendToServer()	
									end				
								else
								
									surface.PlaySound("weapons/weapon_change_interface_1.mp3")
									
									net.Start( "SetAttachment" )
										net.WriteString(button.cat)
										net.WriteString(k)
									net.SendToServer()
									--cur_atts = wep.CurrentAttachments
								end
								
							end
											
							att.Paint = function()
								att:SetPos(x + ((80*att.num)*button.catlerp), y )
								
								if cur_atts[button.cat] != nil and cur_atts[button.cat].name == k then
									surface.SetDrawColor( Color(255, 255, 255, 255 ) )
									button.selected = cur_atts[button.cat]
									button.selected_x = att.x
									button.selected_y = att.y
								else
									surface.SetDrawColor( Color(120,120,120,255) )
									
									if cur_atts[button.cat] == nil or !cur_atts[button.cat].name then
										button.selected = nil
									end
									
								end
								surface.SetTexture( surface.GetTextureID( icon ) )	
								surface.DrawTexturedRectRotated( att:GetWide()/2, att:GetTall()/2, att:GetWide(), att:GetTall(), 0 )
								
								if !button.pressed and button.catlerp < 0.1 then
									att:Remove()
								end
								
							end
							
						end
					
					end
					
				end
			end
		
		panel.Paint = function()
		
			local ply = LocalPlayer()
			local wep = ply:GetActiveWeapon()
			if ( not IsValid(wep) ) or wep:GetNextReload() > CurTime() then return end
			--draw.RoundedBox( 0, 0, 0, panel:GetWide(), panel:GetTall(), Color(0,0,0,155) )
			
			--surface.SetDrawColor( Color(255,255,255,255) )
			--surface.SetTexture( surface.GetTextureID("ui/ui_inventory_background") )	
			--surface.DrawTexturedRectRotated( panel:GetWide()/2, panel:GetTall()/2, panel:GetWide(), panel:GetTall(), 0 )

			draw.RoundedBox( 0, 32, 16, panel:GetWide()-64, 32, Color(0,0,0,255) )
			--draw.RoundedBox( 0, 0, 0, panel:GetWide(), 128, Color(0,0,0,155) )
			draw.RoundedBox( 0, (panel:GetWide()-panel:GetWide()/4)-31, 16, (panel:GetWide()/4), 32, Color(177, 82, 24, 255 ) )
			draw.SimpleText( wep.PrintName, "MetroInventoryFont2", panel:GetWide()-64, 32, Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
			
			if cur_butt != nil then
				draw.RoundedBox( 0, cur_butt.x + 32, cur_butt.y + 16, (cur_butt.num*80)*cur_butt.catlerp, 32, Color(0,0,0,255) )
				
				draw.RoundedBox( 0, 360, ScrH()-180, 350, 170, Color(0,0,0,200) )
				
				if cur_butt.selected != nil and cur_butt.pressed then
					draw.SimpleText( all_attachments[cur_butt.selected.name].name, "MetroInventoryFont2", 370, ScrH()-160, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )		
					surface.SetDrawColor( Color(177, 82, 24, 255 ) )
					surface.SetTexture( surface.GetTextureID( "metroui/hud/icon_triangle" ) )	
					surface.DrawTexturedRectRotated( cur_butt.selected_x + 60, cur_butt.selected_y+9, 39, 39, 0 )
					
					if cur_att != cur_butt.selected.name then
						cur_att = cur_butt.selected.name
						richtext:SetText(all_attachments[cur_butt.selected.name].desc)
					end
				else
					if cur_att != "" then
						cur_att = ""
						richtext:SetText("")
					end
				end

			end
			
			draw.RoundedBox( 0, 64, ScrH()-180, 280, 170, Color(0,0,0,255) )
			draw.RoundedBox( 0, 64, ScrH()-180, 4, 170, Color(255,255,255,255) )

			local dmg = GetDmg(wep)

			if last_dmg == 0 or dmg < last_dmg then
				last_dmg = dmg
			end
			
			draw.SimpleText( "УРОН", "MetroInventoryFont2", 88, ScrH()-160, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			for i = 1, dmg do
				if i > last_dmg then
					draw.RoundedBox( 0, 80 + 8*i, ScrH()-150, 6, 12, Color(255, 255, 255, 255 ) )
				else
					draw.RoundedBox( 0, 80 + 8*i, ScrH()-150, 6, 12, Color(177, 82, 24, 255 ) )	
				end		
			end
			
			local acc = GetAccuracy(wep)
			
			if last_acc == 0 or acc < last_acc then
				last_acc = acc
			end
			
			draw.SimpleText( "ТОЧНОСТЬ", "MetroInventoryFont2", 88, ScrH()-125, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			for i = 1, acc do
				if i > last_acc then
					draw.RoundedBox( 0, 80 + 8*i, ScrH()-115, 6, 12, Color(255, 255, 255, 255 ) )		
				else
					draw.RoundedBox( 0, 80 + 8*i, ScrH()-115, 6, 12, Color(177, 82, 24, 255 ) )	
				end
			end
			
			local frate = GetFireRate(wep)
			
			if last_frate == 0 or frate < last_frate then
				last_frate = frate
			end
			
			draw.SimpleText( "СКОРОСТРЕЛЬНОСТЬ", "MetroInventoryFont2", 88, ScrH()-90, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			for i = 1, frate do	
				if i > last_frate then
					draw.RoundedBox( 0, 80 + 8*i, ScrH()-80, 6, 12, Color(255, 255, 255, 255 ) )
				else
					draw.RoundedBox( 0, 80 + 8*i, ScrH()-80, 6, 12, Color(177, 82, 24, 255 ) )	
				end
			end			
			
			local mag = GetMagSize(wep)
			
			if last_mag == 0 or mag < last_mag then
				last_mag = mag
			end
			
			draw.SimpleText( "МАГАЗИН ", "MetroInventoryFont2", 88, ScrH()-55, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			for i = 1, mag do
				if i > last_mag then
					draw.RoundedBox( 0, 80 + 8*i, ScrH()-45, 6, 12, Color(255, 255, 255, 255 ) )
				else
					draw.RoundedBox( 0, 80 + 8*i, ScrH()-45, 6, 12, Color(177, 82, 24, 255 ) )
				end
			end			
			--draw.RoundedBox( 0, 64, ScrH()-140, 210, 64, Color(0,0,0,255) )
						
			--draw.SimpleText( "Esc/Пробел", "MetroInventoryFont2", 80, ScrH()-110, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )	
			--draw.SimpleText( "ВЫХОД", "MetroInventoryFont2", 190, ScrH()-110, Color(255, 102, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )	
				
			if ( input.IsKeyDown( KEY_SPACE ) or input.IsKeyDown( KEY_ESCAPE ) or input.IsKeyDown( KEY_C ) ) and nxt_menu < CurTime() then
				surface.PlaySound("weapons/weapon_change_interface_0.mp3")
				panel:Close()
				ply.inventory = false
				wep.InMenu = false
			end
							
		end
	end

end
