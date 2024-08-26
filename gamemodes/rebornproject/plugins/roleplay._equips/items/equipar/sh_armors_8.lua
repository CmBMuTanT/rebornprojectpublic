ITEM.name = "Северное Сияние"
ITEM.description = "Утеплённая куртка, с вполне хорошей защитой от порезов.. Возможно?"
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/kek1ch/cs_rookie_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(45.6, -0.05, 732.65),
	ang = Angle(86.48, 179.97, 0),
	fov = 2.18
}

ITEM.weight = 3.5
ITEM.damage = {
    0.8, -- Пулестойкость
    0.6, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.9, -- Защита от падения
}
ITEM.Strengthneed = 5
ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
    [HITGROUP_RIGHTARM] = true,
    [HITGROUP_LEFTARM] = true,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 5
ITEM.quality = "common"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 8,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

----Skin Gropus----
 