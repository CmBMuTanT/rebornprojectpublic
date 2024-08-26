ITEM.name = "«АЛТЫН» | Метромахт"
ITEM.description = "«Алтын» — советский, а затем российский противопульный боевой шлем закрытого типа, разработанный НИИ Стали по заказу КГБ СССР в 1984 году. \n На самом шлеме заметны гравировки и символика 4-го Рейха\n На самом шлеме заметны гравировки и символика «4-го Рейха»"
ITEM.category = "[EQ] HEAD"-- ватермелон)
ITEM.width = 1
ITEM.height = 1
ITEM.exRender = true
ITEM.model = "models/z-o-m-b-i-e/metro_ll/equipment/m_ll_helmet_lynx_01.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(726.92, -4.71, 102.08),
	ang = Angle(7.94, 179.62, 0),
	fov = 1.1
}
ITEM.weight = 3.5
ITEM.Strengthneed = 15
ITEM.damage = {
    0.4, -- Пулестойкость
    0.1, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.5, -- Взрывчатка
    0.5 -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_HEAD] = true -- хитбоксы
}
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 25
ITEM.quality = "legendary"
ITEM.inventoryType = "helmet"
ITEM.bodyGroups = {
    ["Шапки,шлема"] = 20,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Шлема" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита
 
----Skin Gropus----
ITEM.SGname = "sg_broneshlem" -- название SkinGroup
ITEM.skingroupar = 2 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end
