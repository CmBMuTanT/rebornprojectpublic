ITEM.name = "ГП-8.2"
ITEM.description = "Прототип противогаза ГП-9 с отсутсвующей стекло-панелью, что улучшает видимость в туннелях, но ухудшает на поверхности, так как пыль, снег и посторонние вещи могут попадать в глаза во время ветра. Противогаз так-же массивен, исправен и готов исполнять свою функцию."
ITEM.category = "[EQ] HEAD"

ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1
ITEM.damage = {
    0.9, -- Пулестойкость
    0.9, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.9 -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
	[HITGROUP_HEAD] = true,
}

ITEM.quality = "ultralegendary"
ITEM.inventoryType = "head_gasmask"

ITEM.EQsound = "gasmask/gasmask_on_fast.wav"
ITEM.DEQsound = "gasmask/gasmask_holster_fast.wav"
ITEM.IsMask = true -- это противогаз.
ITEM.bodyGroups = {
    ["Противогазы,маски,респираторы"] = 7,
}
ITEM.MaterialOverlay = "effects/ui_maska_moist"
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.exRender = true 
ITEM.model = "models/kek1ch/helm_respirator_gp9.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-200, 0.56, -1.12),
	ang = Angle(-0.57, -0.16, 0),
	fov = 3.6
}


--------------------Visuals--------------------
