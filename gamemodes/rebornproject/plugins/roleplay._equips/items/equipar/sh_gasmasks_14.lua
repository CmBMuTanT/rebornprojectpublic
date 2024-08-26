ITEM.name = "ПБФ «Хомяк»"
ITEM.description = "При конструировании и создании - Предполагалось, что это будет легкий противогаз, в котором не будет фильтра из тяжелого металлического баллона или шланга. На данный момент - ХОМЯКИ покинули рынок, и остались лишь.. Пожалуй на вооружении у Рейха. Этот `ХОМЯК` - не исключение, у него имеются гравировки о принадлежности `ПУШКИНСКАЯ-ЧЕХОВСКАЯ-ЧЕРНАЯ`.."
ITEM.category = "[EQ] HEAD"

ITEM.width = 1
ITEM.height = 1
ITEM.weight = 1
ITEM.damage = {
    0.9, -- Пулестойкость
    0.9, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.9, -- Взрывчатка
    0.9 -- Защита от падения
}
ITEM.HitGroupScaleDmg = {
	[HITGROUP_HEAD] = true,
}

ITEM.quality = "ultralegendary"
ITEM.inventoryType = "head_gasmask"

ITEM.EQsound = "gasmask/gasmask_on_fast.wav"
ITEM.DEQsound = "gasmask/gasmask_holster_fast.wav"
ITEM.IsMask = true -- это противогаз.
ITEM.bodyGroups = {
    ["Противогазы,маски,респираторы"] = 14,
}
ITEM.MaterialOverlay = "effects/ui_maska_moist"
ITEM.LookupBone = "bip01_head"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.exRender = true 
ITEM.model = "models/kek1ch/helm_respirator_gp9.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-200, 0.56, -1.12),
	ang = Angle(-0.57, -0.16, 0),
	fov = 3.6
}

--------------------Visuals--------------------
