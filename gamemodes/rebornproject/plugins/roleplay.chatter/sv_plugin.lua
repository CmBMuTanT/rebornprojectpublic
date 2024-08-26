local PLUGIN = PLUGIN

netstream.Hook("radioAdjust", function(client, freq, id)
    local inv = (client:ExtraInventory("radio"):GetEquipedItem("chatter") or client:GetCharacter():GetInventory():HasItem("chatter") or nil)

    if (inv) then
        local item

        if (id) then
            item = ix.item.instances[id]
        else
            item = inv
        end

        local ent = item:GetEntity()

        if (item and (IsValid(ent) or item:GetOwner() == client)) then
            client:EmitSound("weapons/flaymi/stalker/anomaly/pda/pda_welcome.wav", 50, 170)

            item:SetData("freq", freq)
        else
            client:notify(L("radioNoRadio"))
        end
    end
end)