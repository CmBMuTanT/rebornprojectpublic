ITEM.name = "Офицерская полевая форма «ГОМ-КОМ»"
ITEM.description = "Фактическая приполевая одежда рассчитанная для ношения офицерами структуры НКВД, посему в районе грудной клетки расположена и вшита небольшая бронепластина.. Вопрос лишь один - как её туда умудрились адаптировать?!.. Имеет лычку «ЛУБЯНКА-КРАСНОСЕЛЬСКАЯ». "
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
ITEM.weight = 3
ITEM.damage = {
    0.8, -- Пулестойкость
    0.9, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.8, -- Взрывчатка
    0.8, -- Защита от падения
}

ITEM.HitGroupScaleDmg = {
    [HITGROUP_STOMACH] = true,
    [HITGROUP_RIGHTARM] = true,
}
ITEM.Strengthneed = 0
ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 89
ITEM.quality = "common"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 19,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic2 #99388.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

----Skin Gropus----
 