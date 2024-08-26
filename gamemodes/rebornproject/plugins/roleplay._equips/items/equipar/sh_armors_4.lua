ITEM.name = "Специализированный бронекостюм «ТИГР»"
ITEM.description = "Разработанный в 2027-м году бронекостюм «ТИГР» - безоговорочно опередил своё время лет эдак на пять. Лучшие техники «Пушкинской» и наёмные профессора с «Арбатской» смогли создать лучшую комбинацию элементов брони достигнув рамок средней комплектации - на относительно лёгкий вес и комфортное ношение. Все эти фактические аттрибуты производства (Которое к слову было крайне облегчено в силу ранее названных факторов) сыграли на финальном решении Министерства Экономики и Производства 4-го Рейха, которое и утвердило данную комплектацию на ряд средней брони в производстве и переобмундировании."
ITEM.category = "[EQ] BODY"
ITEM.exRender = true
ITEM.model = "models/kek1ch/stalker_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(23.24, 2.42, 198.94),
	ang = Angle(85.62, 180.09, 0),
	fov = 8.41
}
ITEM.weight = 5
ITEM.damage = {
    0.5, -- Пулестойкость
    0.4, -- Защита от порезов
    0.9, -- Электрозащита
    0.9, -- Термозащита
    0.9, -- Радиозащита
    0.9, -- Химзащита
    0.4, -- Взрывчатка
    0.4, -- Защита от падения
}
ITEM.Strengthneed = 5
ITEM.HitGroupScaleDmg = {
    --[HITGROUP_HEAD] = false,
	--[HITGROUP_CHEST] = true,
	[HITGROUP_STOMACH] = true,
	[HITGROUP_LEFTARM] = true,
	[HITGROUP_RIGHTARM] = true,
	--[HITGROUP_LEFTLEG] = false,
	--[HITGROUP_RIGHTLEG] = false,
}

ITEM.LookupBone = "bip01_spine"
ITEM.CamPosVec = Vector(-32, 0, 0)
ITEM.Warm = 45
ITEM.quality = "legendary"
ITEM.inventoryType = "armor"
ITEM.bodyGroups = {
    ["Тело"] = 4,
}
ITEM.EQsound = "eftsounds/gear_armor_use.wav"
ITEM.DEQsound = "eftsounds/backpack_drop_generic3.wav"

--------------------Visuals--------------------

ITEM.outfitCategory = "Армор" -- название категории
ITEM.outfit_name = "Пидорасня" -- название оутфита
 

 