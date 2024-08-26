ITEM.name = "Очки-профессорки"
ITEM.description = ""
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true
ITEM.model = "models/kek1ch/goggles.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(720.55, 49.46, 131.17),
	ang = Angle(10.26, 183.92, 0),
	fov = 0.64
}

ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.1
ITEM.damage = {
    0.9, -- Пулестойкость
    0.9, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.9, -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_HEAD] = false,
}
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.quality = "uncommon"
ITEM.inventoryType = "head_glasses"
ITEM.bodyGroups = {
    ["Очки"] = 5,
}
ITEM.Warm = 0

--------------------Visuals--------------------
ITEM.outfitCategory = ""

