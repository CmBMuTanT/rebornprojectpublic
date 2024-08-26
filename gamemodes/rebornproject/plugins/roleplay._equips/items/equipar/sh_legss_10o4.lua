ITEM.name = "Тактические штаны «ЧИЖ-УКРЕППЛЕНЫЙ-КШАТРИЙСКИЙ-2»"
ITEM.description = "Данные штаны начали производится в начале 2025-го года силами Полиса. На данный момент - эти штаны являются основопологающе-штурмовыми, их харастеристики, по словам бойцов из их опыта - вполне высоки.. На самом деле, комлектация этих штанов имеет высокий спрос даже на сталкерском рынке!.. Наверное, это уже о чём-то говорит.."
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
ITEM.Strengthneed = 10
ITEM.width = 1
ITEM.height = 1

ITEM.damage = {
    0.5, -- Пулестойкость
    0.3, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.6 -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_LEFTLEG] = true,
    [HITGROUP_RIGHTLEG] = true,-- хитбоксы
}

ITEM.LookupBone = "bip01_l_foot"
ITEM.CamPosVec = Vector(-36, 2.5, 15)
ITEM.Warm = 25
ITEM.quality = "rare"
ITEM.inventoryType = "legs"
ITEM.bodyGroups = {
    ["Ноги"] = 10,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Штаны" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

----Skin Gropus----
ITEM.SGname = "sg_soldier_nogi" -- название SkinGroup
ITEM.skingroupar = 6 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end