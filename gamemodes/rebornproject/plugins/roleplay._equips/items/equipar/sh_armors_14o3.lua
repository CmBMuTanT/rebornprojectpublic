ITEM.name = "Костюм «ХЗ»-«ОРДЕНОНОСЕЦ»"
ITEM.description = "Один.. Нет! Самый лучший костюм противорадиационной защиты в Московском Метрополитене! Среди своих аналогов что от СССС, что от 4-го Рейха его выделяет не только улучшенная система бронезащиты - но и новый, более крепкий и упругий материал самого костюма что и позволило повысить защиту от порезов и долю самой защиты по показателям Р/ПХ.. Создавался приблизительно в районе 3-4х лет на Арбатской под грифом «СС», посему близких к нему по конкурентоспособности костюмов ещё попросту не нашлось.."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true 
ITEM.model = "models/kek1ch/scientific_outfit_merc.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(-87.98, -0.68, 728.78),
	ang = Angle(83.01, 359.94, 0),
	fov = 2.32
}

ITEM.weight = 8.5
ITEM.damage = {
    0.5, -- Пулестойкость
    0.1, -- Защита от порезов
    0.9, -- Электрозащита
    0.1, -- Термозащита
    0.1, -- Радиозащита
    0.1, -- Химзащита
    0.8, -- Взрывчатка
    0.5, -- Защита от падения
}
ITEM.Strengthneed = 14
ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
    [HITGROUP_RIGHTARM] = true,
    [HITGROUP_LEFTARM] = true,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 100
ITEM.quality = "ultralegendary"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 14,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic2 #99388.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

----Skin Gropus----
ITEM.SGname = "sg_himza" -- название SkinGroup
ITEM.skingroupar = 3 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end
 
 