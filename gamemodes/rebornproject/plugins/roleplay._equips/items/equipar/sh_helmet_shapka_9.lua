ITEM.name = "Шапка-ушанка `КОВАЛЬ`"
ITEM.description = "Обычная шапка-ушанка, имеющая обиходное название `КОВАЛЬ`. Точно - никто не знает, откуда это пошло, но.."
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/helm_furhat.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-198.94, 0.78, 38.07),
	ang = Angle(9.08, 359.77, 0),
	fov = 4
}

ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1
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
    ["Шапки,шлема"] = 10,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Шлема" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита


