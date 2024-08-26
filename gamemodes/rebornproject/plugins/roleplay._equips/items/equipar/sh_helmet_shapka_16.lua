ITEM.name = "Офицерская фуражка `СССС`"
ITEM.description = "Головной убор. Ранее назывался «фуражная шапка» и являлся форменным головным убором в вооружённых силах и ведомствах различных государств."
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true
ITEM.model = "models/kek1ch/helm_bandana.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-199.54, 7.22, 14.97),
	ang = Angle(3.49, -2.04, 0),
	fov = 2.61
}

ITEM.width = 1
ITEM.height = 1
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
    [HITGROUP_HEAD] = true -- хитбоксы
}
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 25
ITEM.quality = "rare"
ITEM.inventoryType = "helmet"
ITEM.bodyGroups = {
    ["Шапки,шлема"] = 17,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Шлема" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

