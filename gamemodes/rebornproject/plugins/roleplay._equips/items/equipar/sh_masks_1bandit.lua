ITEM.name = "Хоккейная маска"
ITEM.description = "Находится в небольшом переносном подсумке. Хоккейная маска - это.. хоккейная маска. Выглядит антуражно."
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/dev_med_bag.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-0.11, 71.68, 730.56),
	ang = Angle(84.37, 269.72, 0),
	fov = 1.03
}


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
    0.9, -- Защита от падения
}

ITEM.HitGroupScaleDmg = {
	[HITGROUP_HEAD] = false,
}
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 1
ITEM.quality = "rare"
ITEM.inventoryType = "head_balaclava"
ITEM.bodyGroups = {
    ["Противогазы,маски,респираторы"] = 2,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

