
AddCSLuaFile( "cfg/ix_crafting_cfg.lua" )
include( 'cfg/ix_crafting_cfg.lua' )

local function CanCraft(ply, recipe)
	local v = recipe
	local bool = true
	for _, v1 in pairs(v.ingredients) do
		local checkitems = {}
		for i=1, v1.amount do
			table.insert( checkitems, v1.item )
		end
		local hasitems, tbl = ply:GetCharacter():GetInventory():HasItems(checkitems)
		if hasitems then
			v1.hasitems = true
		else
			v1.hasitems = false
			bool = false
		end
	end
	return bool
end

if SERVER then
	util.AddNetworkString("ixCraftMenu")
	util.AddNetworkString("ixCraftItem")
	util.AddNetworkString("ixDisassembleItem")
	
	net.Receive( "ixCraftItem", function( len, ply )
	
		local recipestring = net.ReadString()	
		local recipe = ix_craft_recipes[recipestring]
		
		if recipe == nil then return end
		
		local char = ply:GetCharacter()
		local inv = char:GetInventory()
		
		local cancraft = CanCraft(ply, recipe)
		
		if cancraft then
			for k, v in pairs(recipe.ingredients) do
				for i = 1, v.amount do
					local iitem = inv:HasItem(v.item)
					if !iitem.isTool then
						iitem:Remove()
					end
				end
			end
			inv:Add(recipe.result, 1)
		end
		
	end)
	
	net.Receive( "ixDisassembleItem", function( len, ply )
	
		local recipestring = net.ReadString()	
		local recipe = ix_craft_recipes[recipestring]
		
		if recipe == nil then return end
		
		local char = ply:GetCharacter()
		local inv = char:GetInventory()
		
		local taken_items = {}
		local max_items = #recipe.ingredients
		
		while max_items > 0 do
		
			local random1 = math.random(1, #recipe.ingredients)
			
			if not taken_items[random1] then
				local first_item = recipe.ingredients[random1]
				inv:Add(first_item.item, math.random(1, first_item.amount))
				taken_items[random1] = true
				max_items = max_items - math.random(1, 2)
			end
			
		end

		local iitem = inv:HasItem(recipe.result)
		if !iitem.isTool then
			iitem:Remove()
		end
		
	end)
	
end

if CLIENT then

	local accent_color = Color(177, 82, 24, 255 )
	local white_color = Color(255,255,255,255)
	local green_color = Color(51, 255, 51, 255)
	local red_color = Color(255, 51, 51, 255)

	local gear_big = Material("png/gear_512.png")
	local gear_medium = Material("png/gear_320.png")
	local gear_small = Material("png/gear_256.png")

	local gears_lerp = 0
	local gears_lerp2 = 0
	local rotation = 0
	
	local craftpanel = nil
	
	local function DrawGears(x, y)
	
		if craftpanel.finished then
			gears_lerp = Lerp(FrameTime()*5, gears_lerp, 0)
		else
			gears_lerp = Lerp(FrameTime()*25, gears_lerp, 1)
			gears_lerp2 = Lerp(FrameTime()*5, gears_lerp2, 1)
		end
		rotation = rotation+(1.5)*gears_lerp
		--local white_color = Color(255, 255, 255, 255*gears_lerp2)
		
		surface.SetDrawColor( white_color )
		surface.SetMaterial(gear_big)
		surface.DrawTexturedRectRotated( x, y, 200*gears_lerp2, 200*gears_lerp2, rotation )
		
		surface.SetMaterial(gear_medium)
		surface.DrawTexturedRectRotated( x + 100, y + 100, 120*gears_lerp2, 120*gears_lerp2, (-rotation*1.6) )
		
		surface.SetMaterial(gear_small)
		surface.DrawTexturedRectRotated( x, y + 135, 100*gears_lerp2, 100*gears_lerp2, (rotation*1.6) )
		
	end

	local function ixCraftingMenu()
	
		craftpanel = vgui.Create( "DFrame" )
		craftpanel:SetTitle( "" )
		craftpanel:SetSize( ScrW(), ScrH() )
		craftpanel:ShowCloseButton( true )
		craftpanel:SetDraggable( false )
		craftpanel:SetDeleteOnClose( true )
		
		craftpanel:Center()
		craftpanel:MakePopup()
		
		craftpanel.last_recipe = nil
		craftpanel.busy = false
		craftpanel.finished = false
		craftpanel.progress = 0
		craftpanel.maxprogress = 0
		
		craftpanel.cancraft = false
		craftpanel.isininv = false	--bruh
		craftpanel.item = nil
		
		craftpanel.Paint = function()

			draw.RoundedBox( 0, 0, 0, craftpanel:GetWide(), craftpanel:GetTall(), Color(0,0,0,200) )
			
			--draw.RoundedBox( 0, 0, 0, craftpanel:GetWide(), 64, accent_color )
				
			draw.RoundedBox( 0, 0, 0, craftpanel:GetWide(), 64, Color(0,0,0,255) )
			--draw.RoundedBox( 0, 0, 0, craftpanel:GetWide(), 128, Color(0,0,0,155) )
			draw.SimpleText( "Верстак", "ixTitleFont", 32, 32, white_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		
			if craftpanel.item != nil then
			
				draw.SimpleText( craftpanel.item.name, "ixSubTitleFont", ScrW()-64, 128, white_color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
				
				draw.RoundedBox( 0, ScrW()-364, 164, 300, 3, white_color )
				
				
				draw.SimpleText( "Требуется для сборки: ", "ixSubTitleFont", ScrW()-64, 264, white_color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
				
				--трёхэтажные таблицы сука
				for k, v in pairs(craftpanel.item.recipe.ingredients) do
				
					local name = ix.item.list[v.item].name
					
					if !v.hasitems then
						draw.RoundedBox( 0, ScrW()-332, 280 + (15*k), 10, 10, red_color )
					else
						draw.RoundedBox( 0, ScrW()-332, 280 + (15*k), 10, 10, green_color )
					end
					
					draw.SimpleText( name.." X "..v.amount, "ixMenuMiniFont", ScrW()-310, 285 + (15*k), white_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
				end
				
				local lastk = #craftpanel.item.recipe.ingredients + 1
				draw.RoundedBox( 0, ScrW()-332, 280 + (15*lastk), 10, 10, white_color )
				draw.SimpleText( "Время сборки: "..craftpanel.item.recipe.craft_time.." сек.", "ixMenuMiniFont", ScrW()-310, 285 + (15*lastk), white_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
				
				--DrawGears(ScrW()/2-20, ScrH()/2-40)
				
			else
			
				draw.SimpleText( "Ничего не выбрано", "ixSubTitleFont", ScrW()-64, 128, white_color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
			
			end
		
			if !craftpanel.busy and ( input.IsKeyDown( KEY_SPACE ) or input.IsKeyDown( KEY_ESCAPE ) ) then
				craftpanel:Close()
			end		
			
			
		
		end
	
		function craftpanel:StartAction(craft, maxtime)
			
			craftpanel.finished = false
			craftpanel.busy = true
			craftpanel.maxprogress = CurTime()+maxtime
			
			gears_lerp = 0
			gears_lerp2 = 0
					
			local text = "Сборка предмета"
			if !craft then
				text = "Разборка предмета"
			end
		
			local bar = 0
			local bar_lerp = 1
		
			if craftpanel.item != nil then
				local actionpanel = vgui.Create( "DFrame", craftpanel )
				actionpanel:SetTitle( "" )
				actionpanel:SetSize( ScrW(), ScrH() )
				actionpanel:ShowCloseButton( false )
				actionpanel:SetDraggable( false )
				actionpanel:SetDeleteOnClose( true )
				actionpanel:Center()
				actionpanel:MakePopup()	
				
				local w = actionpanel:GetWide()
				local h = actionpanel:GetTall()
				local w2 = w/2.5
				local h2 = h/1.7
				
				local cancelbutton = vgui.Create( "DButton", actionpanel )
				cancelbutton:SetText("")							
				cancelbutton:SetPos(w/2+(w2/2)-32, h/2-(h2/2))
				cancelbutton:SetSize( 32, 32 )
				
				cancelbutton.CurBool = false
				
				cancelbutton.OnCursorEntered = function() cancelbutton.CurBool = true end
				cancelbutton.OnCursorExited = function() cancelbutton.CurBool = false end
				
				cancelbutton.DoClick = function()
					actionpanel:Remove()
					craftpanel.busy = false
					craftpanel:UpdateRecipeList()
				end
				
				cancelbutton.Paint = function()
					draw.RoundedBox( 0, 0, 0, cancelbutton:GetWide(), cancelbutton:GetTall(), Color(0, 0, 0, 200) )
					
					if cancelbutton.CurBool then
						surface.SetDrawColor(red_color)
					else
						surface.SetDrawColor(white_color)
					end
					surface.DrawOutlinedRect( 0, 0, cancelbutton:GetWide(), cancelbutton:GetTall(), 1 )
					draw.SimpleText( "X", "ixSubTitleFont", cancelbutton:GetWide()/2, 16, white_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
			
				actionpanel.Paint = function()
					
					local progress = ((craftpanel.maxprogress-CurTime()) - 0)/(maxtime-0)
					
					if progress > 0 then
						bar = (h2-32)*(1-progress)
					else
						if !craftpanel.finished then
							craftpanel.finished = true
							
							if cancelbutton != nil then cancelbutton:Remove() end
							
							local acceptbutton = vgui.Create( "DButton", actionpanel )
							acceptbutton:SetText("")							
							acceptbutton:SetPos(w/2-(w2/2) + 64, h/2+(h2/2)-64)
							acceptbutton:SetSize( h2-32, 32 )
							
							acceptbutton.CurBool = false
							
							acceptbutton.OnCursorEntered = function() acceptbutton.CurBool = true end
							acceptbutton.OnCursorExited = function() acceptbutton.CurBool = false end
							
							acceptbutton.DoClick = function()
								actionpanel:Remove()
								
								if craft then
									net.Start( "ixCraftItem" )
										net.WriteString(craftpanel.last_recipe)
									net.SendToServer()
								else
									net.Start( "ixDisassembleItem" )
										net.WriteString(craftpanel.last_recipe)
									net.SendToServer()								
								end
								
								timer.Simple(0.5, function()
									if IsValid(craftpanel) then
										craftpanel.busy = false
										craftpanel:UpdateRecipeList()
									end
								end)
							end
							
							acceptbutton.Paint = function()
								draw.RoundedBox( 0, 0, 0, acceptbutton:GetWide(), acceptbutton:GetTall(), Color(0, 0, 0, 200) )
								
								if acceptbutton.CurBool then
									surface.SetDrawColor(accent_color)
								else
									surface.SetDrawColor(white_color)
								end
								surface.DrawOutlinedRect( 0, 0, acceptbutton:GetWide(), acceptbutton:GetTall(), 1 )
								draw.SimpleText( "Взять", "ixSubTitleFont", acceptbutton:GetWide()/2, 16, white_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
							end
							
						end
					end
					
					if craftpanel.finished then 
						bar_lerp = Lerp(FrameTime()*5, bar_lerp, 0)
					end
					
					--local time = string.FormattedTime( (craftpanel.maxprogress-CurTime()), "%02i:%02i" )
					
					draw.RoundedBox( 0, w/2-(w2/2), h/2-(h2/2), w2, h2, Color(0,0,0,200) )
					draw.RoundedBox( 0, w/2-(w2/2), h/2-(h2/2), w2, 32, Color(0,0,0,255) )
					
					draw.SimpleText( text, "ixMenuMiniFont", w/2-(w2/2)+16, h/2-(h2/2)+16, white_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					
					DrawGears(ScrW()/2-20, ScrH()/2-50)
					
					surface.SetDrawColor(Color(255,255,255,255*bar_lerp))
					surface.DrawOutlinedRect( w/2-(w2/2) + 64, h/2+(h2/2)-64, w2-128, 32, 1 )
					draw.RoundedBox( 0, w/2-(w2/2) + 64, h/2+(h2/2)-64, bar, 32, Color(255,255,255,200*bar_lerp) )
					
				end
			end
		end
		
		local craft_button = nil
		local decraft_button = nil
		
		local function UpdateButtons()
			
			if craft_button != nil then craft_button:Remove() end
			if decraft_button != nil then decraft_button:Remove() end
			if craftpanel.busy then return end
			
			if craftpanel.cancraft then
				craft_button = vgui.Create( "DButton", craftpanel )
				craft_button:SetText("")
				if craftpanel.isininv then
					craft_button:SetPos(ScrW()/2-256, ScrH() - 64)
				else
					craft_button:SetPos(ScrW()/2-128, ScrH() - 64)
				end
				craft_button:SetSize( 256, 50 )
				
				craft_button.CurBool = false
				
				craft_button.OnCursorEntered = function() craft_button.CurBool = true end
				craft_button.OnCursorExited = function() craft_button.CurBool = false end
				
				craft_button.DoClick = function()
					craftpanel:StartAction(true, craftpanel.item.recipe.craft_time)
					UpdateButtons()
				end
				
				craft_button.Paint = function()
					draw.RoundedBox( 0, 0, 0, craft_button:GetWide(), craft_button:GetTall(), Color(0, 0, 0, 200) )
					
					if craft_button.CurBool then
						surface.SetDrawColor(accent_color)
					else
						surface.SetDrawColor(white_color)
					end
					surface.DrawOutlinedRect( 0, 0, craft_button:GetWide(), craft_button:GetTall(), 1 )
					draw.SimpleText( "Собрать", "ixSubTitleFont", craft_button:GetWide()/2, 25, white_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
				
			end
			
			if craftpanel.isininv then
				decraft_button = vgui.Create( "DButton", craftpanel )
				decraft_button:SetText("")
				if craftpanel.cancraft then
					decraft_button:SetPos(ScrW()/2, ScrH() - 64)
				else
					decraft_button:SetPos(ScrW()/2-128, ScrH() - 64)
				end
				decraft_button:SetSize( 256, 50 )
				
				decraft_button.CurBool = false
				
				decraft_button.OnCursorEntered = function() decraft_button.CurBool = true end
				decraft_button.OnCursorExited = function() decraft_button.CurBool = false end
				
				decraft_button.DoClick = function()
					craftpanel:StartAction(false, craftpanel.item.recipe.craft_time/2)
					UpdateButtons()
				end
				
				decraft_button.Paint = function()
					draw.RoundedBox( 0, 0, 0, decraft_button:GetWide(), decraft_button:GetTall(), Color(0, 0, 0, 200) )
					
					if decraft_button.CurBool then
						surface.SetDrawColor(accent_color)
					else
						surface.SetDrawColor(white_color)
					end
					surface.DrawOutlinedRect( 0, 0, decraft_button:GetWide(), decraft_button:GetTall(), 1 )
					draw.SimpleText( "Разобрать", "ixSubTitleFont", decraft_button:GetWide()/2, 25, white_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end	
			end
			
		end
	
		local description = nil
	
		local function UpdateDesc(txt)
			if description == nil then
				description = vgui.Create( "RichText", craftpanel )
				
				description:SetSize( 300, 60 )
				description:SetPos( ScrW()-364, 170 )
				description:SetVerticalScrollbarEnabled(false)
				description:SetMouseInputEnabled(false)
				
				function description:PerformLayout()
					description:SetFontInternal( "ixMenuMiniFont" ) 
				end		
				description:InsertColorChange( 255, 255, 255, 255 )
				description:AppendText( txt )
			else
				description:SetText("")
				description:InsertColorChange( 255, 255, 255, 255 )
				description:AppendText( txt )
			end
		end
		
		local item_mdl = nil
		
		local function UpdateItemModel(mdl)
			if item_mdl == nil then
			
				local m_size = ScrH()*0.7
				item_mdl = vgui.Create( "DModelPanel", craftpanel )
				item_mdl:SetSize( m_size, m_size )
				item_mdl:SetPos( ScrW()/2-m_size/2, (ScrH()/2)-m_size/2 )
				item_mdl:SetMouseInputEnabled( false )
				
				function item_mdl:LayoutEntity( Entity ) 			
					Entity:SetAngles(Angle(0, 0, 0) )
				end
						
			end
				item_mdl:SetModel( mdl )
				local mn, mx = item_mdl.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
						
				item_mdl:SetFOV( 60 )
				item_mdl:SetCamPos( Vector( size, size, size ) )
				item_mdl:SetLookAt( ( mn + mx ) * 0.5 )
		end

		local list = nil
		
		function craftpanel:UpdateRecipeList()
		
			if list != nil then list:Remove() end
		
			list = vgui.Create( "DScrollPanel", craftpanel )
			list:Dock( FILL )
			list:DockMargin( 16, 64, ScrW()-380, 16 )

			local sbar = list:GetVBar()
			
			function sbar:Paint( w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
			end
			function sbar.btnUp:Paint( w, h )
				draw.RoundedBox( 0, 0, 0, w, h, accent_color )
			end
			function sbar.btnDown:Paint( w, h )
				draw.RoundedBox( 0, 0, 0, w, h, accent_color )
			end
			function sbar.btnGrip:Paint( w, h )
				draw.RoundedBox( 0, 0, 0, w, h, accent_color )
			end	
		
			local num = 0
			
			for k, v in pairs(ix_craft_recipes) do
			
				local data = ix.item.list[v.result]
			
				local item = list:Add( "DButton" )
				item:SetText("")
				item:SetPos(0, 0 + (100*num))
				item:SetSize( 332, 96 )
				
				item.CurBool = false
				
				item.recipe = v
				item.cancraft = CanCraft(LocalPlayer(), item.recipe)
				item.ininv = LocalPlayer():GetCharacter():GetInventory():HasItem(item.recipe.result)
				
				item.OnCursorEntered = function() item.CurBool = true end
				item.OnCursorExited = function() item.CurBool = false end
				
				function item:SelectRecipe()
					UpdateItemModel(data.model)
				
					craftpanel.item = data
					craftpanel.cancraft = item.cancraft
					craftpanel.item.recipe = item.recipe
					craftpanel.isininv = item.ininv
					
					UpdateDesc(data.description)
					UpdateButtons()
				end
				
				if craftpanel.last_recipe != nil and craftpanel.last_recipe == k then
					item:SelectRecipe()
				end
				
				item.DoClick = function()
				
					if craftpanel.busy then return end
					
					item:SelectRecipe()
					craftpanel.last_recipe = k
					
				end
				
				item.Paint = function()
				
					draw.RoundedBox( 0, 0, 0, item:GetWide(), item:GetTall(), Color(0, 0, 0, 200) )
					
					if item.CurBool then
						surface.SetDrawColor(accent_color)
					else
						if item.cancraft then
							surface.SetDrawColor(white_color)
						else
							surface.SetDrawColor(red_color)
						end
					end
					surface.DrawOutlinedRect( 0, 0, item:GetWide(), item:GetTall(), 1 )
					
					draw.SimpleText( data.name, "ixMenuButtonFont", 100, 32, white_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					if item.ininv then
						draw.SimpleText( "Есть в инвентаре", "ixMenuMiniFont", 100, 55, white_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					else
						draw.SimpleText( "Нет в инвентаре", "ixMenuMiniFont", 100, 55, white_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					end
				end
				
					local icon = vgui.Create( "DModelPanel", item )
					icon:SetSize( 96, 96 )
					icon:SetPos( 0, 0 )
					icon:SetModel( data.model )
					icon:SetMouseInputEnabled( false )
					local mn, mx = icon.Entity:GetRenderBounds()
					local size = 0
					size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
					size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
					size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

					function icon:LayoutEntity( Entity ) 
											
						Entity:SetAngles(Angle(0, 0, 0) )
						
						icon:SetColor( Color( 255, 255, 255 ) )
						
						Entity:SetMaterial("engine/singlecolor")
						
					end
							
					icon:SetFOV( 50 )
					icon:SetCamPos( Vector( size, size, size ) )
					icon:SetLookAt( ( mn + mx ) * 0.5 )
				
				num = num+1
				
			end
		
		end
		
		craftpanel:UpdateRecipeList()
	end

	net.Receive( "ixCraftMenu", function( len )
		ixCraftingMenu()
	end)

end
