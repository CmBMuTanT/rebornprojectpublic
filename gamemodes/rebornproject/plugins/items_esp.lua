
PLUGIN.name = "Items Names"
PLUGIN.author = "zig"
PLUGIN.description = "Показывает названия предметов, лежащих на земле."

if CLIENT then
	PLUGIN.ToDraw = {}

	function PLUGIN:CharacterLoaded()
		timer.Create( "find_draw_items", 1, 0, function()
			table.Empty( self.ToDraw )

			for k, v in next, ents.FindInSphere( LocalPlayer():GetPos(), 192 ) do
				if IsValid( v ) and v:GetClass() == "ix_item" and v.PopulateEntityInfo then
					table.insert( self.ToDraw, v )
				end
			end
		end )
	end

	function PLUGIN:HUDPaint()
		if LocalPlayer():KeyDown( IN_USE ) then
			for k, v in next, self.ToDraw do
				if IsValid( v ) then
					local itm_tbl = v:GetItemTable()

					if itm_tbl then
						local pos = v:GetPos():ToScreen()

						surface.SetFont( "DermaDefault" )
						surface.SetTextColor( 255, 255, 255 )
						surface.SetTextPos( pos.x - ( select( 2, surface.GetTextSize( itm_tbl.name ) ) * 2 ), pos.y ) 
						surface.DrawText( itm_tbl.name )
					end
				end
			end
		end
	end
end