ITEM.name = "Бронекомплект «БАРД-0»"
ITEM.description = "Перекрашена в чёрный цвет. Бронекомплект представляющий из себя набор тёплой одежды с подвешенным спереди добротным бронежилетом, с не менее добротными бронепластинами! Имеет высокий спрос практически ВЕЗДЕ - где только есть человек с оружием, несущий службу. Это не бронекомплект - это идеал!.. \n Имеются нашивки Метромахта"
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/kek1ch/military_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(84.41, -0.99, 729.54),
	ang = Angle(83.5, 179.24, 0),
	fov = 2.32
}

ITEM.weight = 5.5
ITEM.damage = {
    0.4, -- Пулестойкость
    0.4, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.2, -- Взрывчатка
    0.3, -- Защита от падения
}

ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
	[HITGROUP_LEFTARM] = true,
	[HITGROUP_RIGHTARM] = true,    
}
ITEM.Strengthneed = 25
ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 5
ITEM.quality = "legendary"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 23,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic2 #99388.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 
----Skin Gropus----
ITEM.SGname = "sg_stalker_2_body" -- название SkinGroup
ITEM.skingroupar = 1 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end