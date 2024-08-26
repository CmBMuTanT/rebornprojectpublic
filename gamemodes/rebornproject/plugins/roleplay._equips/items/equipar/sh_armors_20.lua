ITEM.name = "Бронекомплект «ВИНИР»"
ITEM.description = "Средняя комплектация брони, относящиеся к ношению сержантским составом внутри вооружённый сил Красной Линии. Внутри комплектации встроены бронепластины класса R1R, что обеспечивает наибольшую защиту при условии сохранения удобства и проворливости. Имеется лычка «СЛАВА МОСКВИНУ!»"
ITEM.category = "[EQ] BODY"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/freeheavy_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(11.25, 0.33, 199.68),
	ang = Angle(86.5, -177.5, 0),
	fov = 8.07
}

ITEM.weight = 3.5
ITEM.damage = {
    0.5, -- Пулестойкость
    0.7, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.5, -- Взрывчатка
    0.5, -- Защита от падения
}

ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
    [HITGROUP_RIGHTARM] = true,
}
ITEM.Strengthneed = 10
ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 59
ITEM.quality = "uncommon"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 20,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic2 #99388.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

----Skin Gropus----
 