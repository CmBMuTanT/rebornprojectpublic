ITEM.name = "Балаклава-2 Специальная"
ITEM.description = ""
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/helm_maska.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-12.97, -0.05, 192.69),
	ang = Angle(86.84, 359.8, 0),
	fov = 4.04
}
ITEM.weight = 0.5
ITEM.width = 1
ITEM.height = 1

ITEM.damage = {
    0.9, -- Пулестойкость
    0.9, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.9, -- Защита от падения
}

ITEM.HitGroupScaleDmg = {
	[HITGROUP_HEAD] = true,
}
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 45
ITEM.quality = "uncommon"
ITEM.inventoryType = "head_balaclava"
ITEM.bodyGroups = {
    ["Балаклавы"] = 2,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Балаклава" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

ITEM.SGname = "sg_mask" -- название SkinGroup
ITEM.skingroupar = 2 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end
