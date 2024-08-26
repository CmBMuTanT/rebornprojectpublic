ITEM.name = "Навесной бронежилет «СТУЖА»"
ITEM.description = "Приспособленный навесной бронежилет дает возможность получить базовую дополнительную противопулевую защиту.. Имеет нашивки «СТАЛ..», «МЕСТО - СИЛЬНЫМ!», суть которых вам, увы, особо не ясна."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/hardbass/stalker_sv_nauchniybelt.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(728.09, 6.1, 93.29),
	ang = Angle(7.28, 180.47, 0),
	fov = 1.64
}
ITEM.Armor = 25
ITEM.weight = 13
ITEM.damage = {
    0.7, -- Пулестойкость
    0.8, -- Защита от порезов
    0.8, -- Электрозащита
    0.8, -- Термозащита
    0.8, -- Радиозащита
    0.8, -- Химзащита
    0.8, -- Взрывчатка
    0.8, -- Защита от падения
}
ITEM.Strengthneed = 30
ITEM.HitGroupScaleDmg = {
    --[HITGROUP_HEAD] = false,
	[HITGROUP_CHEST] = true,
	[HITGROUP_STOMACH] = true,
	[HITGROUP_LEFTARM] = true,
	[HITGROUP_RIGHTARM] = true,
	[HITGROUP_LEFTLEG] = true,
	[HITGROUP_RIGHTLEG] = true,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 45
ITEM.quality = "legendary"
ITEM.inventoryType = "unloading"
ITEM.bodyGroups = {
    ["Броня"] = 3,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

 