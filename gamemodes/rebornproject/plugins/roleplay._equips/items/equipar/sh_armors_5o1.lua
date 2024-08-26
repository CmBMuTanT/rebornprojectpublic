ITEM.name = "Учёная химическая защита"
ITEM.description = "Имеет зелёный окрас. Учёная химическая защита, не имеет никакой пулевой защиты - но дает хорошую защиту от порезов, или био-хио-угроз.."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/kek1ch/ecolog_outfit_green.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(-208.44, 1.39, 703.85),
	ang = Angle(73.38, 359.65, 0),
	fov = 1.57
}

ITEM.weight = 8
ITEM.damage = {
    0.9, -- Пулестойкость
    0.4, -- Защита от порезов
    0.3, -- Электрозащита
    0.2, -- Термозащита
    0.4, -- Радиозащита
    0.3, -- Химзащита
    0.9, -- Взрывчатка
    0.8, -- Защита от падения
}
ITEM.Strengthneed = 7
ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
    [HITGROUP_RIGHTARM] = true,
    [HITGROUP_LEFTARM] = true,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 15
ITEM.quality = "uncommon"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 5,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

 ----Skin Gropus----
ITEM.SGname = "sg_chemsuit" -- название SkinGroup
ITEM.skingroupar = 1 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end

