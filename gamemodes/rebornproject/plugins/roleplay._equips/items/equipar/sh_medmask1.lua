ITEM.name = "Медицинская маска"
ITEM.description = ""
ITEM.category = "[REBORN] MEDICINE"
ITEM.exRender = true 
ITEM.model = "models/rebs/maske/maske.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(733.94, -10.81, 7.51),
	ang = Angle(0.55, 179.15, 0),
	fov = 0.71
}
ITEM.weight = 0.5
ITEM.width = 1
ITEM.height = 1

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
    ["Противогазы,маски,респираторы"] = 1,
}
--ITEM.MaterialOverlay = "effects/ui_maska_moist"
-- путь до оверлея

--------------------Visuals--------------------
