if (SERVER) then
	util.AddNetworkString("ixBagDrop")
end

ITEM.name = "Unload"
ITEM.description = "Разгрузка"
ITEM.model = "models/props_c17/suitcase001a.mdl"
ITEM.category = "Storage"
ITEM.width = 2
ITEM.height = 2
ITEM.invWidth = 4
ITEM.invHeight = 2
ITEM.isBag = true
ITEM.inventoryType = "unloading"
ITEM.functions.View = {
	icon = "icon16/briefcase.png",
	OnClick = function(item)
		local index = item:GetData("id", "")

		if (index) then
			local panel = ix.gui["inv"..index]
			local inventory = ix.item.inventories[index]
			local parent = IsValid(ix.gui.menuInventoryContainer) and ix.gui.menuInventoryContainer or ix.gui.openedStorage

			if (IsValid(panel)) then
				panel:Remove()
			end

			if (inventory and inventory.slots) then
				panel = vgui.Create("ixInventoryOR", IsValid(parent) and parent or nil)
				panel:SetInventory(inventory)

				hook.Run("BagOpened", panel, inventory, item)
					--panel:MoveToFront()
				ix.gui["inv"..index] = panel
			else
				ErrorNoHalt("[Helix] Attempt to view an uninitialized inventory '"..index.."'\n")
			end
		end

		return false
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity) and item:GetData("id") and !IsValid(ix.gui["inv" .. item:GetData("id", "")]) and ix.item.inventories[item.invID].vars.inventoryType == "unloading"
	end
}
--[=[
ITEM.functions.CloseView = {
	icon = "icon16/briefcase.png",
	OnRun = function(item)
		if SERVER then return end
		ix.gui["inv".. item:GetData("id", "")]:Remove()
	end,
	OnCanRun = function(item)
		if SERVER then return true end
		return IsValid(ix.gui["inv".. item:GetData("id", "")])
	end
}

ITEM.functions.combine = {
	OnRun = function(item, data)
		ix.item.instances[data[1]]:Transfer(item:GetData("id"), nil, nil, item.player)

		return false
	end,
	OnCanRun = function(item, data)
		local index = item:GetData("id", "")

		if (index) then
			local inventory = ix.item.inventories[index]

			if (inventory) then
				return true
			end
		end

		return false
	end
}
]=]--

if (CLIENT) then
	function ITEM:PaintOver(item, width, height)
		local panel = ix.gui["inv" .. item:GetData("id", "")]

		if (!IsValid(panel)) then
			return
		end

		if (vgui.GetHoveredPanel() == self) then
			panel:SetHighlighted(true)
		else
			panel:SetHighlighted(false)
		end
	end
end

-- Called when a new instance of this item has been made.
function ITEM:OnInstanced(invID, x, y)
	local inventory = ix.item.inventories[invID]

	ix.inventory.New(inventory and inventory.owner or 0, self.uniqueID, function(inv)
		local client = inv:GetOwner()

		inv.vars.isBag = self.uniqueID
		--inv.vars.inventoryType = "unload"
		self:SetData("id", inv:GetID())

		if (IsValid(client)) then
			inv:AddReceiver(client)
		end
	end)
end

function ITEM:GetInventory()
	local index = self:GetData("id")

	if (index) then
		return ix.item.inventories[index]
	end
end

ITEM.GetInv = ITEM.GetInventory

-- Called when the item first appears for a client.
function ITEM:OnSendData()
	local index = self:GetData("id")

	if (index) then
		local inventory = ix.item.inventories[index]

		if (inventory) then
			inventory.vars.isBag = self.uniqueID
			--inventory.vars.inventoryType = "unload"
			inventory:Sync(self.player)
			inventory:AddReceiver(self.player)
		else
			local owner = self.player:GetCharacter():GetID()

			ix.inventory.Restore(self:GetData("id"), self.invWidth, self.invHeight, function(inv)
				inv.vars.isBag = self.uniqueID
				--inv.vars.inventoryType = "unload"
				inv:SetOwner(owner, true)

				if (!inv.owner) then
					return
				end

				for client, character in ix.util.GetCharacters() do
					if (character:GetID() == inv.owner) then
						inv:AddReceiver(client)
						break
					end
				end
			end)
		end
	else
		ix.inventory.New(self.player:GetCharacter():GetID(), self.uniqueID, function(inv)
			self:SetData("id", inv:GetID())
		end)
	end
