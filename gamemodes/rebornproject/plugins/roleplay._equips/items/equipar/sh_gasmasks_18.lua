ITEM.name = "ГП-5"
ITEM.description = "Фильтрующее средство индивидуальной защиты органов дыхания, глаз и кожи лица человека. Наиболее распространённый на территории стран СНГ противогаз."
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
    ["Противогазы,маски,респираторы"] = 18,
}
ITEM.MaterialOverlay = "effects/ui_maska_moist"
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.exRender = true 
ITEM.model = "models/hardbass/stalker_skat9m_gasmask.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(205.52, 12.24, -2.45),
	ang = Angle(-0.63, 183.41, 0),
	fov = 3.81
}


--------------------Visuals--------------------
