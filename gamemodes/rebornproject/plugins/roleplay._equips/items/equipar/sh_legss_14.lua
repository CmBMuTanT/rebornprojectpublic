ITEM.name = "Штаны «КРЕВЕТКА»"
ITEM.description = "Штаны с довольно звучащим названием.. Для штанов. Почему креветка? Никто не знает, так повелось. В-целом, ничем не отличаются от других штанов - однако, есть у КРЕВЕТКИ один существенный плюс перед другими аналогичными штанами - это небольшая защита от порезов и пулями в силу небольших пластин встроенных в штаны."
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
ITEM.Strengthneed = 3
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
    0.8, -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_LEFTLEG] = true,
    [HITGROUP_RIGHTLEG] = true,
}

ITEM.LookupBone = "bip01_l_foot"
ITEM.CamPosVec = Vector(-36, 2.5, 15)
ITEM.Warm = 1
ITEM.quality = "uncommon"
ITEM.inventoryType = "legs"
ITEM.bodyGroups = {
    ["Ноги"] = 14,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Штаны" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

