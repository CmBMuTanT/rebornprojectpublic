ITEM.name = "Армейская шинель"
ITEM.description = "Шинель - это верхняя военная верхняя одежда, можно сказать форменное пальто со складками на спине и удерживающим их сложенными хлястиком. Никаких нашивок не имеет, лишь небольшые отрывки букв «M..DE IN U...S..R»"
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/kek1ch/freedom_rookie_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(14.76, -0.14, 733.92),
	ang = Angle(88.85, 179.55, 0),
	fov = 2.2
}
ITEM.IsMask = false
ITEM.weight = 6

ITEM.damage = {
    0.8, -- Пулестойкость
    0.3, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.4, -- Защита от падения
}

ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
}
ITEM.Strengthneed = 15
ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 75
ITEM.quality = "legendary"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 21,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic2 #99388.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

----Skin Gropus----
 



