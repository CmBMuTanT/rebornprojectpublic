ITEM.name = "Тактические штаны «ПОХОД-АРМ»"
ITEM.description = "Подкрашены в красный цвет. Доработанная версия штанов «ПОХОД», помимо хорошего материала что защищает от порезов и облегчает урон от падений - в эти штаны вшиты небольшие противопулевые пластины. Возможно, из-за этого пострадал показатель удобности и веса - но, защита всяко важнее."
ITEM.category = "[EQ] LEGS"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/rookie_outfit.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(31.69, 0.33, 733.39),
	ang = Angle(87.4, 180.28, 0),
	fov = 2.36
}
ITEM.Strengthneed = 0
ITEM.width = 1
ITEM.height = 1

ITEM.damage = {
    0.7, -- Пулестойкость
    0.6, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.5, -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_LEFTLEG] = true,
    [HITGROUP_RIGHTLEG] = true,
}

ITEM.LookupBone = "bip01_l_foot"
ITEM.CamPosVec = Vector(-36, 2.5, 15)
ITEM.Warm = 15
ITEM.quality = "common"
ITEM.inventoryType = "legs"
ITEM.bodyGroups = {
    ["Ноги"] = 12,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Штаны" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

----Skin Gropus----
ITEM.SGname = "sg_bandit_nogi" -- название SkinGroup
ITEM.skingroupar = 3 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end
