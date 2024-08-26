local PLUGIN = PLUGIN

netstream.Hook("DoCraftMoonShine", function(client, data)
    if not data then return end
    local character = client:GetCharacter()
    local inventory = character:GetInventory()
    local attribute = character:GetAttribute("alccrafter", 0)

    local itemsToRemove = {}

    for k, v in pairs(PLUGIN.MoonShines) do
        if data == k then
            for k2, v2 in pairs(v) do
                if inventory:HasItem(v2) then
                    table.insert(itemsToRemove, inventory:HasItem(v2):GetID())
                end
            end

				if #itemsToRemove == #v then

                for _, itemID in pairs(itemsToRemove) do
                    inventory:Remove(itemID)
                end

                local maxperc = math.Round(math.Clamp(math.random(0, 50) + attribute, 0, 98), 0)
                if maxperc > 30 then
                    client:GetCharacter():SetAttrib("alccrafter", attribute + 0.05)
                end
                inventory:Add(k, 1, { moonshinepercent = maxperc })
            end
        end
    end
end)
---удаляем бусты после смэрти
function PLUGIN:PostPlayerDeath(client)
    local character = client:GetCharacter()
    if !character then return end
    local boosts = character:GetBoosts()
    for attribID, v in pairs(boosts) do
        for boostID, _ in pairs(v) do
            character:RemoveBoost(boostID, attribID)
        end
    end
end