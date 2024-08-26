ITEM.name = "Армейские штаны «ХОР-2»"
ITEM.description = "Эти штаны последовательной линейки штанов армейского образца «ХОР» являются одними из самых лучших в своём роде, удобные - тёплые и что самое главное хорошо защищённые. Большинство сталкеров отдают свой голос в пользу этих штанов!"
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
ITEM.Strengthneed = 5
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
    0.7 -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_LEFTLEG] = true,
    [HITGROUP_RIGHTLEG] = true,--- хитбоксы
}

ITEM.LookupBone = "bip01_l_foot"
ITEM.CamPosVec = Vector(-36, 2.5, 15)
ITEM.Warm = 45
ITEM.quality = "rare"
ITEM.inventoryType = "legs"
ITEM.bodyGroups = {
    ["Ноги"] = 3,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Штаны" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

ITEM.SGname = "sg_stalker_2_nogi" -- название SkinGroup
ITEM.skingroupar = 1 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end