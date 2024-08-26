ITEM.name = "Тактические штаны «БЕРСЕРК»"
ITEM.description = "Сильно поношенные временем тактические штаны, которые когда-то состояли на вооружении ФСБ-РФ. Предусматривают небольшие скрытые пластины, которые способны выдержать пистолетную пулю на дистанции - или же смягчить падение с высоты. Так-же, вполне достойно держат тепло."
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
ITEM.Strengthneed = 11
ITEM.width = 1
ITEM.height = 1

ITEM.damage = {
    0.7, -- Пулестойкость
    0.5, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.8, -- Взрывчатка
    0.3, -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_LEFTLEG] = true,
    [HITGROUP_RIGHTLEG] = true,
}

ITEM.LookupBone = "bip01_l_foot"
ITEM.CamPosVec = Vector(-36, 2.5, 15)
ITEM.Warm = 45
ITEM.quality = "rare"
ITEM.inventoryType = "legs"
ITEM.bodyGroups = {
    ["Ноги"] = 13,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Штаны" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

