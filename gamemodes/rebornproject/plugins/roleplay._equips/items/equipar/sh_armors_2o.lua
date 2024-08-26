ITEM.name = "Специализированный бронекостюм «ПРИЦЕЛ»"
ITEM.description = "Специализированный снайперский бронекостюм «ПРИЦЕЛ» достаточно удобен в ношении, хорош в утеплении - и фактически улучшен в сравнении со своим сталкерским аналогом. На смену старой системе удержания бронеплит пришла новая - которая позволила вставить улучшенные керамические броневые вставки и обеспечить большую защиту бойцу, которому выпадет честь нести службу во благо Красной Линии в этом комплекте брони!"
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
    0.5, -- Пулестойкость
    0.5, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.6, -- Взрывчатка
    0.4, -- Защита от падения
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
    ["Тело"] = 2,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

----Skin Gropus----
ITEM.SGname = "sg_sniper_telo" -- название SkinGroup
ITEM.skingroupar = 1 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end
