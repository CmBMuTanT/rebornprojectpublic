ITEM.name = "Кожанный плащ"
ITEM.description = "Кожанный плащ очень хорош в спектре защиты от укусов/порезов, в остальном он фактически бесполезен. Обычно - носится офицерами или руководителями блоков и структур, лидерами станций или в исключениях офицерским составом, не нагромождён и лёгок в ношении."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/kek1ch/duty_rookie_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(50.43, 0.01, 732.33),
	ang = Angle(86.16, 180.25, 0),
	fov = 2.12
}

ITEM.weight = 4.5
ITEM.damage = {
    0.9, -- Пулестойкость
    0.4, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.8, -- Взрывчатка
    0.9, -- Защита от падения
}
ITEM.Strengthneed = 2
ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
    [HITGROUP_RIGHTARM] = true,
    [HITGROUP_LEFTARM] = true,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 75
ITEM.quality = "ultralegendary"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 11,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

----Skin Gropus----
 