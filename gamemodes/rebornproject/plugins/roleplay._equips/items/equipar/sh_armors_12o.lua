ITEM.name = "Специализированный бронекостюм «ЛЕС-М»"
ITEM.description = "Околотяжёлый бронекостюм «ЛЕС-М» - можно описать несколькими словами.. Тяжесть, защита, неудобство. \n Данный бронекомплект различий со сталкерским аналогом не имеет, в исключении лишь раскраска и общие обозначения в-виде нашивок на самом костюме."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/kek1ch/stalker_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(23.24, 2.42, 198.94),
	ang = Angle(85.62, 180.09, 0),
	fov = 8.41
}
ITEM.weight = 5
ITEM.damage = {
    0.6, -- Пулестойкость
    0.5, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.4, -- Взрывчатка
    0.5, -- Защита от падения
}
ITEM.Strengthneed = 5
ITEM.HitGroupScaleDmg = {
	[HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
    [HITGROUP_RIGHTARM] = true,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 45
ITEM.quality = "rare"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 12,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

----Skin Gropus----
ITEM.SGname = "sg_tb_body" -- название SkinGroup
ITEM.skingroupar = 1 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end

