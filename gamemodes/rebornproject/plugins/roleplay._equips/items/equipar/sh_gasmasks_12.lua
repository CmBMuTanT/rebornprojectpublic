ITEM.name = "ГП-2 `ОТТА.РОВ`"
ITEM.description = "Противогаз кустарной конструкции новособранной технической организации ОТТА.РОВЦЫ с Кузнецкого Моста. Противогаз имеет крупную эксплуатацию по метрополитену."
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
    ["Противогазы,маски,респираторы"] = 12,
}
ITEM.MaterialOverlay = "effects/ui_maska_moist"
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.exRender = true 
ITEM.model = "models/devcon/mrp/props/gasmask_stalker.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(189.86, 4.11, 3.12),
	ang = Angle(-0.84, 181.23, 0),
	fov = 3.75
}

--------------------Visuals--------------------
