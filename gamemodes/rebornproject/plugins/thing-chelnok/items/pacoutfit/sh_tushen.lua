ITEM.name = "Коробка с тушенкой"
ITEM.model = "models/props_junk/cardboard_box004a.mdl"
ITEM.skin = 2
ITEM.price = 24
ITEM.category = "[REBORN] WORK"
ITEM.description = "В этой коробке находится тушенка, ваша задача - донести ее до одного человека на базе Спарты. Будьте аккуратны, ведь вы идете на стационарный пост Ордена!"
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
            inventory:Add("cons_tomatosi", 4)
            inventory:Add("cons_heinzbobi", 2)
        end)

        client:SetRunSpeed(ix.config.Get("runSpeed"))
        client:SetWalkSpeed(ix.config.Get("walkSpeed"))

        return true
    end,
    OnCanRun = function(item)
        return not IsValid(item.entity)
    end,
}