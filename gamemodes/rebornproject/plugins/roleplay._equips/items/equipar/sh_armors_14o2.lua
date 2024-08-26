ITEM.name = "Костюм «ХЗ»-«РУССЛАНД»"
ITEM.description = "Костюм химической защиты «РУССЛАНД» - это фактический модернезированный подтип сталкерского варианта костюма химической защиты «ВЕНДЕРА». Истоки свои начинает приблизительно с 2025-го года, когда указом Рейхминистра по вопросам военной промышленности был выдвинут проект с задачей укрепления собственного производства костюмов химической и противорадиоационной безопасности.. И что можно сказать? Задача была выполнена успешно! Безусловно, значительных изменений у этого костюма нет - однако, бронеплиты тут стоят всяко крепче и лучше чем на сталкерском аналоге, что уже не может не радовать.."
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
    0.2, -- Защита от порезов
    0.9, -- Электрозащита
    0.2, -- Термозащита
    0.1, -- Радиозащита
    0.2, -- Химзащита
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
ITEM.skingroupar = 2 -- значение SkinGroup

function ITEM:RSO_Equip(client)
    client:SetNWInt(self.SGname, self.skingroupar)
end

function ITEM:RSO_UnEquip(client)
    client:SetNWInt(self.SGname, 0)
end
 
 