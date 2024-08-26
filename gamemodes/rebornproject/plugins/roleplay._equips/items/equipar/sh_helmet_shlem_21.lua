ITEM.name = "Шлем противоударный «Колпак-1С»"
ITEM.description = "Защитный шлем Колпак-1С предохраняет голову от поражения холодным колюще-режущим оружием по специальному классу защиты ГОСТ Р50744-95, от осколочных ранений с энергией удара до 50 Дж, а также служит для снижения динамических нагрузок, возникающих при воздействии вышеуказанных средств поражения."
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true 
ITEM.model = "models/hardbass/stalker_skat9m_helem.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(199.52, -2.78, 13.62),
	ang = Angle(3.94, -180.79, 0),
	fov = 3.32
}
ITEM.Strengthneed = 5
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1.5
ITEM.damage = {
    0.7, -- Пулестойкость
    0.2, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.7, -- Взрывчатка
    0.2, -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_HEAD] = true -- хитбоксы
}

ITEM.Warm = 25
ITEM.quality = "common"
ITEM.inventoryType = "helmet"
ITEM.bodyGroups = {
    ["Шапки,шлема"] = 22,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
--------------------Visuals--------------------

ITEM.outfitCategory = "Шлема" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита


