ITEM.name = "Костюм «ХЗ»-«ВЕНДЕР»"
ITEM.description = "Костюм повышенной противорадиационной защиты «ВЕНДЕР» - фактически представляет из себя переработанный и укреплённый верхний комплект довоенного ОЗК. Общие харастеристики - довольно высоки, сталкера ценят этот костюм за удобства и безопасность, тепло и лёгкость. Имеет массу подвидов, аналогов и просто подобных костюмов - однако, именно «ВЕНДЕР» остается наиболее популярным среди потребительского рынка сталкеров."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/scientific_outfit_merc.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(-87.98, -0.68, 728.78),
	ang = Angle(83.01, 359.94, 0),
	fov = 2.32
}

ITEM.weight = 8.5
ITEM.damage = {
    0.6, -- Пулестойкость
    0.2, -- Защита от порезов
    0.9, -- Электрозащита
    0.2, -- Термозащита
    0.1, -- Радиозащита
    0.2, -- Химзащита
    0.8, -- Взрывчатка
    0.5, -- Защита от падения
}
ITEM.Strengthneed = 14
ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
    [HITGROUP_RIGHTARM] = true,
    [HITGROUP_LEFTARM] = true,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 100
ITEM.quality = "ultralegendary"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 14,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic2 #99388.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

 
 