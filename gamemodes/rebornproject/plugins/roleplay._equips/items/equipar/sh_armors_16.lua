ITEM.name = "Боевой комплект «ШТУРМОВИК-ЛЕГКИЙ-S»"
ITEM.description = "Одна из вариаций штурмовой брони принятой на вооружение кшатриями/орденом. Упор защиты берется исключительно на грудь и живот. Имеет репутацию крайне хорошей, хоть и быстро ломаемой брони."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/hardbass/stalker_bandit_1_lrazgryz.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(714.24, -8.23, 169.25),
	ang = Angle(13.34, 179.32, 0),
	fov = 1.6
}
ITEM.width = 2
ITEM.height = 3
ITEM.weight = 5
ITEM.damage = {
    0.5, -- Пулестойкость
    0.4, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.7, -- Взрывчатка
    0.5, -- Защита от падения
}
ITEM.Strengthneed = 10
ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 65
ITEM.quality = "rare"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 16,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic2 #99388.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита


 