ITEM.name = "Коробка с семенами грибов"
ITEM.model = "models/z-o-m-b-i-e/metro_ll/station_props/m_ll_mushroom_box_07.mdl"
ITEM.skin = 2
ITEM.price = 24
ITEM.category = "[REBORN] WORK"
ITEM.description = "В этой коробке находятся семена грибов, самых обычных зеленых грибов. Их стоит доставить на станцию Четвертого Рейха"
ITEM.help = "[ЗАПИСКА] Если товар доставляется на торговый пост - вскрытию не подлежит."
ITEM.outfitCategory = "backpack"
ITEM.bDropOnDeath = true
ITEM.isChelnok = true
ITEM.width = 2
ITEM.height = 2

ITEM.functions.Unpack = {
    name = "Распаковать",
    icon = "icon16/box.png",
    OnRun = function(item)
        local client = item.player
        local character = client:GetCharacter()
        local inventory = character:GetInventory()

        timer.Simple(0.25, function()
            inventory:Add("mushroomspores", 5)
            inventory:Add("potatospore", 1)
        end)

        client:SetRunSpeed(ix.config.Get("runSpeed"))
        client:SetWalkSpeed(ix.config.Get("walkSpeed"))

        return true
    end,
    OnCanRun = function(item)
        return not IsValid(item.entity)
    end,
}