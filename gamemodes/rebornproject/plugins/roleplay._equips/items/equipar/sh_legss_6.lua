ITEM.name = "Тактические брюки «ГВОЗДЬ»"
ITEM.description = "Самые примитивные и дешёвые что в производстве что в защите штаны. Распространены практически везде, где только можно - носятся большинством зелёных сталкеров.. И если говорить в общем - для начальных этапов эти штаны могут сгодится, но вот потом.. Потом - навряд-ли."
ITEM.category = "[EQ] LEGS"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/rookie_outfit.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(31.69, 0.33, 733.39),
	ang = Angle(87.4, 180.28, 0),
	fov = 2.36
}

ITEM.Strengthneed = 2
ITEM.width = 1
ITEM.height = 1

ITEM.damage = {
    0.8, -- Пулестойкость
    0.7, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.8 -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_LEFTLEG] = true,
    [HITGROUP_RIGHTLEG] = true, -- хитбоксы
}

ITEM.LookupBone = "bip01_l_foot"
ITEM.CamPosVec = Vector(-36, 2.5, 15)
ITEM.Warm = 35
ITEM.quality = "uncommon"
ITEM.inventoryType = "legs"
ITEM.bodyGroups = {
    ["Ноги"] = 6,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Штаны" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

