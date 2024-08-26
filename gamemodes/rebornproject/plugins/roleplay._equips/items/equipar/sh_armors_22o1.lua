ITEM.name = "Бронекомплект «ГОРДОНКА»"
ITEM.description = "Бронекомплект полностью идентичен тому, что производится на Китай-Городе - в исключениях тут используется иная жилетка более яркого цвета. У данной брони нет приоритета, что у КГшной, что у этой одинаковая комплектация бронепластин - которые к слову, обеспечивают довольно качественную защиту в районе живота, одинаковые материалы под пошив и остальное.. Посему - никаких изменений по защите тут попросту нет!.. Нашивок нет, но - как гласят слухи - подобную замены КГшных курток-централок носят сторонние бандитские организации внутри Метрополитена - и извне.."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/rookie_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(48.82, 0.2, 732.45),
	ang = Angle(86.2, 180.16, 0),
	fov = 2.22
}
ITEM.weight = 4.5
ITEM.damage = {
    0.6, -- Пулестойкость
    0.5, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.5, -- Взрывчатка
    0.4, -- Защита от падения
}

ITEM.HitGroupScaleDmg = {
    [HITGROUP_STOMACH] = true,
}
ITEM.Strengthneed = 15
ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 5
ITEM.quality = "uncommon"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 22,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic2 #99388.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

----Skin Gropus----
ITEM.SGname = "sg_bandit_2_telo" -- название SkinGroup
ITEM.skingroupar = 1 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end