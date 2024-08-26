ITEM.name = "Штаны «ПОЛЕВОЙ ОЗК»"
ITEM.description = "Прекрасные тактические-полевые штаны, являются прямой копией комплекта штанов - которые стояли на вооружении СОБРа, ОМОНа - и прочих государственных подструктур. Хорошая хим.рад защита, защита от холода и влаги - это всё, что вам нужно от этой жизни!"
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
ITEM.Strengthneed = 14
ITEM.width = 1
ITEM.height = 1

ITEM.damage = {
    0.4, -- Пулестойкость
    0.2, -- Защита от порезов
    0.5, -- Электрозащита
    0.3, -- Термозащита
    0.2, -- Радиозащита
    0.2, -- Химзащита
    0.9, -- Взрывчатка
    0.6, -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_LEFTLEG] = true,
    [HITGROUP_RIGHTLEG] = true,
}

ITEM.LookupBone = "bip01_l_foot"
ITEM.CamPosVec = Vector(-36, 2.5, 15)
ITEM.Warm = 100
ITEM.quality = "ultralegendary"
ITEM.inventoryType = "legs"
ITEM.bodyGroups = {
    ["Ноги"] = 15,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Штаны" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

