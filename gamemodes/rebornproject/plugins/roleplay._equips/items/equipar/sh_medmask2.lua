ITEM.name = "Медицинский респиратор «ВЕЛИКИЙ»"
ITEM.description = ""
ITEM.category = "[REBORN] MEDICINE"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/helm_respirator_half.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-215.1, 1.45, -701.84),
	ang = Angle(-107.04, 179.61, 0),
	fov = 0.54
}
ITEM.weight = 0.5
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
ITEM.inventoryType = "head_mask"
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.EQsound = "eftsounds/generic_use.wav"
ITEM.DEQsound = "eftsounds/generic_drop.wav"
ITEM.IsMask = false -- это противогаз.
ITEM.bodyGroups = {
    ["Противогазы,маски,респираторы"] = 3,
}
--ITEM.MaterialOverlay = "effects/ui_maska_moist"
-- путь до оверлея

--------------------Visuals--------------------
