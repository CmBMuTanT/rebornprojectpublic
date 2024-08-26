util.AddNetworkString( "chicken_particles" );

hook.Add( "EntityFireBullets", "chicken_shotsfired", function( ent, data )
	for k, v in pairs( ents.FindByClass( "npc_chicken" ) ) do
		if ( ent:GetPos():Distance( v:GetPos() ) < 1000 and !v:GetPanick() and !v.HasPanicked and v.Init < CurTime() ) then
			v.Panicking = true;
		end
	end
end );
