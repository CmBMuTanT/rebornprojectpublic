ITEM.name = "Балаклава `ВЗМАХ`"
ITEM.description = ""
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/helm_maska.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-12.97, -0.05, 192.69),
	ang = Angle(86.84, 359.8, 0),
	fov = 4.04
}
ITEM.weight = 1
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
ITEM.inventoryType = "head_balaclava"
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.EQsound = "gasmask/gasmask_on_fast.wav"
ITEM.DEQsound = "gasmask/gasmask_holster_fast.wav"
 
ITEM.bodyGroups = {
    ["Балаклавы"] = 8,
}
 
-- путь до оверлея

--------------------Visuals--------------------
