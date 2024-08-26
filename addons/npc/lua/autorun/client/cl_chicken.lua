local function balloonparticles( pos )
	local efx = EffectData();
		efx:SetStart( pos );
		efx:SetOrigin( pos );
	util.Effect( "balloon_pop", efx );
end

net.Receive( "chicken_particles", function()
	balloonparticles( net.ReadVector() );
end );
