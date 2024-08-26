ITEM.name = "Шлем «АЛТЫН-КУСТАРНЫЙ»"
ITEM.description = "Шлем - который обычно используется для легких штурмовых групп, не имеет никакой принадлежности к какой-либо группировке. Выглядит поношенно, но.. не время выбирать?"
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true
ITEM.model = "models/z-o-m-b-i-e/metro_ll/equipment/m_ll_helmet_lynx_01.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(726.92, -4.71, 102.08),
	ang = Angle(7.94, 179.62, 0),
	fov = 1.1
}
ITEM.Strengthneed = 10
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 3
ITEM.damage = {
    0.6, -- Пулестойкость
    0.3, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.7, -- Взрывчатка
    0.6 -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_HEAD] = true -- хитбоксы
}

ITEM.Warm = 25
ITEM.quality = "rare"
ITEM.inventoryType = "helmet"
ITEM.bodyGroups = {
    ["Шапки,шлема"] = 23,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
--------------------Visuals--------------------

ITEM.outfitCategory = "Шлема" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

