local PLUGIN = PLUGIN

netstream.Hook("GiveMeStartCredits", function(client)
    if IsValid(client) then
        client:SetNetVar("StartCredits", 100)
    end
end)


local PlySize = {
   [1] = "0.94",
   [2] = "0.95",
   [3] = "0.96",
   [4] = "0.98",
   [5] = "1",
   [6] = "1.05",
   [7] = "1.1",
}

function PLUGIN:AnyAct_LockedClub_RLGN(client, char, scale)
    for k,v in pairs(PlySize) do
        if k == tonumber(scale) then
            char:SetData("cmbmtk.Height", v)
        end
    end

    local inventory = char:GetInventory()
end


-- function PLUGIN:Absolute_Territory(client, char, _, datatwo) -- из-за инвентаря теперь он находится в sv_plugin. (inventory.base)
--     local inventory = char:GetInventory()
--     local itemtogive = ix.item.Get(datatwo)

--     for k,v in pairs(self.itemstochoice) do
--         if v.ItemUID == datatwo then
--             inventory:Add(datatwo)
--         end
--     end

--     char:GiveMoney(client:GetNetVar("StartCredits")) -- выдаем деньги которые он не потратил (очки)
--     client:SetNetVar("StartCredits", 0) -- сетим очки на 0
-- end

function PLUGIN:CharacterLoaded(char)
    local client = char:GetPlayer()

    if char:GetData("cmbmtk.Height") then
        client:SetModelScale(char:GetData("cmbmtk.Height") or 1)
    else
        char:SetData("cmbmtk.Height", PlySize[math.random(1, #PlySize)])
        client:SetModelScale(char:GetData("cmbmtk.Height") or 1)
    end
end



-------------

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