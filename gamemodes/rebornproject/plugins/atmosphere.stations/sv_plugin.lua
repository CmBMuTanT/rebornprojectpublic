netstream.Hook("ixMusicPlay",function(client,entity,mud,uid, start_from)
    if IsValid(entity) && entity:GetClass() == "ix_item" then
        local itemTable = entity:GetItemTable()
        if itemTable.uniqueID == "audioplayer" then
            if !entity:GetNetVar("CurMusic") then
                entity:SetNetVar("CurMusic", mud)
                entity:SetNetVar("Casette", uid)
                entity:SetNWInt("ixMusicRewind", start_from)
                entity:SetNWInt("ixMusicVolume", 0.5)
                client:GetCharacter():GetInventory():Remove(client:GetCharacter():GetInventory():HasItem(uid):GetID())

                print("Start playing ".. mud)
            end
        end
    end
end)

util.AddNetworkString("ixMusicRewind")
util.AddNetworkString("ixMusicVolume")

net.Receive("ixMusicVolume", function(len, ply)
    local ent = net.ReadEntity(ent)
    local vol = net.ReadUInt(7)

    if ent:GetNetVar("CurMusic") then
        ent:SetNWInt("ixMusicVolume", math.Clamp(vol, 0, 0.9))
    end
end)

net.Receive("ixMusicRewind", function(len, ply)
    local ent = net.ReadEntity(ent)
    local rewind = net.ReadUInt(32)

    if ent:GetNetVar("CurMusic") then
        ent:SetNWInt("ixMusicRewind", rewind)
    end
end)



function PLUGIN:PostPlayerLoadout(client) -- yes
    if !client:IsValid() then return end

    timer.Simple(3, function()
        if IsValid(client) then
            client:ConCommand("stopsound")
        end
    end)
end