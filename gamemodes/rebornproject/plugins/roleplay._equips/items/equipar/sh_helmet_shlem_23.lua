ITEM.name = "Шлем «РЕЙНДЖЕР-ОБЛЕГЧЕННЫЙ»"
ITEM.description = "Облегченная версия спартанского шлема, отсутсвует лицевая защита - что в разы сбавляет такие характеристики как защита от порезов.. В-целом, шлем вполне хорош."
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true 
ITEM.model = "models/maver1k_xvii/metro_digger_helmet.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(733.51, -0.92, -28.44),
	ang = Angle(-2.28, 179.93, 0),
	fov = 0.88
}
ITEM.Strengthneed = 10
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1.5
ITEM.damage = {
    0.5, -- Пулестойкость
    0.7, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.7 -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_HEAD] = true -- хитбоксы
}

ITEM.Warm = 25
ITEM.quality = "rare"
ITEM.inventoryType = "helmet"
ITEM.bodyGroups = {
    ["Шапки,шлема"] = 24,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
--------------------Visuals--------------------

ITEM.outfitCategory = "Шлема" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита
