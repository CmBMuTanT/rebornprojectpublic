ITEM.name = "Спартанский шлем с гравировкой"
ITEM.description = "Обязательный элемент брони каждого спартанца, обеспечивает защиту головы и, что особенно важно при вылазках на поверхность, не мешает пользоваться противогазом."
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true 
ITEM.model = "models/maver1k_xvii/metro_digger_helmet.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(733.51, -0.92, -28.44),
	ang = Angle(-2.28, 179.93, 0),
	fov = 0.88
}

ITEM.damage = {
    0.4, -- Пулестойкость
    0.3, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.6, -- Химзащита
    0.4, -- Взрывчатка
    0.4, -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_HEAD] = true -- хитбоксы
}
ITEM.Strengthneed = 15
ITEM.Warm = 85
ITEM.quality = "legendary"
ITEM.inventoryType = "helmet"
ITEM.bodyGroups = {
    ["Шапки,шлема"] = 25,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
--------------------Visuals--------------------

ITEM.outfitCategory = "Шлема" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

 ----Skin Gropus----
ITEM.SGname = "sg_shlem_sparta" -- название SkinGroup
ITEM.skingroupar = 1 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end