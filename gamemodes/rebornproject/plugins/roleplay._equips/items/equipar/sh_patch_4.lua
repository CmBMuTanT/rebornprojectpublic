ITEM.name = "«Жёлтая повязка»"
ITEM.description = "Фактически - повязки помогут определять людей на класс СВОИ/ЧУЖИЕ. Ещё бы! Их производство крайне дешево обходится не только станциям, но и простым сталкерам-работягам - а эффект обозначаемости повязки сохраняют идеально!"
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true
ITEM.model = "models/kek1ch/sumka1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(5.33, 0.22, 199.93),
	ang = Angle(91.53, 2.34, 0),
	fov = 5.36
}

ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.1
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
    [HITGROUP_HEAD] = false,
}
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.quality = "uncommon"
ITEM.inventoryType = "patch"
ITEM.bodyGroups = {
    ["Повязка"] = 1,
}
ITEM.Warm = 0

--------------------Visuals--------------------
ITEM.outfitCategory = ""

----Skin Gropus----
ITEM.SGname = "sg_armband" -- название SkinGroup
ITEM.skingroupar = 4 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end