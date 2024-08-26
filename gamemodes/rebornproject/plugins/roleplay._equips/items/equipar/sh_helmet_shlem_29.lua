ITEM.name = "«СШ-68»"
ITEM.description = "СШ-68 (стальной шлем образца 1968 года) — дальнейшее развитие общевойскового шлема СШ-60. Отличается от предшествовавшей каски СШ-60 большей прочностью, большим наклоном передней (лобовой) стенки купола и укороченными бортиками, отогнутыми наружу."
ITEM.category = "[EQ] HEAD"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1.5
ITEM.damage = {
    0.8, -- Пулестойкость
    0.8, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.8, -- Взрывчатка
    0.8, -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_HEAD] = true -- хитбоксы
}
ITEM.Strengthneed = 5
ITEM.Warm = 25
ITEM.quality = "common"
ITEM.inventoryType = "helmet"
ITEM.bodyGroups = {
    ["Шапки,шлема"] = 30,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
--------------------Visuals--------------------

ITEM.outfitCategory = "Шлема" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита
ITEM.exRender = true 
ITEM.model = "models/hardbass/stalker_skat9m_helem.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(199.52, -2.78, 13.62),
	ang = Angle(3.94, -180.79, 0),
	fov = 3.32
}


