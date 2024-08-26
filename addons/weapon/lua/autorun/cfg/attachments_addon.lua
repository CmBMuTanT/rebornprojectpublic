
--====	новинки для рельсы	============================================

hook.Add( "MakeMoreAtts", "MakeMoreAtts1", function()

stats = {
	attname = "relsa_battery", 													
	item = "item_relsa_battery", 												
	name = "Аккумулятор для рельсы", 												
	desc = "Меньший расход энергии при стрельбе", 	 														
	weight = 1.0, 														
	model = "models/Items/car_battery01.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/tihar/tihar_mags/icon_tihar_att_7"
	},
	atype = "relsa_stuff",
	charge_take = -2
}

CreateAttachmentItem(stats)

stats = {
	attname = "relsa_chargedshot", 													
	item = "item_relsa_chargedshot", 												
	name = "Улучшенные катушки для рельсы", 												
	desc = "Повышает урон от выстрела, увеличивая расход энергии", 	 														
	weight = 0.6, 														
	model = "models/props_lab/box01a.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/tihar/tihar_mags/icon_tihar_att_4"
	},
	atype = "relsa_stuff",
	charge_take = 2,
	damage = 20
}

CreateAttachmentItem(stats)

--=====================Fedorov==========================================
stats = {
	attname = "fedorov_mag1", 													
	item = "none", 														
	name = "Стандартный магазин", 												
	desc = "Стандартный магазин от автомата Фёдорова", 												
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/ak_mags_ploskie/icon_mag_standard"
	},
	atype = "mag",														
	bodygroup = { a = 1, b = 0 },
	clipsize = 25
}

CreateAttachmentItem(stats)

stats = {
	attname = "fedorov_mag2", 													
	item = "item_fedorov_mag1", 												
	name = "Увеличенный магазин для автомата Фёдорова", 												
	desc = "Увеличенный магазин для автомата Фёдорова", 	 														
	weight = 1, 														
	model = "models/props_lab/box01a.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/ak_mags_ploskie/icon_mag_45"
	},
	atype = "mag",														
	bodygroup = { a = 1, b = 1 },
	clipsize = 30
}

CreateAttachmentItem(stats)
        
print("more atts added")
        
end)
--======================================================================


