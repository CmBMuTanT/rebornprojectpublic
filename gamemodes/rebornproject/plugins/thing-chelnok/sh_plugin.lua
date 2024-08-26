PLUGIN.name = "Chelnok"

function PLUGIN:InventoryItemAdded(oldInv, inventory, item)
    if not inventory then return end
    if not item.isChelnok then return end
    local client = inventory.GetOwner and inventory:GetOwner() or false
    if not client then return end

    local runSpeed = client:GetRunSpeed()
    local walkSpeed = client:GetWalkSpeed()
    client:SetRunSpeed(runSpeed / 1.55)
    client:SetWalkSpeed(walkSpeed / 1.55)
    client:Notify("Ты подобрал тяжелый груз. Твоя скорость изрядно уменьшена, пока он у тебя в инвентаре. Также, ты можешь экипировать его себе за спину")
end

function PLUGIN:InventoryItemRemoved(inventory, item)
    if not inventory then return end
    if not item.isChelnok then return end
    local client = inventory.GetOwner and inventory:GetOwner() or false
    if not client then return end

    client:SetRunSpeed(ix.config.Get("runSpeed"))
    client:SetWalkSpeed(ix.config.Get("walkSpeed"))
end

function PLUGIN:OnItemTransferred(item, curInv, inventory)
    if not inventory then return end
	if not curInv then return end
    if not item.isChelnok then return end
    if curInv == inventory then return end
	local client = curInv.GetOwner and curInv:GetOwner()
	if not client then return end

    client:SetRunSpeed(ix.config.Get("runSpeed"))
    client:SetWalkSpeed(ix.config.Get("walkSpeed"))
end

function PLUGIN:CharacterVendorTraded(client, entity, uniqueID, isSellingToVendor)
    local itemTable = ix.item.Get(uniqueID)
    if itemTable.isChelnok then
        client:SetRunSpeed(ix.config.Get("runSpeed"))
        client:SetWalkSpeed(ix.config.Get("walkSpeed"))
    end
end