hook.Add( "PreDrawHalos", "drawpartyhalo", function() 
	if party.halos and GetConVar( "party_lowend" ):GetInt() == 0 then
		local halod = {}
		if parties != nil and parties[LocalPlayer():GetParty()] != nil and parties[LocalPlayer():GetParty()].members != nil then
			for v,k in pairs (parties[LocalPlayer():GetParty()].members) do
				local member = player.GetBySteamID64(k)
				if member !=  false and member != LocalPlayer() and member:Alive() then
					table.insert(halod, member)
				end
			end
		end
		halo.Add(halod, Color(GetConVar( "color_phalo_r" ):GetInt(),GetConVar( "color_phalo_g" ):GetInt(),GetConVar( "color_phalo_b" ):GetInt(),GetConVar( "color_phalo_a" ):GetInt()), 2, 2, 5)
	end
end)
 


hook.Add( "PostDrawOpaqueRenderables", "paintspritesparty", function()
	if party.halos and GetConVar( "party_lowend" ):GetInt() == 1 then
		if parties != nil and parties[LocalPlayer():GetParty()] != nil and parties[LocalPlayer():GetParty()].members != nil then
			for v,k in pairs (parties[LocalPlayer():GetParty()].members) do
				local member = player.GetBySteamID64(k)
				if member !=  false and member != LocalPlayer() and member:Alive() then
					local partymemberpos = member:GetPos()
					cam.Start3D2D(partymemberpos + Vector(0,0,1), Angle( 0, 0, 0 ), 1) 
						surface.DrawCircle( 0, 0, 20 ,Color(GetConVar( "color_phalo_r" ):GetInt(),GetConVar( "color_phalo_g" ):GetInt(),GetConVar( "color_phalo_b" ):GetInt(),GetConVar( "color_phalo_a" ):GetInt()) )
					cam.End3D2D()
				end
			end
		end
	end
end )