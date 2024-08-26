ITEM.name = "Бронекомплект «НОВОРОС»"
ITEM.description = "Профессиональная экипировка - относящаяся к специализированным структурам ВС.МЕТРОМАХТА. Имеет вполне хорошую укрепленность, утепленность - да и в-целом внешний вид.. Единственный нюанс - слабая защита груди, но обратный плюс - очень хорошая защита живота."
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

ITEM.weight = 11
ITEM.damage = {
    0.2, -- Пулестойкость
    0.3, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.7, -- Взрывчатка
    0.3, -- Защита от падения
}

ITEM.HitGroupScaleDmg = {
    [HITGROUP_STOMACH] = true,
    [HITGROUP_RIGHTARM] = true,
    [HITGROUP_LEFTARM] = true,
}
ITEM.Strengthneed = 15
ITEM.runSpeed = 0.1
ITEM.walkSpeed = 0.1
ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 89
ITEM.quality = "legendary"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 18,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic2 #99388.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

----Skin Gropus----
 
