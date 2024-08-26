ITEM.name = "Спец.бронекостюм «ШЕРШЕНЬ»"
ITEM.description = "Разработанный в 2024-м году бронекостюм «ШЕРШЕНЬ» - высоко показал себя во время ведения боевых действий и испытаний, и уже в 2026-м году практически весь штатный состав сил Метромахта был облачён в подобную экипировку. Сама броня представляет собой лёгкую форму с броневыми вставками на уровне живота и КПР в районе локтей и рук. Высоко ценится бойцами - аналогов не имеет."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/kek1ch/stalker_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(23.24, 2.42, 198.94),
	ang = Angle(85.62, 180.09, 0),
	fov = 8.41
}
ITEM.weight = 5
ITEM.damage = {
    0.6, -- Пулестойкость
    0.5, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.4, -- Взрывчатка
    0.5, -- Защита от падения
}
ITEM.Strengthneed = 5
ITEM.HitGroupScaleDmg = {
    --[HITGROUP_HEAD] = false,
	--[HITGROUP_CHEST] = false,
	[HITGROUP_STOMACH] = true,
	[HITGROUP_LEFTARM] = true,
	[HITGROUP_RIGHTARM] = true,
	--[HITGROUP_LEFTLEG] = false,
	--[HITGROUP_RIGHTLEG] = false,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 45
ITEM.quality = "rare"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 3,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 
 