do return end

local PLUGIN = PLUGIN

function PLUGIN:OnCharacterCreated(client, character)
    local bank = ix.item.CreateInv(3, 3, os.time())
    bank:SetOwner(character:GetID())
    bank:Sync(client)

    character:SetData("storageID", bank:GetID())
end

function PLUGIN:PlayerLoadedCharacter(client, character, currentCharacter)
    local ID = character:GetData("storageID")
    local bank

    if ID then
        bank = ix.item.inventories[ID]

        if not bank then
            ix.inventory.Restore(ID, 3, 3, function(inventory)
                inventory:SetOwner(character:GetID())
                bank = inventory
            end)
        end
    else
        bank = ix.item.CreateInv(3, 3, os.time())
        bank:SetOwner(character:GetID())
        bank:Sync(character)

        character:SetData("storageID", bank:GetID())
    end
end