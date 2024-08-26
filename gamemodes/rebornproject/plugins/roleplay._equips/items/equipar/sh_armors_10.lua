ITEM.name = "Штурмовой бронекомплект «ДЫМ»"
ITEM.description = "Штурмовой бронекомплект «ДЫМ» - является одним из популярнейших прототипов штурмовой брони в Метрополитене. Чего уж говорить про отношение опытных сталкеров к этому бронекомплекту - если сама «КОЛЬЦЕВАЯ» не брезгует закупать подобный брноекомплект на оснащение своей армии?.. Он удобен, практичен - и даже хорошо защищён. Наверное, никто не ошибется - если назовёт этот бронекомплект эталоном сталкерской мечты."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/hardbass/happy_armor_6b.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(715.04, -5.53, 165.94),
	ang = Angle(12.13, 179.56, 0),
	fov = 1.69
}
-- ватермелон)
ITEM.weight = 7.5
ITEM.damage = {
    0.4, -- Пулестойкость
    0.6, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.8, -- Взрывчатка
    0.7, -- Защита от падения
}
ITEM.Strengthneed = 15
ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
    [HITGROUP_RIGHTARM] = true,
    [HITGROUP_LEFTARM] = true,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.runSpeed = 0.74
ITEM.walkSpeed = 0.89

ITEM.Warm = 25
ITEM.quality = "legendary"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 10,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

----Skin Gropus----
 