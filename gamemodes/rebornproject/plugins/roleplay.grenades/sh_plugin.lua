PLUGIN.name = "Flaers"
PLUGIN.author = "Black Tea"
PLUGIN.desc = "Flaers Throwables"

if (SERVER) then
	function PLUGIN:PlayerSpawn(client)
		client:SetNetVar("teargas", 0)
	end

	function PLUGIN:PlayerDeath(client)
		client:SetNetVar("teargas", 0)
	end

	function PLUGIN:CanPlayerHoldObject(client, entity)
		if (entity.isGrenade) then
			return true
		end
	end
end