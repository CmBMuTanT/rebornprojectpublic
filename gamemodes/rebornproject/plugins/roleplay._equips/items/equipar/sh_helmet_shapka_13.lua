ITEM.name = "Шлемофон"
ITEM.description = "Шлемофоны использовались экипажами и пилотами боевых и специальных машин, летательных аппаратов, моряками на боевых постах, инженерно-техническим персоналом и рядом других лиц."
ITEM.category = "[EQ] HEAD"
ITEM.model = "models/kek1ch/sumka1.mdl" -- ватермелон)

ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1.5
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

ITEM.Warm = 45
ITEM.quality = "legendary"
ITEM.inventoryType = "helmet"
ITEM.bodyGroups = {
    ["Шапки,шлема"] = 14,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
--------------------Visuals--------------------

ITEM.outfitCategory = "Шлема" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита
ITEM.iconCam = {
    pos = Vector(509.64, 427.61, 310.24),
    ang = Angle(25, 220, 0),
    fov = 1.42
}

