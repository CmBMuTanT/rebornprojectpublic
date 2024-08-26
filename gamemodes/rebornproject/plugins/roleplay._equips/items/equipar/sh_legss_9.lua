ITEM.name = "Штаны «ЖНЕЦ-5»"
ITEM.description = "Тактические штаны цвета синего-хаки. Ранее, были популязированы в ношении у силовых структур типа `ОМОН`, и ему подобных. Удобны в ношении, и имеют плотную ткань - за счёт чего обеспечивают какую-никакую защиту от порезов."
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
ITEM.Strengthneed = 5
ITEM.width = 1
ITEM.height = 1

ITEM.damage = {
    0.9, -- Пулестойкость
    0.7, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.6 -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_LEFTLEG] = true,
    [HITGROUP_RIGHTLEG] = true,-- хитбоксы
}

ITEM.LookupBone = "bip01_l_foot"
ITEM.CamPosVec = Vector(-36, 2.5, 15)
ITEM.Warm = 25
ITEM.quality = "common"
ITEM.inventoryType = "legs"
ITEM.bodyGroups = {
    ["Ноги"] = 9,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Штаны" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

