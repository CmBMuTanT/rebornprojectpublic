ITEM.name = "Шлем ФОРТ «Кивер-M»"
ITEM.description = "Бронешлем ФОРТ «Кивер-М». Пуленепробиваемые шлемы ФОРТ «Кивер-М» разработаны для использования офицерами спецподразделений правоохранительных органов. Имеет хорошую тепло-защиту. Шлем предназначен для круговой защиты головы от пуль автоматического пистолета Стечкина, пуль под патрон Люгер-Парабеллум и осколков на уровне 570 м/с. Уникальная многокомпонентная защитная структура бронешлема практически полностью поглощает ударный импульс пули, передаваемый на голову и шейный отдел позвоночника, что в сочетании с высоким запасом пулестойкости обеспечивает нулевую травму. \n Перекрашен под серый цвет"
ITEM.category = "[EQ] HEAD"
ITEM.exRender = true
ITEM.model = "models/hardbass/helm512.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(730.54, 30.5, 65.04),
	ang = Angle(4.87, 182.4, 0),
	fov = 0.93
}
ITEM.Strengthneed = 15
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 3
ITEM.damage = {
    0.5, -- Пулестойкость
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
ITEM.Warm = 65
ITEM.quality = "rare"
ITEM.inventoryType = "helmet"
ITEM.bodyGroups = {
    ["Шапки,шлема"] = 31,
}
ITEM.EQsound = "eftsounds/gear_helmet_use.wav"
ITEM.DEQsound = "eftsounds/gear_helmet_drop.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Шлема" -- название категории
ITEM.outfit_name = "Шапка хуяпка" -- название оутфита

