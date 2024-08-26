ITEM.name = "Комплект одежды «ХУТОР-1»"
ITEM.description = "Бронекомплект класса «ОШ», что соотносит его на один уровень с штурмовыми и позволяет использовать его практически в любых целях-операциях. Выглядит, конечно, не презентабельно - но в силу того что производится это «чудо» военной инженерии на Китай-Городе о большем мечтать не приходится. Скорее всего, сама внутренняя составляющая данного БК была позаимствована либо у Кольца, либо у Полиса - уж мало кому поверится в то, что у отродков с Китай-Города найдется хотяб с десяток толковых инженеров, что будут способны на создание своего бронекомплекта."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/kek1ch/novice_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(10.64, 0.48, 199.73),
	ang = Angle(87.74, -178.16, 0),
	fov = 6.32
}

ITEM.weight = 6.5
ITEM.damage = {
    0.4, -- Пулестойкость
    0.4, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.4, -- Защита от падения
}

ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
}
ITEM.Strengthneed = 15
ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 65
ITEM.quality = "rare"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 24,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic2 #99388.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 
----Skin Gropus----
 