ITEM.name = "Средний шлем `ФОРТОВИК`"
ITEM.description = "Шлем - который обычно используется для легких штурмовых групп, не имеет никакой принадлежности к какой-либо группировке. Выглядит поношенно, но.. не время выбирать?"
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true
ITEM.model = "models/hardbass/stalker_skat9m_helem.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(733.7, 21.04, 9.36),
	ang = Angle(0.73, 181.64, 0),
	fov = 0.93
}
ITEM.damage = {
    0.6, -- Пулестойкость
    0.8, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.7, -- Взрывчатка
    0.9 -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_HEAD] = true -- хитбоксы
}

ITEM.Warm = 25
ITEM.quality = "rare"
ITEM.inventoryType = "helmet"
ITEM.bodyGroups = {
    ["Шапки,шлема"] = 18,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
--------------------Visuals--------------------

ITEM.outfitCategory = "Шлема" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита
 

