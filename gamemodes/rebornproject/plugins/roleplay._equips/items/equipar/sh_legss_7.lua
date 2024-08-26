ITEM.name = "Тактические штаны «С.В.А.Р.Г.»"
ITEM.description = "«С.В.А.Р.Г.» - Очень популярные кустарно-воссозданные штаны. Создавались на основе тактической экипировки спец.отрядов ФСБ-РФ и ССО. Являются довольно редкими. Обеспечивают хорошую защиту, пулевую, термовую.. Вцелом, вполне хороши. \n\n У штанов синяя окраска"
ITEM.category = "[EQ] LEGS"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/rookie_outfit.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(31.69, 0.33, 733.39),
	ang = Angle(87.4, 180.28, 0),
	fov = 2.36
}
ITEM.Strengthneed = 10
ITEM.width = 1
ITEM.height = 1

ITEM.damage = {
    0.5, -- Пулестойкость
    0.6, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.4 -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_LEFTLEG] = true,
    [HITGROUP_RIGHTLEG] = true,-- хитбоксы
}

ITEM.LookupBone = "bip01_l_foot"
ITEM.CamPosVec = Vector(-36, 2.5, 15)
ITEM.Warm = 10
ITEM.quality = "ultralegendary"
ITEM.inventoryType = "legs"
ITEM.bodyGroups = {
    ["Ноги"] = 7,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Штаны" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

----Skin Gropus----
ITEM.SGname = "sg_sparta_1_nogi" -- название SkinGroup
ITEM.skingroupar = 0 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end
