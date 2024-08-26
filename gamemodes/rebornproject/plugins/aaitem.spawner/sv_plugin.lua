local PLUGIN = PLUGIN

PLUGIN.spawner = PLUGIN.spawner or {}
PLUGIN.spawner.positions = PLUGIN.spawner.positions or {}

util.AddNetworkString("ixItemSpawnerManager")
util.AddNetworkString("ixItemSpawnerDelete")
util.AddNetworkString("ixItemSpawnerGoto")
util.AddNetworkString("ixItemSpawnerSpawn")

function PLUGIN:LoadData()
	PLUGIN.spawner.positions = self:GetData() or {}
end

function PLUGIN:SaveData()
	self:SetData(PLUGIN.spawner.positions)
end

function PLUGIN:RemoveSpawner(client, title)
	if !(CAMI.PlayerHasAccess(client, "Helix - Item Spawner", nil)) then return end

	for k, v in ipairs(PLUGIN.spawner.positions) do
		--if (v.title:lower() == title:lower()) then
			table.remove(PLUGIN.spawner.positions, k)
			return true
		--end
	end
	return false
end

function PLUGIN:ForceSpawn(client, spawner)
	if !(CAMI.PlayerHasAccess(client, "Helix - Item Spawner", nil)) then return end

	spawner.lastSpawned = os.time()

	local categoryItems = PLUGIN.ItemCategoryes[spawner.category]
	if !categoryItems then return end
	ix.item.Spawn(table.Random(categoryItems), spawner.position)
end

function PLUGIN:AddSpawner(client, position, category)
	if !(CAMI.PlayerHasAccess(client, "Helix - Item Spawner", nil)) then return end

	table.insert(PLUGIN.spawner.positions, {
		["ID"] = os.time(),
		["category"] = category,
		["delay"] =  math.random(600, 1800),
		["lastSpawned"] = os.time(),
		["author"] = client:SteamID64(),
		["position"] = position,
	})
end

function PLUGIN:Think()
	if table.IsEmpty(PLUGIN.spawner.positions) then return end
	
	for k, v in pairs(PLUGIN.spawner.positions) do
		if (v.lastSpawned + (v.delay) < os.time()) then
			v.lastSpawned = os.time()

			local ixItemCount = 0
			for _, ent in pairs(ents.GetAll()) do
				if ent:GetClass() == "ix_item" then
					ixItemCount = ixItemCount + 1
				end
			end

            local categoryItems = PLUGIN.ItemCategoryes[v.category]

            if ixItemCount > 200 then return end
            if !categoryItems then return end

			ix.item.Spawn(table.Random(categoryItems), v.position)
		end
	end
end


net.Receive("ixItemSpawnerDelete", function(length, client)
	if !(CAMI.PlayerHasAccess(client, "Helix - Item Spawner", nil)) then return end

	local item = net.ReadString()
	PLUGIN:RemoveSpawner(client, item)
end)

net.Receive("ixItemSpawnerGoto", function(length, client)
	if !(CAMI.PlayerHasAccess(client, "Helix - Item Spawner", nil)) then return end

	local position = net.ReadVector()
	client:SetPos(position)
end)

net.Receive("ixItemSpawnerSpawn", function(length, client)
	if !(CAMI.PlayerHasAccess(client, "Helix - Item Spawner", nil)) then return end

	local item = net.ReadTable()
	PLUGIN:ForceSpawn(client, item)
end)