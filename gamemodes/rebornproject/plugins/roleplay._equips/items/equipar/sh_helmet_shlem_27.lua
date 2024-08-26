ITEM.name = "СШ-68 - МОДЕРНЕЗИРОВАННЫЙ - ᛋᛋ"
ITEM.description = "Модернезированная версия легендарного советского шлема СШ-68, имеет улучшенную пулевую защиту - и гравировки о принадлежности к Метромахту."
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true
ITEM.model = "models/hardbass/stalker_soldier3k_helem.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(733.07, 24.86, -28.99),
	ang = Angle(-2.31, 181.95, 0),
	fov = 0.96
}
-- ватермелон)
ITEM.weight = 2
ITEM.Strengthneed = 5
ITEM.damage = {
    0.7, -- Пулестойкость
    0.7, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.6, -- Химзащита
    0.4, -- Взрывчатка
    0.6, -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_HEAD] = true -- хитбоксы
}

ITEM.Warm = 25
ITEM.quality = "uncommon"
ITEM.inventoryType = "helmet"
ITEM.bodyGroups = {
    ["Шапки,шлема"] = 28,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
--------------------Visuals--------------------

ITEM.outfitCategory = "Шлема" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

