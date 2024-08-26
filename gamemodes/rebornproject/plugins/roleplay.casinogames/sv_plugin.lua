local PLUGIN = PLUGIN

netstream.Hook("Obmen:coins", function(client, name, count)
    if !IsValid(client) and !client:Alive() then return end
    if !client:GetCharacter() then return end
    if !PLUGIN.coinstable[name] then return end

    local character = client:GetCharacter()
    local inv = character:GetInventory()
    local item = inv:HasItem("casinocoin")
    local item2 = inv:HasItem("rubbls") -- <--- редачь вот это 

    if !item2 then return end
    if item2:GetData("stacks", 1) < count then client:Notify("Объедините рубли для дальнейшего обмена!") return end

    if item2:GetData("stacks", 1) > 0 then
        item2:SetData("stacks", item2:GetData("stacks", 1) - count)
        if item2:GetData("stacks") <= 0 then 
            item2:Remove() 
        end
    end
    
    if item then
        item:SetData("stacks", item:GetData("stacks", 1) + count)
    else
        inv:Add("casinocoin", 1, {stacks = count})
    end
    client:SendLua([[surface.PlaySound("garrysmod/content_downloaded.wav")]])
end)

netstream.Hook("Obmen:Item", function(client, name, price)
    if !IsValid(client) and !client:Alive() then return end
    if !client:GetCharacter() then return end
    if table.IsEmpty(PLUGIN.TempItemsToTrade) then return end

    local itemFound = false

    for _, itemData in pairs(PLUGIN.TempItemsToTrade) do
        if itemData.item == name then
            itemFound = true
            break
        end
    end
    
    if !itemFound then return end
   
    local character = client:GetCharacter()
    local inv = character:GetInventory()
    local item = inv:HasItem("casinocoin")

    if !item then return end
    if item:GetData("stacks", 1) < price then return end
    
    item:SetData("stacks", item:GetData("stacks", 1) - price)
    inv:Add(name, 1)
    client:SendLua([[surface.PlaySound("garrysmod/content_downloaded.wav")]])

    if item:GetData("stacks", 0) <= 0 then item:Remove() end
end)


netstream.Hook("MouseRun:Bet", function(client, mouse, bet)
    if !mouse and !IsValid(mouse) then return end
    if !IsValid(client) and !client:Alive() then return end
    if !client:GetCharacter() then return end

    local bet = tonumber(bet)

    local character = client:GetCharacter()
    local inv = character:GetInventory()
    local item = inv:HasItem("casinocoin")

    if !item then client:Notify("У вас недостаточно средств для этого!") return end
    if item:GetData("stacks", 1) < bet then client:Notify("У вас недостаточно средств для этого!") return end
    if bet <= 0 then client:Notify("MouseRuns ERROR#2 Бля тебе прошлой ошибки не хватило?") return end

    item:SetData("stacks", item:GetData("stacks", 1) - bet)

    client:SetNetVar("MOUSEBETAMOUNT", bet)
    client:SetNetVar("MOUSEBET", mouse)

    if item:GetData("stacks", 1) <= 0 then 
        item:Remove() 
    end
end)

netstream.Hook("Thimbles:Bet", function(client, num, bet)
    if !IsValid(client) and !client:Alive() then return end
    if !client:GetCharacter() then return end

    local bet = tonumber(bet)

    local character = client:GetCharacter()
    local inv = character:GetInventory()
    local item = inv:HasItem("casinocoin")

    if !item then client:Notify("У вас недостаточно средств для этого!") return end
    if item:GetData("stacks", 1) < bet then client:Notify("У вас недостаточно средств для этого!") return end

    if bet <= 0 then client:Notify("Thimbles ERROR#2 Бля тебе прошлой ошибки не хватило?") return end

    if num == 0 then
        client:Notify("Так как вы решили закрыть игру то вы потеряли ставку.")
        item:SetData("stacks", item:GetData("stacks", 1) - bet)

        if item:GetData("stacks", 1) <= 0 then 
            item:Remove() 
        end
    elseif math.random(3) == 1 then -- ХАХАХА ДА ВЫБОР БЕЗ ВЫБОРА НА САМОМ ДЕЛЕ ОПЯТЬ ЖЕ ЧИСТЫЙ РАНДОМ!
        client:Notify("Вы угадали где находится шарик!")
        item:SetData("stacks", item:GetData("stacks", 1) + bet)
    else
        client:Notify("К сожалению ваша ставка не сыграла, и вы ее потеряли.")
        item:SetData("stacks", item:GetData("stacks", 1) - bet)

        if item:GetData("stacks", 1) <= 0 then 
            item:Remove() 
        end
    end
end)



timer.Create("AdjustRatInfo", 60, 0, function() -- да больше ниче не придумал как обычно (нахардкодил XDD)
    for k,client in pairs(player.GetAll()) do
        local ent = ents.FindByClass("cmbmtk_mouzeruns")[1]
        if IsValid(ent) then
            if client:GetPos():Distance(ent:GetPos()) < 350 then
                netstream.Start(client, "MouseRuns:Info", ent.mouses)
            end
        end
    end
end)