ITEM.name = "Коробка с запрещенными препаратами"
ITEM.model = "models/props_junk/cardboard_box004a.mdl"
ITEM.skin = 2
ITEM.price = 24
ITEM.category = "[REBORN] WORK"
ITEM.description = "В этой коробке находится контрабанда, ваша задача - донести ее до одного человека на `Кольцевой`. Будьте аккуратны, ведь это запрещенные вещества!"
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
            inventory:Add("lsdshka", 3)
            inventory:Add("revivepill", 2)
        end)

        client:SetRunSpeed(ix.config.Get("runSpeed"))
        client:SetWalkSpeed(ix.config.Get("walkSpeed"))

        return true
    end,
    OnCanRun = function(item)
        return not IsValid(item.entity)
    end,
}