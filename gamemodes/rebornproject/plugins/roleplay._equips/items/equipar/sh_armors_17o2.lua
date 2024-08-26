ITEM.name = "Боевой комплект «БЕРИЙ-S-КАМУФЛЯЖНЫЙ»"
ITEM.description = "На данный момент «БЕРИЙ-S» - является одной из самых популярных тяжело-укреплённых вариантов брони на вооружении среди состава вооруженных сил. Отличная защита практически по-всем показателям, и практически по-всем конечностям, что не может не радовать рядовой состав - которому в этой броне прийдется идти в прямое боестолкновение.. Выглядит ново, непотрёпанно - бронепластины чувствуются крайне сильно, видимо, их при проектации не жалели от слова совсем.. | Имеется нашивка  «SПАРТА»"
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/hardbass/stalker_bandit_1_lrazgryz.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(714.24, -8.23, 169.25),
	ang = Angle(13.34, 179.32, 0),
	fov = 1.6
}
ITEM.weight = 11
ITEM.damage = {
    0.3, -- Пулестойкость
    0.3, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.7, -- Взрывчатка
    0.3, -- Защита от падения
}
ITEM.Strengthneed = 20
ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
    [HITGROUP_RIGHTARM] = true,
    [HITGROUP_LEFTARM] = true,
}

ITEM.runSpeed = 0.64
ITEM.walkSpeed = 0.79
ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 89
ITEM.quality = "ultralegendary"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 17,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic2 #99388.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 
----Skin Gropus----
ITEM.SGname = "sg_sparta_2_telo" -- название SkinGroup
ITEM.skingroupar = 2 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end


