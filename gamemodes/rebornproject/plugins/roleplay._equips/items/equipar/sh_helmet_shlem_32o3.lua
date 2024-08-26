ITEM.name = "Шлем «ФОРТ Кивер-M» - ТТС | «Метромахт»"
ITEM.description = "Бронешлем ФОРТ «Кивер-М». Пуленепробиваемые шлемы ФОРТ «Кивер-М» разработаны для использования офицерами спецподразделений правоохранительных органов. Имеет хорошую тепло-защиту. Шлем предназначен для круговой защиты головы от пуль автоматического пистолета Стечкина, пуль под патрон Люгер-Парабеллум и осколков на уровне 570 м/с. Уникальная многокомпонентная защитная структура бронешлема практически полностью поглощает ударный импульс пули, передаваемый на голову и шейный отдел позвоночника, что в сочетании с высоким запасом пулестойкости обеспечивает нулевую травму. \n Перекрашен под серый цвет"
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true 
ITEM.model = "models/hardbass/altin_st.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-732.23, 3.17, -71.05),
	ang = Angle(-5.71, 359.74, 0),
	fov = 0.96
}
ITEM.Strengthneed = 25
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 6
ITEM.damage = {
    0.2, -- Пулестойкость
    0.5, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.4, -- Взрывчатка
    0.5, -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
    [HITGROUP_HEAD] = true -- хитбоксы
}
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 55
ITEM.quality = "legendary"
ITEM.inventoryType = "helmet"
ITEM.bodyGroups = {
    ["Шапки,шлема"] = 33,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Шлема" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

----Skin Gropus----
ITEM.SGname = "sg_helmet_exodus" -- название SkinGroup
ITEM.skingroupar = 3 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end