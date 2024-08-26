ITEM.name = "Тяжелый бронекомплект «АРВ-ЕК» - «Перекрашенный КГ»"
ITEM.description = "Тяжелый бронекомплект - что собирается по чертежам неизвестного техника с Кузнецкого Моста.. Звали его как вы помните - Гоша Семецкий, интересно - что с ним сейчас?.. Сама броня представляет собою массу бронепластин скрепленных между собою, распределены они по-формату защиты ЖВО, РРП и остальных вважных мест в теле человека.. Весит - просто дохрена! Навряд-ли подобную дуру вообще носить возможно.."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/kek1ch/bandit_exo_outfit.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(259.28, -0.9, 686.96),
	ang = Angle(68.88, 179.79, 0),
	fov = 3.61
}
ITEM.Armor = 65
ITEM.weight = 13
ITEM.damage = {
    0.2, -- Пулестойкость
    0.1, -- Защита от порезов
    0.4, -- Электрозащита
    0.2, -- Термозащита
    0.2, -- Радиозащита
    0.2, -- Химзащита
    0.1, -- Взрывчатка
    0.1, -- Защита от падения
}
ITEM.Strengthneed = 30
ITEM.HitGroupScaleDmg = {
    --[HITGROUP_HEAD] = false,
	[HITGROUP_CHEST] = true,
	[HITGROUP_STOMACH] = true,
	[HITGROUP_LEFTARM] = true,
	[HITGROUP_RIGHTARM] = true,
	[HITGROUP_LEFTLEG] = true,
	[HITGROUP_RIGHTLEG] = true,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 45
ITEM.quality = "legendary"
ITEM.inventoryType = "unloading"
ITEM.bodyGroups = {
    ["Броня"] = 1,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

 ----Skin Gropus----
ITEM.SGname = "sg_tb_prikoli" -- название SkinGroup
ITEM.skingroupar = 1 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end
