ITEM.name = "Коробка с медициной"
ITEM.exRender = true 
ITEM.model = "models/metro/ammo_box.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(589.2, -247.94, 361.56),
	ang = Angle(29.31, 157.19, 0),
	fov = 1.66
}
ITEM.weight = 9
ITEM.price = 24
ITEM.category = "[REBORN] WORK"
ITEM.description = "Эту коробку ожидают получить на ВДНХ. Там, по словам одного из кладовщиков  `Вообще все туго`. Ваша задача - донести коробку, и главное не распаковать ее! Имеет гравировку в-виде эмблемы Полиса."
ITEM.help = "[ЗАПИСКА] Если товар доставляется на торговый пост - вскрытию не подлежит."
ITEM.outfitCategory = "backpack"
ITEM.bDropOnDeath = true
ITEM.isChelnok = true

ITEM.functions.Unpack = {
    name = "Распаковать",
    icon = "icon16/box.png",
    OnRun = function(item)
        local client = item.player
        local character = client:GetCharacter()
        local inventory = character:GetInventory()

        timer.Simple(0.25, function()
            inventory:Add("revivepill", 5)
            inventory:Add("healthkit", 4)
        end)

        client:SetRunSpeed(ix.config.Get("runSpeed"))
        client:SetWalkSpeed(ix.config.Get("walkSpeed"))

        return true
    end,
    OnCanRun = function(item)
        return not IsValid(item.entity)
    end,
}