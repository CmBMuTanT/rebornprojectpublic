if SERVER then
	util.AddNetworkString("ix.SyncEquip")
else
	net.Receive("ix.SyncEquip", function()
		local inv = ix.inventory.Get(net.ReadUInt(32))
		local item = ix.item.instances[net.ReadUInt(32)]

		inv[net.ReadBool() and "EquipItem" or "UnequipItem"](inv, item)
	end)
end

local ITEM = ix.meta.item

function ITEM:IsEquiped()
	return self:GetData("equip", false)
end

local INV = ix.meta.inventory

function INV:EquipItem(item)

	local ply = CLIENT and LocalPlayer() or item.player
	if IsValid(ply) == false then
		ply = player.GetBySteamID64(item.playerID)
	end
	if IsValid(ply) == false then return end

	if SERVER then
		item:SetData("equip", true)
	else
		item.data = item.data or {}
		item.data.equip = true
	end

	item.equipInventory = self
	self.EquipedItem = item

	if item.Equip then
		item:Equip(ply)
	end

	if item.OnEquipped then
		item:OnEquipped()
	end

	if SERVER then
		net.Start("ix.SyncEquip")
			net.WriteUInt(self:GetID(), 32)
			net.WriteUInt(item:GetID(), 32)
			net.WriteBool(true)
		net.Send(ply)
	end
end

function INV:UnequipItem(item)

	local ply = CLIENT and LocalPlayer() or item.player
	if IsValid(ply) == false then
		ply = player.GetBySteamID64(item.playerID)
	end
	if IsValid(ply) == false then return end

	if item.equipInventory then
		item.equipInventory.EquipedItem = nil
	end

	if SERVER then
		item:SetData("equip", false)
	else
		item.data = item.data or {}
		item.data.equip = false
	end

	item.equipInventory = nil
	self.EquipedItem = nil

	if item.Unequip then
		item:Unequip(ply)
	end

	if item.OnUnEquipped then
		item:OnUnEquipped()
	end

	if SERVER then
		net.Start("ix.SyncEquip")
			net.WriteUInt(self:GetID(), 32)
			net.WriteUInt(item:GetID(), 32)
			net.WriteBool(false)
		net.Send(ply)
	end
end

function INV:GetEquipedItem()
	return self.EquipedItem
end

function INV:Add(uniqueID, quantity, data, x, y, noReplication)
	quantity = quantity or 1

	if (quantity < 1) then
		return false, "noOwner"
	end

	if (!isnumber(uniqueID) and quantity > 1) then
		for _ = 1, quantity do
			local bSuccess, error = self:Add(uniqueID, 1, data)

			if (!bSuccess) then
				return false, error
			end
		end

		return true
	end

	local client = self.GetOwner and self:GetOwner() or nil
	local item = isnumber(uniqueID) and ix.item.instances[uniqueID] or ix.item.list[uniqueID]
	local targetInv = self
	local bagInv

	if (!item) then
		return false, "invalidItem"
	end

	if (isnumber(uniqueID)) then
		local oldInvID = item.invID

		if (!x and !y) then
			x, y, bagInv = self:FindEmptySlot(item.width, item.height)
		end

		if (bagInv) then
			targetInv = bagInv
		end

		-- we need to check for owner since the item instance already exists
		if (!item.bAllowMultiCharacterInteraction and IsValid(client) and client:GetCharacter() and
			item:GetPlayerID() == client:SteamID64() and item:GetCharacterID() != client:GetCharacter():GetID()) then
			return false, "itemOwned"
		end

		if (hook.Run("CanTransferItem", item, ix.item.inventories[0], targetInv) == false) then
			return false, "notAllowed"
		end

		if (x and y) then
			targetInv.slots[x] = targetInv.slots[x] or {}
			targetInv.slots[x][y] = true

			item.gridX = x
			item.gridY = y
			item.invID = targetInv:GetID()

			for x2 = 0, item.width - 1 do
				local index = x + x2

				for y2 = 0, item.height - 1 do
					targetInv.slots[index] = targetInv.slots[index] or {}
					targetInv.slots[index][y + y2] = item
				end
			end

			if (!noReplication) then
				targetInv:SendSlot(x, y, item)
			end

			local owner = targetInv.owner and targetInv:GetOwner()
			if owner then
				item.player = owner
				item.playerID = owner:SteamID64()
				item.characterID = targetInv.owner
			end

			if (!self.noSave) then
				local query = mysql:Update("ix_items")
					query:Update("inventory_id", targetInv:GetID())
					query:Update("x", x)
					query:Update("y", y)
					if owner then
						query:Update("character_id", targetInv.owner)
						query:Update("player_id", owner:SteamID64())
					end
					query:Where("item_id", item.id)
				query:Execute()
			end

			hook.Run("InventoryItemAdded", ix.item.inventories[oldInvID], targetInv, item)

			return x, y, targetInv:GetID()
		else
			return false, "noFit"
		end
	else
		if (!x and !y) then
			x, y, bagInv = self:FindEmptySlot(item.width, item.height)
		end

		if (bagInv) then
			targetInv = bagInv
		end

		if (hook.Run("CanTransferItem", item, ix.item.inventories[0], targetInv) == false) then
			return false, "notAllowed"
		end

		if (x and y) then
			for x2 = 0, item.width - 1 do
				local index = x + x2

				for y2 = 0, item.height - 1 do
					targetInv.slots[index] = targetInv.slots[index] or {}
					targetInv.slots[index][y + y2] = true
				end
			end

			local characterID
			local playerID

			if (self.owner) then
				local character = ix.char.loaded[self.owner]

				if (character) then
					characterID = character.id
					playerID = character.steamID
				end
			end

			ix.item.Instance(targetInv:GetID(), uniqueID, data, x, y, function(newItem)
				newItem.gridX = x
				newItem.gridY = y

				local owner = targetInv.owner and targetInv:GetOwner()
				if owner then
					newItem.player = owner
					newItem.playerID = owner:SteamID64()
					newItem.characterID = targetInv.owner
				end

				for x2 = 0, newItem.width - 1 do
					local index = x + x2

					for y2 = 0, newItem.height - 1 do
						targetInv.slots[index] = targetInv.slots[index] or {}
						targetInv.slots[index][y + y2] = newItem
					end
				end

				if (!noReplication) then
					targetInv:SendSlot(x, y, newItem)
				end

				hook.Run("InventoryItemAdded", nil, targetInv, newItem)
			end, characterID, playerID)

			return x, y, targetInv:GetID()
		else
			return false, "noFit"
		end
	end
end