end

ITEM.postHooks.drop = function(item, result)
	local index = item:GetData("id")

	local query = mysql:Update("ix_inventories")
		query:Update("character_id", 0)
		query:Where("inventory_id", index)
	query:Execute()

	net.Start("ixBagDrop")
		net.WriteUInt(index, 32)
	net.Send(item.player)
end

if (CLIENT) then
	net.Receive("ixBagDrop", function()
		local index = net.ReadUInt(32)
		local panel = ix.gui["inv"..index]

		if (panel and panel:IsVisible()) then
			panel:Remove()
		end
	end)
end

-- Called before the item is permanently deleted.
function ITEM:OnRemoved()
	local index = self:GetData("id")

	if (index) then
		local query = mysql:Delete("ix_items")
			query:Where("inventory_id", index)
		query:Execute()

		query = mysql:Delete("ix_inventories")
			query:Where("inventory_id", index)
		query:Execute()
	end
end

-- Called when the item should tell whether or not it can be transfered between inventories.
function ITEM:CanTransfer(oldInventory, newInventory)
	local index = self:GetData("id")

	if (newInventory) then
		if (newInventory.vars and newInventory.vars.isBag) then
			return false
		end

		local index2 = newInventory:GetID()

		if (index == index2) then
			return false
		end

		local inv = self.GetInventory and self:GetInventory()
		for _, v in pairs(inv and inv:GetItems() or {}) do
			if (v:GetData("id") == index2) then
				return false
			end
		end
	end

	return !newInventory or newInventory:GetID() != oldInventory:GetID() or newInventory.vars.isBag
end

function ITEM:OnTransferred(curInv, inventory)
	local bagInventory = self:GetInventory()

	if (isfunction(curInv.GetOwner)) then
		local owner = curInv:GetOwner()

		if (IsValid(owner)) then
			bagInventory:RemoveReceiver(owner)
		end
	end

	if (isfunction(inventory.GetOwner)) then
		local owner = inventory:GetOwner()

		if (IsValid(owner)) then
			bagInventory:AddReceiver(owner)
			bagInventory:SetOwner(owner)
		end
	else
		-- it's not in a valid inventory so nobody owns this bag
		bagInventory:SetOwner(nil)
	end

	--hook.Run("BagOnTransferred", self, curInv, inventory)
end

-- Called after the item is registered into the item tables.
function ITEM:OnRegistered()
	ix.inventory.Register(self.uniqueID, self.invWidth, self.invHeight, true)
end

if SERVER then
	function ITEM:Equip(client)
		local character = client:GetCharacter()

		self:SetData("equip", true)

		if (self.bodyGroups) then
			local groups = {}

			for k, value in pairs(self.bodyGroups) do
				local index = client:FindBodygroupByName(k)

				if (index > -1) then
					groups[index] = value
				end
			end

			local newGroups = character:GetData("groups", {})

			for index, value in pairs(groups) do
				newGroups[index] = value
				client:SetBodygroup(index, value)
			end

			if (table.Count(newGroups) > 0) then
				character:SetData("groups", newGroups)
			end
		end
	end

	function ITEM:Unequip(client)
		local character = client:GetCharacter()

		self:SetData("equip", false)

		for k, _ in pairs(self.bodyGroups or {}) do
			local index = client:FindBodygroupByName(k)

			if (index > -1) then
				client:SetBodygroup(index, 0)

				local groups = character:GetData("groups", {})

				if (groups[index]) then
					groups[index] = nil
					character:SetData("groups", groups)
				end
			end
		end
	end
end