ITEM.name = "Комплект штанов «СНЕЖОК-85-КАМУФЛЯЖНЫЙ»"
ITEM.description = "Перекрашенная версия `ФСС`, обычно носятся передовыми военными группами Ордена. Обеспечивают наилучшую защиту практически во всем, имеют массу аналогов - но ни один из них не дошел до того уровня качества, что предлагает 84-я версия. Единственный минус комплектации - плохая защита от холода.."
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
ITEM.Strengthneed = 25
ITEM.width = 1
ITEM.height = 1
 
  
ITEM.damage = {
    0.2, -- Пулестойкость
    0.2, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.5, -- Взрывчатка
    0.3, -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_LEFTLEG] = true,
    [HITGROUP_RIGHTLEG] = true,
}

ITEM.LookupBone = "bip01_l_foot"
ITEM.CamPosVec = Vector(-36, 2.5, 15)
ITEM.Warm = 25
ITEM.quality = "ultralegendary"
ITEM.inventoryType = "legs"
ITEM.bodyGroups = {
    ["Ноги"] = 16,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Штаны" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

----Skin Gropus----
ITEM.SGname = "sg_sparta_2_nogi" -- название SkinGroup
ITEM.skingroupar = 3 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end
