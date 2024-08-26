local PLAYER = FindMetaTable("Player")

function PLAYER:ExtraInventories(cback)
	local char = self:GetCharacter()
	if char == nil then return end

	for _, inv in ipairs(char.vars.inv) do
		if inv.vars and inv.vars.inventoryType then
			cback(inv)
		end
	end
end

function PLAYER:ExtraInventoryGetItems()
	local char = self:GetCharacter()
	if char == nil then return end

	for _, inv in ipairs(char.vars.inv) do
		 if inv.vars and inv.vars.inventoryType == "bag" then
            return inv:GetItems()
		 end
	end
end

function PLAYER:ExtraInventoryHasItem(item)
	local char = self:GetCharacter()
	if char == nil then return end

	for _, inv in ipairs(char.vars.inv) do
		 if inv.vars and inv.vars.inventoryType == "bag" then
            if item then
                return inv:HasItem(item)
            end
		 end
	end
end

function PLAYER:ExtraInventory(name)
	local char = self:GetCharacter()
	if char == nil then return end

	for _, inv in ipairs(char.vars.inv) do
		if inv.vars.inventoryType == name then
			return inv
		end
	end
end

function PLAYER:GetAllItems() -- Пришлось дописывать еще одну функцию дабы weight у нас работал нормально.
    local char = self:GetCharacter()
    local allItems = {}

    if char then
        local addedItems = {}

        for _, invextra in ipairs(char.vars.inv) do
            if invextra.vars then
                for _, itemex in pairs(invextra:GetItems()) do
                    if not addedItems[itemex] then
                        table.insert(allItems, itemex)
                        addedItems[itemex] = true
                    end
                end
            end
        end

        return allItems
    end
end

hook.Add("CanTransferItem", "StalkerExtraInventories", function(item, curInv, inventory)
    
    if inventory.vars and inventory.vars.inventoryType and item.inventoryType == "hotkey" then -- НАХАРДКОДИЛ XDDDDDD, за то работает.
        local inventoryType = inventory.vars.inventoryType
        local hotkeyIndex = string.find(inventoryType, "_f%d")

        if hotkeyIndex then
            inventoryType = string.sub(inventoryType, 1, hotkeyIndex - 1)
            if inventoryType == "hotkey" then
                return true
            end
        end
    end

    if inventory.vars and inventory.vars.inventoryType and inventory.vars.inventoryType ~= item.inventoryType then
        if inventory.vars.inventoryType == "weapon_primary" and item.inventoryType == "weapon_secondary" then
            return true
        elseif inventory.vars.inventoryType == "weapon_secondary" and item.inventoryType == "weapon_primary" then
            return true
        else
            return false, "notAllowed"
        end
    end
end)