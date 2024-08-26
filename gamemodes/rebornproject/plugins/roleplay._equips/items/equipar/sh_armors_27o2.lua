ITEM.name = "Бронекомплект «НОСОРОГ-ТЕНЬ»"
ITEM.description = "Один из самых тяжёлых штурмовых бронекомплектов армейской модернизации на станциях ССКЛ. Данный бронекомплект был разработан специально для привелигированных отрядов дислоцирующихся на Проспекте Мира - для большей безопасности столицы-оплотницы капитализма в стенах Метро!.. Сам бронекомплект показал себя вполне хорошо, и более того - его чертежи были проданы почти всем ведущим фракциям-государствам, что уже говорит о высоком спросе на него в рядах ВС."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/rookie_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(48.82, 0.2, 732.45),
	ang = Angle(86.2, 180.16, 0),
	fov = 2.22
}
ITEM.weight = 5.5
ITEM.damage = {
    0.3, -- Пулестойкость
    0.4, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.4, -- Взрывчатка
    0.4, -- Защита от падения
}

ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
}
ITEM.Strengthneed = 20
ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 85
ITEM.quality = "legendary"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 27,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic2 #99388.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита

----Skin Gropus----
ITEM.SGname = "sg_exodus_body" -- название SkinGroup
ITEM.skingroupar = 2 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end