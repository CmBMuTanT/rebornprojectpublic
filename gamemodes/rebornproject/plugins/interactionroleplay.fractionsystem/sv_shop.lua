local PLUGIN = PLUGIN

netstream.Hook("fractionsystem::SHOPVGUI_buy", function(client, entityIndex, itemdata)
    local entity = Entity(entityIndex)

    if not entity or table.IsEmpty(itemdata) then return end

    local factionTable = ix.faction.Get(client:Team())
    local rankTable = factionTable.Ranks

    if not rankTable[client:GetCharacter():GetRank()][4] then
        return client:NotifyLocalized("cannotAllow")
    end

    local itemKey = itemdata.item
    local itemInfo

    for _, v in ipairs(PLUGIN.TempItemsToTrade2) do
        if v.item == itemKey then
            itemInfo = v
            break
        end
    end

    if not itemInfo then
        client:Notify("CRITICAL ERROR! NO ITEM IN TABLE!")
        return
    end

    local ixItem = ix.item.Get(itemInfo.item)
    local bankinventory = ix.item.inventories[entity:GetBankID()]

    if bankinventory.id == 0 then
        client:Notify("Инвентарь хранилища равен [0] и не может восстановится, откройте хранилище для синхронизации.")
        return
    end

    if entity:GetCurrStorage() < itemdata.count then
        client:Notify("У вас не хватает очков на складе для данного действия!")
        return
    end

    local x, y = bankinventory:FindEmptySlot(ixItem.width, ixItem.height)

    if !(x and y) then
        client:Notify("Недостаточно места в хранилище!")
        return
    end


    entity:SetCurrStorage(math.max(0, entity:GetCurrStorage() - itemdata.count))
    bankinventory:Add(itemInfo.item, nil, nil, x, y)
    entity:EmitSound("ambient/machines/combine_terminal_idle"..math.random(4)..".wav")
    client:Notify("Транзакция прошла успешно!")
end)
