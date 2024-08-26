ITEM.name = "Бронекомплект «ЧУВЫРЛА»"
ITEM.description = "Почему этот комплект так назвали? Да черт их знает, думаю.. На Китай-Городе - с названием особо не церемонились.. Но, стоит отметить, защита живота - тут отменная! Ну, если рассматривать перспективу «ЦЕНА | КАЧЕСТВО», обычно носится банд-формированиями с Китай-Города, нашивки на самой броне соответствующие.."
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
ITEM.weight = 4.5
ITEM.damage = {
    0.6, -- Пулестойкость
    0.5, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.5, -- Взрывчатка
    0.4, -- Защита от падения
}

ITEM.HitGroupScaleDmg = {
    [HITGROUP_STOMACH] = true,
}
ITEM.Strengthneed = 15
ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 5
ITEM.quality = "uncommon"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 22,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic2 #99388.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

----Skin Gropus----
 