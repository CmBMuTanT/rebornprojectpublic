
net.Receive("ixCharacterDelete", function(length, client)
    local id = net.ReadUInt(32)
    local character = ix.char.loaded[id]
    local steamID = client:SteamID64()
    local isCurrentChar = client:GetCharacter() and client:GetCharacter():GetID() == id

    local moneys = ix.config.Get("Money to remove", 100)
    local banned = character:GetData("banned")

    if character:GetMoney() >= moneys or banned then
        if (character and character.steamID == steamID) then
            for k, v in ipairs(client.ixCharList or {}) do
                if (v == id) then
                    table.remove(client.ixCharList, k)
                end
            end

            hook.Run("PreCharacterDeleted", client, character)
            ix.char.loaded[id] = nil

            net.Start("ixCharacterDelete")
                net.WriteUInt(id, 32)
            net.Broadcast()

            -- remove character from database
            local query = mysql:Delete("ix_characters")
                query:Where("id", id)
                query:Where("steamid", client:SteamID64())
            query:Execute()


            query = mysql:Select("ix_inventories")
                query:Select("inventory_id")
                query:Where("character_id", id)
                query:Callback(function(result)
                    if (istable(result)) then
                        for _, v in ipairs(result) do
                            local itemQuery = mysql:Delete("ix_items")
                                itemQuery:Where("inventory_id", v.inventory_id)
                            itemQuery:Execute()

                            ix.item.inventories[tonumber(v.inventory_id)] = nil
                        end
                    end

                    local invQuery = mysql:Delete("ix_inventories")
                        invQuery:Where("character_id", id)
                    invQuery:Execute()
                end)
            query:Execute()

            -- other plugins might need to deal with deleted characters.
            hook.Run("CharacterDeleted", client, id, isCurrentChar)

            if (isCurrentChar) then
                client:SetNetVar("char", nil)
                client:KillSilent()
                client:StripAmmo()
            end
        end
    end
end)



function PLUGIN:FindLang(action)
    local tblactions = {
        ["take"] = "Подобрал",
        ["drop"] = "Выкинул",
        ["use"] = "Использовал",
        ["combine"] = "Объединил",
        ["givemoney"] = "Отсчитал и передал пульки человеку перед собой"
    }

    return tblactions[action] or "использовал"
end

function PLUGIN:PlayerInteractItem(client, action, item)
    ix.chat.Send(client, "me", self:FindLang(action).." "..string.utf8lower(item:GetName()))
end
