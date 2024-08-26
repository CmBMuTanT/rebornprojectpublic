ITEM.name = "Голубой берет"
ITEM.description = ""
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true
ITEM.model = "models/kek1ch/helm_beret.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(535.4, 490.27, 108.69),
	ang = Angle(8.41, 222.54, 0),
	fov = 0.9
}

ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.5
ITEM.damage = {
    0.9, -- Пулестойкость
    0.9, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.9 -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_HEAD] = true -- хитбоксы
}
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 35
ITEM.quality = "common"
ITEM.inventoryType = "helmet"
ITEM.bodyGroups = {
    ["Шапки,шлема"] = 1,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Шлема" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита


