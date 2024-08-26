ITEM.name = "Специализированная форма «КОНТР»"
ITEM.description = "Данная одежда представляет собою шинель военного типа с небольшой поясовой пластиной, которая - по-всей видимости, рассчитана для защиты живота. Довольна легка в ношении, и сойдет как одежда для гражданского ношения - или для более-менее безопасных вылазок. Сталкерами ценится неоднозначно, как говорится - на вкус и цвет = разные потребители."
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
    0.8, -- Пулестойкость
    0.7, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.8, -- Взрывчатка
    0.7, -- Защита от падения
}
ITEM.Strengthneed = 5
ITEM.HitGroupScaleDmg = {
   --[HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
   --[HITGROUP_RIGHTARM] = true,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 45
ITEM.quality = "rare"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 9,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

----Skin Gropus----
 