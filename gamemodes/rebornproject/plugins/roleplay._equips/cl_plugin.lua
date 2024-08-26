local PLUGIN = PLUGIN

function PLUGIN:RenderScreenspaceEffects()
    local client = LocalPlayer()
    if not client:GetCharacter() then return end

    local inv = client:ExtraInventory("head_gasmask")
    if not inv then return end
    
    local inveq = inv:GetEquipedItem()

    if inv and inveq then
        local armorHealth = inveq:GetData("wearcondition", 100)
        local overlays = {
            ["10"] = "morganicism/metroredux/gasmask/metromask6",
            ["20"] = "morganicism/metroredux/gasmask/metromask5",
            ["40"] = "morganicism/metroredux/gasmask/metromask4",
            ["60"] = "morganicism/metroredux/gasmask/metromask3",
            ["80"] = "morganicism/metroredux/gasmask/metromask2",
            ["100"] = "morganicism/metroredux/gasmask/metromask1",
        }

        for num, overlay in pairs(overlays) do
            if armorHealth <= tonumber(num) then
                DrawMaterialOverlay(overlay, 0.2)
                break
            end
        end
    end
end