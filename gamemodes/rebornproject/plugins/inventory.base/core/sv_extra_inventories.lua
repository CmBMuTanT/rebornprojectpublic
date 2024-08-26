local extra_inventories = {
	{type = "weapon_primary", w = 2, h = 2},
	{type = "weapon_secondary", w = 2, h = 2},
	{type = "weapon_pistol", w = 2, h = 1},
	{type = "weapon_knife", w = 2, h = 1},

	{type = "bag", w = 2, h = 2},
	{type = "unloading", w = 2, h = 2},

	{type = "armor", w = 2, h = 3},

	
	{type = "head_balaclava", w = 1, h = 1},
	{type = "head_mask", w = 1, h = 1},
	{type = "helmet", w = 1, h = 1},
	{type = "head_gasmask", w = 1, h = 1},
	{type = "head_glasses", w = 1, h = 1},

	{type = "radio", w = 1, h = 1},
	--{type = "pda", w = 1, h = 1},
	{type = "pnv", w = 1, h = 1},
	{type = "dynamo", w = 1, h = 1},
	{type = "armband", w = 1, h = 1},
	{type = "patch", w = 1, h = 1},

	{type = "legs", w = 1, h = 1},

	{type = "hotkey_f1", w = 1, h = 1},
	{type = "hotkey_f2", w = 1, h = 1},
	{type = "hotkey_f3", w = 1, h = 1},
	{type = "hotkey_f4", w = 1, h = 1}

}

local map = {}

for _, inv in ipairs(extra_inventories) do
	map[inv.type] = inv
	--ix.inventory.Register(inv.type, inv.w, inv.h)
end


local function Create(char, inv, cback)
	local invQuery = mysql:Insert("ix_inventories")
	invQuery:Insert("character_id", char:GetID())
	invQuery:Insert("inventory_type", inv.type)
	invQuery:Callback(function(_, _, invID)
		local inventory = ix.inventory.Create(inv.w, inv.h, invID)
		inventory:SetOwner(char:GetID())
		inventory.vars.inventoryType = inv.type
		char.vars.inv[#char.vars.inv + 1] = inventory
		if cback then cback(inventory) end
	end)
	invQuery:Execute()
--[[
	ix.inventory.New(char:GetID(), inv.type, function(inventory)
		inventory.vars.inventoryType = name
		inventory.vars.isBag = nil
		char.vars.inv[#char.vars.inv + 1] = inventory
	end)
]]--
end

local function CreateExtraInventories(ply, char)
	for _, inv in ipairs(extra_inventories) do
		Create(char, inv)
	end
end

hook.Add("OnCharacterCreated", "StalkerExtraInventories", CreateExtraInventories)

--local query = mysql:Alter("ix_inventories")
--query:Add("invtype", "VARCHAR(150) DEFAULT NULL")
--query:Execute()

function ix.char.Restore(client, callback, bNoCache, id)
	local steamID64 = client:SteamID64()
	local cache = ix.char.cache[steamID64]

	if cache and !bNoCache then
		for _, v in ipairs(cache) do
			local character = ix.char.loaded[v]

			if character and !IsValid(character.client) then
				character.player = client
			end
		end

		if callback then
			callback(cache)
		end

		return
	end

	local query = mysql:Select("ix_characters")
		query:Select("id")

		ix.char.RestoreVars(query)

		query:Where("schema", Schema.folder)
		query:Where("steamid", steamID64)

		if id then
			query:Where("id", id)
		end

		query:Callback(function(result)
			local characters = {}

			for _, v in ipairs(result or {}) do
				local charID = tonumber(v.id)

				if charID then
					local data = {
						steamID = steamID64
					}

					ix.char.RestoreVars(data, v)

					characters[#characters + 1] = charID
					local character = ix.char.New(data, charID, client)

					hook.Run("CharacterRestored", character)
					character.vars.inv = {
						[1] = -1,
					}

					local invQuery = mysql:Select("ix_inventories")
						invQuery:Select("inventory_id")
						invQuery:Select("inventory_type")
						invQuery:Where("character_id", charID)
						invQuery:Callback(function(info)
							if (istable(info) and #info > 0) then
								local inventories = {}

								for _, v2 in pairs(info) do
									if v2.inventory_type and isstring(v2.inventory_type) and v2.inventory_type == "NULL" then
										v2.inventory_type = nil
									end

									if (hook.Run("ShouldRestoreInventory", charID, v2.inventory_id, v2.inventory_type) != false) then
										local w, h = ix.config.Get("inventoryWidth"), ix.config.Get("inventoryHeight")
										local invType

										if v2.inventory_type then
											invType = map[v2.inventory_type] or ix.item.inventoryTypes[v2.inventory_type]

											if (invType) then
												w, h = invType.w, invType.h
											end
										end

										inventories[tonumber(v2.inventory_id)] = {w, h, v2.inventory_type}
									end
								end

								ix.inventory.Restore(inventories, nil, nil, function(inventory)
									local inventoryType = inventories[inventory:GetID()][3]

									if inventoryType then
										if map[inventoryType] then
											inventory.vars.inventoryType = inventoryType
										else
											inventory.vars.isBag = inventoryType
										end
										table.insert(character.vars.inv, inventory)
									else
										character.vars.inv[1] = inventory
									end

									inventory:SetOwner(charID)
									hook.Run("InventoryRestored", client, character, inventory)
								end, true)
							else
								local insertQuery = mysql:Insert("ix_inventories")
									insertQuery:Insert("character_id", charID)
									insertQuery:Callback(function(_, status, lastID)
										local w, h = ix.config.Get("inventoryWidth"), ix.config.Get("inventoryHeight")
										local inventory = ix.inventory.Create(w, h, lastID)
										inventory:SetOwner(charID)

										character.vars.inv = {
											inventory
										}
									end)
								insertQuery:Execute()
							end
						end)
					invQuery:Execute()

					ix.char.loaded[charID] = character
				else
					ErrorNoHalt("[Helix] Attempt to load character with invalid ID '" .. tostring(id) .. "'!")
				end
			end

			if (callback) then
				callback(characters)
			end

			ix.char.cache[steamID64] = characters
		end)
	query:Execute()
end
