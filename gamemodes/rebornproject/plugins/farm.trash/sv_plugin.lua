local PLUGIN = PLUGIN
PLUGIN.lootTable = PLUGIN.lootTable or {}

function PLUGIN:InitializedPlugins()
	for uniqueID, ITEM in pairs(ix.item.list) do
		if ITEM.category == "Мусор" then
			self.lootTable[#self.lootTable + 1] = uniqueID
		end
	end
end

function PLUGIN:LoadData()
	local trashSpawners = ix.data.Get("trashspawners")

	if trashSpawners then
		for k, v in pairs(trashSpawners) do
			local entity = ents.Create("ix_trashspawner")
			entity:SetAngles(v[1])
			entity:SetPos(v[2])
			entity:Spawn()
			entity:SetNetVar("ixNextTrashSpawn", v[3] <= 0 and 0 or (CurTime() + v[3]))
		end
	end
end

function PLUGIN:SaveData()
	local trashSpawners = {}
	
	for k, v in pairs(ents.FindByClass("ix_trashspawner")) do
		local time = v:GetNetVar("ixNextTrashSpawn", 0)
		trashSpawners[#trashSpawners + 1] = {
			v:GetAngles(),
			v:GetPos(),
			time <= 0 and time or (time - CurTime())
		}
	end
	
	ix.data.Set("trashspawners", trashSpawners)
end
