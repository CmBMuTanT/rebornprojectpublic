ITEM.name = "Майка-алкашка"
ITEM.description = "Майка-алкашка - в комплекте с которой идут небольшие обмотки на руки, которые и защитят вас от порезов?.. Так-же на уровне живота - спрятана небольшая броневая пластина.."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/rookie_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(48.82, 0.2, 732.45),
	ang = Angle(86.2, 180.16, 0),
	fov = 2.22
}
ITEM.weight = 2.5
ITEM.damage = {
    0.8, -- Пулестойкость
    0.8, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.9, -- Защита от падения
}
ITEM.Strengthneed = 1
ITEM.HitGroupScaleDmg = {
    [HITGROUP_STOMACH] = true,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 5
ITEM.quality = "common"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 7,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

----Skin Gropus----
 