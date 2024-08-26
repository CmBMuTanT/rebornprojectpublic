ITEM.name = "Боевой комплект «МИРОТВОРЕЦ»"
ITEM.description = "БЕЗ ОПОЗНОВАТЕЛЬНЫХ ЗНАКОВ. Как вам известно подобная броня была принята на вооружение Спартой, и носится в подавляющем ей же. Имеет голубовато-синюю окраску, базовые бронепластины - и какую-никакую тепло-ветрозащиту. Выглядит вполне ново, что и добавляет не только антуражности бойцам на стимуле силы и объединенности - но и общие показатели качества в плюсовую сторону."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/hardbass/stalker_bandit_1_lrazgryz.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(714.24, -8.23, 169.25),
	ang = Angle(13.34, 179.32, 0),
	fov = 1.6
}
ITEM.Strengthneed = 8
ITEM.width = 2
ITEM.height = 3
ITEM.weight = 4.5
ITEM.damage = {
    0.6, -- Пулестойкость
    0.6, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.7, -- Взрывчатка
    0.7, -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 65
ITEM.quality = "uncommon"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 15,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic2 #99388.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 
 
ITEM.SGname = "sg_sparta_1_telo" -- название SkinGroup
ITEM.skingroupar = 5 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end