ITEM.name = "Штаны «ЖНЕЦ»"
ITEM.description = "Поношенные. Штаны - с очень хорошими показателями защиты и удобности в ношении, имеют популярность у таких станций как Рижская, где подавляющий процент населения - сталкеры. Хорошая защита от падений и порезов, но в обратную - плохая пулестойкость."
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
ITEM.Strengthneed = 7
ITEM.width = 1
ITEM.height = 1

ITEM.damage = {
    0.8, -- Пулестойкость
    0.4, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.5 -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_LEFTLEG] = true,
    [HITGROUP_RIGHTLEG] = true,-- хитбоксы
}

ITEM.LookupBone = "bip01_l_foot"
ITEM.CamPosVec = Vector(-36, 2.5, 15)
ITEM.Warm = 40
ITEM.quality = "legendary"
ITEM.inventoryType = "legs"
ITEM.bodyGroups = {
    ["Ноги"] = 8,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Штаны" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

