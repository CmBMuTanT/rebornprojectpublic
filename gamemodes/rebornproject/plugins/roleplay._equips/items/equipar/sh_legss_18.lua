ITEM.name = "Комплект штанов `1-1-3`"
ITEM.description = "Штаны тактического значения, приспособлены к холодному климату - и к военной обстановке. Позиционируются как `КУСТАРНО-МОДЕРНЕЗИРОВАННЫЕ`. Выглядят вполне неплохо, а защищают - прекрасно! Все ноги будут защищены что от пуль, что от порезов! Наверное, лучшие штаны в этих тоннелях.."
ITEM.category = "[EQ] LEGS"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/rookie_outfit.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(31.69, 0.33, 733.39),
	ang = Angle(87.4, 180.28, 0),
	fov = 2.36
}
ITEM.Strengthneed = 25
ITEM.width = 1
ITEM.height = 1

ITEM.damage = {
    0.2, -- Пулестойкость
    0.3, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.6, -- Взрывчатка
    0.3, -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_LEFTLEG] = true,
    [HITGROUP_RIGHTLEG] = true,
}

ITEM.LookupBone = "bip01_l_foot"
ITEM.CamPosVec = Vector(-36, 2.5, 15)
ITEM.Warm = 65
ITEM.quality = "ultralegendary"
ITEM.inventoryType = "legs"
ITEM.bodyGroups = {
    ["Ноги"] = 18,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Штаны" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

