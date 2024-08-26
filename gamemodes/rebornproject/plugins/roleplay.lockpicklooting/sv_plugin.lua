local PLUGIN = PLUGIN

function PLUGIN:SearchLootContainer(ent, ply)
    if not ent.containerAlreadyUsed or ent.containerAlreadyUsed <= CurTime() then
        local randomChance = math.random(1,20)
        local randomAmountChance = math.random(1,3)
        local lootAmount = 1

        local randomLootItem = table.Random(PLUGIN.randomLoot.common)
        if ( randomAmountChance == 3 ) then
            lootAmount = math.random(1,3)
        else
            lootAmount = 1
        end

        ply:Freeze(true)
        ply:SetAction("Осматриваю...", 5, function()
            ply:Freeze(false)
            for i = 1, lootAmount do
                if (randomChance == math.random(1,20)) then
                    randomLootItem = table.Random(PLUGIN.randomLoot.rare)
                    ply:ChatNotify("Вы получили "..ix.item.Get(randomLootItem):GetName()..".")
                    ply:GetCharacter():GetInventory():Add(randomLootItem)
                else
                    randomLootItem = table.Random(PLUGIN.randomLoot.common)
                    ply:ChatNotify("Вы получили "..ix.item.Get(randomLootItem):GetName()..".")
                    ply:GetCharacter():GetInventory():Add(randomLootItem)
                end
            end
        end)
        ent.containerAlreadyUsed = CurTime() + 180
    else
        if not ent.ixContainerNothingInItCooldown or ent.ixContainerNothingInItCooldown <= CurTime() then
            ply:ChatNotify("Контейнер оказался пустым.")
            ent.ixContainerNothingInItCooldown = CurTime() + 1
        end
    end
end

function Schema:SpawnRandomLoot(position, rareItem)
    local randomLootItem = table.Random(PLUGIN.randomLoot.common)

    if (rareItem == true) then
        randomLootItem = table.Random(PLUGIN.randomLoot.rare)
    end

    ix.item.Spawn(randomLootItem, position)
end


util.AddNetworkString("SendOpenToServer")

net.Receive("SendOpenToServer", function(length, client)
    if not IsValid(client) then return end

    local lockPickAngle = net.ReadInt(32) or 0
    local traceResult = client:GetEyeTrace()
    local targetEntity = IsValid(traceResult.Entity) and traceResult.Entity or nil

    if not IsValid(targetEntity) then return end
    -- if not targetEntity:isLocked() then return end
    if targetEntity ~= client.LastTargetLockPickDoor then return end

    local currentLockPickAngle = targetEntity:GetNWInt("LockPick_Angle")

    if currentLockPickAngle == lockPickAngle then
        PLUGIN:SearchLootContainer(targetEntity, client)
    end
end)
