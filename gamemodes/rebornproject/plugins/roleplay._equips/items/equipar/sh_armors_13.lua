ITEM.name = "Бронекомплект ОН - «ВОЛЯ»"
ITEM.description = "Этот бронекомплект ОН (Основного ношения) - обычно используется сталкерским сообществом, за то и закрепилось за ним общее название - `ВОЛЯ`, никто не знает почему.. Просто - ВОЛЯ, и все тут. Защита - вполне качественная, и вполне хорошая. Выглядит - ново, может, вам повезло, и вы всего лишь пятый владелец!"
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/kek1ch/cs_heavy_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(178.13, 9.42, 712.07),
	ang = Angle(75.97, 182.31, 0),
	fov = 1.91
}
ITEM.weight = 4
ITEM.damage = {
    0.6, -- Пулестойкость
    0.5, -- Защита от порезов
    0.9, -- Электрозащита
    0.8, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.8, -- Взрывчатка
    0.9, -- Защита от падения
}
ITEM.Strengthneed = 9
ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
    [HITGROUP_RIGHTARM] = true,
    [HITGROUP_LEFTARM] = true,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 21
ITEM.quality = "rare"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 13,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

 