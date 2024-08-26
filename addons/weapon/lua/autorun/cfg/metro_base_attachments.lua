
all_attachments = {}

function CreateAttachmentItem(tbl)

	--CreateItem(tbl.item, tbl.name, tbl.desc, tbl.weight, false, 1, false, tbl.model, nil, true)
	if tbl.item != "none" then
		--print("adding an attachment item"..tbl.item)
		local ITEM = ix.item.Register(tbl.item, nil, false, nil, true)
		ITEM.name = tbl.name
		ITEM.model = tbl.model
		ITEM.description = tbl.desc
		ITEM:Hook("drop", function(item)
			local inventory = ix.item.inventories[item.invID]

			if (!inventory) then
				return
			end

			local owner

			for client, character in ix.util.GetCharacters() do
				if (character:GetID() == inventory.owner) then
					owner = client
					break
				end
			end

			if (!IsValid(owner)) then
				return
			end
			
			if inventory:GetItemCount(item) <= 0 then
				local weps = owner:GetWeapons()
				local att = tbl.attname
				local cat = tbl.atype
				for k, v in pairs(weps) do
					if v.Base == "metro_base" or v:GetClass() == "metro_base" then
						v:SvClearAttachment(cat)
					end
				end
			end
			
		end)
	end
	
	all_attachments[tbl.attname] = {}
	
	if CLIENT then
		all_attachments[tbl.attname].cl_data = tbl.cl_data
	end
	
	for k, v in pairs(tbl) do
		if v != tbl.attname and (tostring(k) != "cl_data") then
			all_attachments[tbl.attname][k] = v
		end
	end
	
end

function MakeAtts()

--[[
	статов много, такой способ вроде удобнее
	можно объявлять только с теми параметрами какие нужны, НО 
	attname, item, name, desc, weight, model, cl_data обязательны (подробнее ниже)
	
	attname - имя аттачмента прописываемое в оружии
	item - предмет в инвентаре. отдельную энтитю можно не создавать если не требуется, поставить на "none" если предмета нет,
		для дефолтных аттачментов на пример
	name - нормальное имя, для инвентаря и менюхи
	desc - описание, тоже самое
	weight - вес в инвентаре
	model - модель. если не видимый нужен для инвентаря. если без предмета, можно не прописывать (visible все равно поставить на false)
	visible - видимый или нет
	sights_zoom - приближение прицела, добавляется к основному
	
	данные чисто для клиента
	cl_data = {
		icon - иконка в меню
	}
	bodygroup = { a = 2, b = 1 } --бодигруппа аттачмента
	
	atype - типы аттачментов:
	вообще можно какие угодно выдумать, кроме 
	"scope" - это прицелы, у них в пушке должна быть прописана позиция для прицеливания
	"mag" - это магазины. они отличаются тем что один обязательно должен быть выбран, потому 
	нужно объявить дефолтный аттачмент. для этого можно сделать аттачмент без предмета в инвентаре.
	"silencer" - глушители, включают альтернативный звук и меняется эффект
	
	dispersion - разброс, добавляется
	conemul - множитель разброса в прицеле
	damage - урон
	recoil - отдача
]]--

local stats = {}

stats = {
	attname = "scope1", 													
	item = "item_scope1", 													
	name = "Коллиматорный прицел(довоенный)", 												
	desc = "Этот прицел довоенного производства значительно облегчает прицеливание, почти не ограничивая поле зрения", 										
	weight = 0.2, 															
	model = "models/attachments/scopes/kollimator/kollimator.mdl", 		
	visible = true, 														
	sights_zoom = 5,													
	cl_data = {															
		icon = "metroui/weapon_attachments/all/scopes/icon_scope_att_collimator"
	},
	atype = "scope",
	conemul = -0.2														
}

CreateAttachmentItem(stats)

stats = {
	attname = "scope3", 													
	item = "item_scope3", 												
	name = "Коллиматорный прицел(Кустарный)", 											
	desc = "Этот прицел кустарного производства значительно облегчает прицеливание, почти не ограничивая поле зрения", 								
	weight = 0.2, 															
	model = "models/attachments/scopes/kollim/kollim.mdl", 		
	visible = true, 														
	sights_zoom = 5,												
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/scopes_ploskie/icon_scope_collimator_1"
	},
	atype = "scope",													
	conemul = -0.3
}

CreateAttachmentItem(stats)

stats = {
	attname = "scope2", 												
	item = "item_scope2", 												
	name = "Оптический прицел (2-кратный)", 												
	desc = "Довоенный оптический прицел облегчает прицеливание, но ограничивает поле зрения, что снижает его ценность в тесных тоннелях", 								
	weight = 0.2, 														
	model = "models/attachments/scopes/default_optika/default_optika.mdl", 	
	visible = true, 								
	sights_zoom = 20,													
	cl_data = {															
		icon = "metroui/weapon_attachments/all/scopes/icon_scope_att_optic"
	},
	atype = "scope",
	conemul = -0.6														
}

CreateAttachmentItem(stats)

stats = {
	attname = "tihar_scope", 												
	item = "item_tihar_scope", 												
	name = "Коллиматорный прицел(Тихарь)", 												
	desc = "Кустарный коллиматорный прицел, сделанный исключительно для тихаря", 									
	weight = 0.2, 														
	model = "models/attachments/scopes/tihar_scope/tihar_scope.mdl", 	
	visible = true, 								
	sights_zoom = 20,													
	cl_data = {															
		icon = "metroui/weapon_attachments/all/scopes/icon_scope_att_optic"
	},
	atype = "scope",
	conemul = -0.6														
}

CreateAttachmentItem(stats)

local laser_trdata = {}

local laser_beam = Material("cw2/reticles/aim_reticule")
local laser_dot = Material("cw2/reticles/aim_reticule")

stats = {
	attname = "laser_sight", 												
	item = "item_laser_sight", 												
	name = "Лазерный прицел", 												
	desc = "Лазерный прицел значительно упрощает вам задачу стрельбы от бедра", 							
	weight = 0.2, 														
	model = "models/attachments/other/default_laser/default_laser.mdl", 	
	visible = true, 																				
	cl_data = {															
		icon = "metroui/weapon_attachments/all/icon_laser",
		drawfunc = function(wep, pos, ang, cmodel)
		
			--local vm = wep.Owner:GetViewModel()
			
			local forward = ang:Forward()
			
			laser_trdata.start = pos
			laser_trdata.endpos = laser_trdata.start + forward * 2000
			laser_trdata.filter = wep.Owner
			
			local tr = util.TraceLine(laser_trdata)
			
			render.SetMaterial(laser_dot)
			
			render.DrawBeam(pos, tr.HitPos, 0.2, 0, 0.99, Color( 0, 255, 0, 100 ))
			
			render.DrawSprite(tr.HitPos, 2, 2, Color( 0, 255, 0, 255 ))
			
		end
	},
	atype = "laser",
	deploy_speed = -0.05,
	conemul = -0.05													
}

CreateAttachmentItem(stats)

local nxt_ranbow = 0
local nxt_color = Color(0, 255, 0)
local cur_color = Color(0, 255, 0)

stats = {
	attname = "laser_sight_rainbow", 												
	item = "item_laser_sight_rainbow", 												
	name = "Лазерный прицел(Не юзать)", 												
	desc = "будэш самый модный донатер на сервере!", 							
	weight = 0.2, 														
	model = "models/attachments/other/default_laser/default_laser.mdl", 	
	visible = true, 																				
	cl_data = {															
		icon = "metroui/weapon_attachments/all/icon_laser",
		drawfunc = function(wep, pos, ang, cmodel)
		
			--local vm = wep.Owner:GetViewModel()
			
			local forward = ang:Forward()
			
			if nxt_ranbow < CurTime() then
				nxt_ranbow = CurTime() + 0.5
				nxt_color = Color(math.random(0, 255), math.random(0, 255), math.random(0, 255))
			end
			
			cur_color.r = Lerp(FrameTime()*5, cur_color.r, nxt_color.r)
			cur_color.g = Lerp(FrameTime()*5, cur_color.g, nxt_color.g)
			cur_color.b = Lerp(FrameTime()*5, cur_color.b, nxt_color.b)
			
			laser_trdata.start = pos
			laser_trdata.endpos = laser_trdata.start + forward * 2000
			laser_trdata.filter = wep.Owner
			
			local tr = util.TraceLine(laser_trdata)
			
			render.SetMaterial(laser_dot)
			
			render.DrawBeam(pos, tr.HitPos, 0.2, 0, 0.99, Color( cur_color.r, cur_color.g, cur_color.b, 255 ))
			
			render.DrawSprite(tr.HitPos, 2, 2, Color( cur_color.r, cur_color.g, cur_color.b, 255 ))
			
		end
	},
	atype = "laser",
	deploy_speed = -0.05,
	conemul = -0.1													
}

CreateAttachmentItem(stats)

stats = {
	attname = "fonarik_att", 												
	item = "item_fonarik_att", 												
	name = "Тактический Фонарик(Не юзать)", 												
	desc = "Фонарик", 									
	weight = 0.2, 														
	model = "models/attachments/other/default_laser/default_laser.mdl", 	
	visible = true, 																				
	cl_data = {															
		icon = "metroui/weapon_attachments/all/icon_laser",
		drawfunc = function(wep, pos, ang, cmodel)
		
				if wep.projected_texture == nil then
				
					wep.projected_texture = ProjectedTexture()
					wep.projected_texture:SetTexture( "effects/flashlight001" )
					wep.projected_texture:SetFarZ( 800 )
					wep.projected_texture:SetFOV(30)
					wep.projected_texture:SetEnableShadows(false)
					wep.projected_texture:SetPos( pos )
					wep.projected_texture:SetAngles( ang )
					wep.projected_texture:Update()
					
				else
				
					wep.projected_texture:SetPos( pos )
					wep.projected_texture:SetAngles( ang )
					wep.projected_texture:Update()	
					
				end	
			
		end
	},
	atype = "laser",
	deploy_speed = -0.05,
	conemul = -0.05													
}

CreateAttachmentItem(stats)

local ScopeMat = Material( "pp/rt" )
--local scopeglass = Material("cw2/attachments/lens/rt")

local lal = Angle(0,0,0)

stats = {
	attname = "scope_optics", 												
	item = "item_scope_optics", 												
	name = "Оптический прицел (6-кратный)", 												
	desc = "Довоенный оптический прицел дальнего действия облегчает прицеливание, но ограничивает поле зрения, что снижает его ценность в тесных тоннелях", 								
	weight = 0.2, 														
	model = "models/attachments/scopes/ventil_scope/ventil_scope.mdl", 	--"models/cw2/attachments/l96_scope.mdl",--
	visible = true, 								
	sights_zoom = 20,	
	enable_rendertarget = true,		
	aim_sense = 0.1,	
	aim_fov_mod = 20,									
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/scopes_ploskie/icon_scope_4x",
		drawfunc = function(wep, pos, ang, cmodel)
			--scopeglass:SetTexture("$basetexture", wep.RTTexture)
			lal.p = ang.p
			lal.y = ang.y
			lal.r = ang.r
			lal:RotateAroundAxis(lal:Right(), 90)
			local scale = cmodel:GetModelScale()
			cam.Start3D2D( pos+lal:Forward()*(0.85*scale)+lal:Right()*-(0.01*scale), lal, (0.014)*scale )
				surface.SetDrawColor( 255, 255, 255, 255 )
				--ScopeMat:SetVector("$color", Vector(0.2, 1, 0.2) )
				--print(wep.RTTexture)
				--surface.SetTexture(surface.GetTextureID("rt_metro_scope"))
				surface.SetMaterial( wep.RTMat )
				surface.DrawTexturedRectRotated( 0, 0, 64, 64, -90 )
			cam.End3D2D()
		end
	},
	atype = "scope",
	deploy_speed = -0.1,
	conemul = -0.099999														
}

CreateAttachmentItem(stats)

stats = {
	attname = "nv_scope", 												
	item = "item_nv_scope", 												
	name = "Ночной Прицел", 												
	desc = "Прицел с ночным виденьем", 									
	weight = 0.2, 														
	model = "models/attachments/scopes/envg_scope/envg_scope.mdl", 	
	visible = true, 								
	sights_zoom = 20,		
	enable_rendertarget = true,										
	cl_data = {															
		icon = "metroui/weapon_attachments/all/scopes/icon_scope_att_nightvision",
		drawfunc = function(wep, pos, ang)
		
			lal.p = ang.p
			lal.y = ang.y
			lal.r = ang.r
			lal:RotateAroundAxis(lal:Right(), 90)
			
			cam.Start3D2D( pos+lal:Up()*2, lal, 0.016 )
			
				wep.RTMat:SetVector("$color", Vector(0.1, 0.42, 0.1) )
				surface.SetDrawColor( 255, 255, 255, 50 )
				surface.SetTexture(surface.GetTextureID("rt_metro_scope"))
				surface.SetMaterial( wep.RTMat )
				--surface.DrawTexturedRectRotated( 0, 0, 64, 64, -90 )
				surface.DrawTexturedRectRotated( 0, 0, 64, 64, -90 )
			
			cam.End3D2D()
			
		end,
		rtfunc = function(viewdata, wep)	--this function is called from where you can draw anything into the scope rendertarget. the viewdata doesnt get defaulted, so the cahnges to it will affect every scope. reset it yourself
			viewdata.fov = 10+wep.add_fov
			render.SetLightingMode( 1 )
			render.RenderView(viewdata)
			render.SetLightingMode( 0 )
		end
	},
	atype = "scope",
	conemul = -0.6														
}

CreateAttachmentItem(stats)
--/////SAIGA MAGS//////////////////////
stats = {
	attname = "saiga_mag1", 													
	item = "none", 														
	name = "Стандартный магазин(Сайга)", 												
	desc = "Стандартный магазин от карабина Сайга", 														
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/uboinik/uboinik_mags/icon_shotgun_mag_2"--metroui/weapon_attachments/weapons/ubludok/ubludok_mags/icon_ubludok_mag_70
	},
	atype = "mag",														
	bodygroup = { a = 3, b = 0 },
	clipsize = 10
}

CreateAttachmentItem(stats)

stats = {
	attname = "saiga_mag2", 													
	item = "item_saiga_mag2", 														
	name = "Барабанный магазин(Сайга)", 												
	desc = "Барабнный магазин от карабина Сайга, который увеличиывает обоиму вдвое, но снижает удобность оружия", 		
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 												
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/ubludok/ubludok_mags/icon_ubludok_mag_70"
	},
	atype = "mag",														
	bodygroup = { a = 3, b = 1 },
	clipsize = 20
}

CreateAttachmentItem(stats)
--/////KALASH MAGS/////////////////////
stats = {
	attname = "mag1", 													
	item = "none", 														
	name = "Стандартный магазин(АК)", 												
	desc = "Стандартный магазин от автомата АК", 												
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/ak_mags_ploskie/icon_mag_standard"
	},
	atype = "mag",														
	bodygroup = { a = 3, b = 1 },
	clipsize = 30
}

CreateAttachmentItem(stats)

stats = {
	attname = "mag2", 													
	item = "item_mag2", 												
	name = "Увеличенный магазин(РПК)", 												
	desc = "Увеличенный магазин взятый от пулемета РПК, в отличие от стандартного магазина обладает дополнительным боезопасом в 45 патрон", 	 														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/ak_mags_ploskie/icon_mag_45"
	},
	atype = "mag",														
	bodygroup = { a = 3, b = 0 },
	clipsize = 45
}

CreateAttachmentItem(stats)

stats = {
	attname = "mag3", 													
	item = "item_mag3", 												
	name = "Барабанный магазин(АК)", 												
	desc = "Увеличенный магазин, который увеличиывает обоиму вдвое, но снижает удобность оружия", 																
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 	
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/ak_mags_ploskie/icon_mag_rounded_2"
	},
	atype = "mag",														
	bodygroup = { a = 3, b = 2 },
	clipsize = 60,
	reloading_speed = -0.5,
	deploy_speed = -0.1,
	anims = "drum"
}

CreateAttachmentItem(stats)

stats = {
	attname = "mag_abzats", 													
	item = "item_mag_abzats", 												
	name = "Стандартный магазин(АБЗАЦ)", 												
	desc = "Стандартный магазин от абзаца", 													
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 	
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/uboinik/uboinik_mags/icon_shotgun_mag_3"
	},
	atype = "mag",														
	bodygroup = { a = 3, b = 0 },
	clipsize = 20
}

CreateAttachmentItem(stats)

stats = {
	attname = "mag_abzats_ex", 													
	item = "item_mag_abzats_ex", 												
	name = "Увеличенный магазин(АБЗАЦ)", 												
	desc = "Увеличенный короб магазина от абзаца, значительно затрудняющий перезарядку оружия",  														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 	
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/uboinik/uboinik_mags/icon_shotgun_mag_3"
	},
	atype = "mag",														
	bodygroup = { a = 3, b = 1 },
	clipsize = 40,
	reloading_speed = -0.2,
	deploy_speed = -0.1
}

CreateAttachmentItem(stats)

stats = {
	attname = "mag_ventil_default", 													
	item = "item_mag_ventil_default", 												
	name = "Стандартный магазин(Вентиль)", 												
	desc = "Стандартный магазин от вентиля, снизу написаны инициалы Зайцев В.Г.", 		 														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 	
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/ventil/ventil_mags/icon_mag_att_10_bullets"
	},
	atype = "mag",														
	bodygroup = { a = 3, b = 0 },
	clipsize = 5
}

CreateAttachmentItem(stats)

stats = {
	attname = "mag_ventil_ex", 													
	item = "item_mag_ventil_ex", 												
	name = "Увеличенный магазин(Вентиль)", 												
	desc = "Увеличенный магазин от вентиля, осанщающий вас дополнительным боезопасом в 10 патрон", 	 														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 	
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/ventil/ventil_mags/icon_mag_att_20_bullets"
	},
	atype = "mag",														
	bodygroup = { a = 3, b = 1 },
	clipsize = 10,
	reloading_speed = -0.2,
	deploy_speed = -0.1,
	anims = "drum"
}

CreateAttachmentItem(stats)

stats = {
	attname = "boomstick", 													
	item = "item_boomstick", 												
	name = "Четыре дула для Дуплета", 												
	desc = "Два ствола хорошо, но 4 лучше",  														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 	
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/dula_ploskie/icon_dulo_2"
	},
	atype = "barrel",														
	bodygroup = { a = 2, b = 2 },
	clipsize = 4,
	take_ammo = 1,
	recoil = 5,
	anims = "quad"
}

CreateAttachmentItem(stats)

stats = {
	attname = "longbarrel", 													
	item = "item_longbarrel", 												
	name = "Длинные стволы(Дуплет)", 												
	desc = "Размер не имеет значение, но когда пушка длинне, но и точность повыше будет", 														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 	
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/dula_ploskie/icon_dulo_4"
	},
	atype = "barrel",														
	bodygroup = { a = 2, b = 1 },
	dispersion = -0.3,
	recoil = -2
}

CreateAttachmentItem(stats)

stats = {
	attname = "shortbarrel", 													
	item = "item_shortbarrel", 												
	name = "Обрез(Дуплет)", 												
	desc = "Стреляй как Бодров С.С.", 															
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 	
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/dula_ploskie/icon_dulo_5"
	},
	atype = "barrel",														
	bodygroup = { a = 2, b = 3 },
	dispersion = 0.2,
	recoil = 2
}

CreateAttachmentItem(stats)

stats = {
	attname = "stock", 													
	item = "item_dupletstock", 												
	name = "Улучшенный приклад(Дуплет)", 												
	desc = "Улучшенный приклад для дуплета",														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 	
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/prikladi_ploskie/icon_priklad_7"
	},
	atype = "butts",														
	bodygroup = { a = 3, b = 1 },
	dispersion = -0.1,
	recoil = -3
}

CreateAttachmentItem(stats)

--специальный аттачмент который нельзя поставить в ручную
stats = {
	attname = "planka1", 													
	item = "none", 														
	name = "planka", 												
	desc = "planka", 														
	visible = true, 
	model = "models/attachments/other/planka_1/planka_1.mdl",												
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/ak_mags_ploskie/icon_mag_standard"
	},
	atype = "planka"								
}

CreateAttachmentItem(stats)

--специальный аттачмент который нельзя поставить в ручную
stats = {
	attname = "planka2", 													
	item = "none", 														
	name = "planka2", 												
	desc = "planka2", 														
	visible = true, 
	model = "models/attachments/other/planka_2/planka_2.mdl",												
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/ak_mags_ploskie/icon_mag_standard"
	},
	atype = "planka"								
}

CreateAttachmentItem(stats)

--специальный аттачмент который нельзя поставить в ручную
stats = {
	attname = "planka3", 													
	item = "none", 														
	name = "planka3", 												
	desc = "planka3", 														
	visible = true, 
	model = "models/attachments/other/planka_3/planka_3.mdl",												
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/ak_mags_ploskie/icon_mag_standard"
	},
	atype = "planka"								
}

CreateAttachmentItem(stats)
--специальный аттачмент который нельзя поставить в ручную
stats = {
	attname = "planka_vsv", 													
	item = "none", 														
	name = "plankavsv", 												
	desc = "plankavsv", 														
	visible = true, 
	model = "models/attachments/other/planka_vsv/planka_vsv.mdl",												
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/ak_mags_ploskie/icon_mag_standard"
	},
	atype = "planka"								
}

CreateAttachmentItem(stats)

stats = {
	attname = "abzats_compensator", 												
	item = "item_abzats_compensator", 												
	name = "Компенсатор(Абзац)", 												
	desc = "Обычный компенсатор, отводящий вспышку и пороховые газы", 									
	weight = 0.2, 														
	model = "models/attachments/other/abzats_compensator/abzats_compensator.mdl", 	
	visible = true, 																				
	cl_data = {															
		icon = "metroui/weapon_attachments/all/dula/icon_dulo_att_4"
	},
	atype = "silencer"											
}

CreateAttachmentItem(stats)

stats = {
	attname = "default_silencer", 												
	item = "item_default_silencer", 												
	name = "Глушитель", 												
	desc = "Без лишних слов", 									
	weight = 0.2, 														
	model = "models/attachments/suppressors/default_suppressor/default_suppressor.mdl", 	
	visible = true, 																				
	cl_data = {															
		icon = "metroui/weapon_attachments/all/superssors/icon_supressor_1"
	},
	atype = "silencer"											
}

CreateAttachmentItem(stats)

stats = {
	attname = "revolver_silencer", 												
	item = "item_revolver_silencer", 												
	name = "Пистолетный глушитель", 												
	desc = "Без лишних слов", 										
	weight = 0.2, 														
	model = "models/attachments/suppressors/revolver_supressor/revolver_supressor.mdl", 	
	visible = true, 																				
	cl_data = {															
		icon = "metroui/weapon_attachments/all/superssors/icon_supressor_1"
	},
	atype = "silencer"											
}

CreateAttachmentItem(stats)

stats = {
	attname = "padonok_silencer", 												
	item = "item_padonok_silencer", 												
	name = "Глушить для падонка", 												
	desc = "Специальный Гулшитель для подонка", 								
	weight = 0.2, 														
	model = "models/attachments/suppressors/revolver_supressor/revolver_supressor.mdl", 	
	visible = true, 																				
	cl_data = {															
		icon = "metroui/weapon_attachments/all/superssors/icon_supressor_1"
	},
	atype = "silencer"
    --required_att = "padonak_barrel"	
}

CreateAttachmentItem(stats)

stats = {
	attname = "vsv_silencer", 												
	item = "item_vsv_silencer", 												
	name = "Глушитель ВСВ", 											
	desc = "Без лишних слов",									
	weight = 0.2, 														
	model = "models/attachments/suppressors/vsv_suppressor/vsv_supressor_3.mdl", 	
	visible = true, 																				
	cl_data = {															
		icon = "metroui/weapon_attachments/all/superssors/icon_supressor_1"
	},
	atype = "silencer"											
}

CreateAttachmentItem(stats)

stats = {
	attname = "gatling_upgrade", 												
	item = "item_gatling_upgrade", 												
	name = "Автоматическая система(Гатлинг)", 											
	desc = "Система позволяющая вести стрельбу без накрутки оборотов", 									
	weight = 0.5, 														
	model = "models/weapons/w_eq_eholster.mdl", 	
	visible = false, 																				
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/tihar/tihar_davlenie/icon_tihar_att_3"
	},
	atype = "body",
	bodygroup = { a = 2, b = 1 },
	set_chargeable = false					
}

CreateAttachmentItem(stats)

stats = {
	attname = "gatling_stvol", 												
	item = "item_gatling_stvol", 												
	name = "Допполнительные дула(Гатлинг)", 											
	desc = "Фарш! Фарш! Фарш!",  									
	weight = 0.5, 														
	model = "models/weapons/w_eq_eholster.mdl", 	
	visible = false, 																				
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/uboinik/uboinik_mags/icon_shotgun_mag_1"
	},
	atype = "barrel",
	bodygroup = { a = 4, b = 1 },
	firing_speed = -0.05			
}

CreateAttachmentItem(stats)

stats = {
	attname = "padonak_mag1", 													
	item = "item_padonak_mag1", 												
	name = "Стандартный магазин(Падонок)", 												
	desc = "Стандартный магазин от падонка", 															
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/ak/ak_mags/icon_mag_att_small"
	},
	atype = "mag",														
	bodygroup = { a = 6, b = 0 },
	clipsize = 5,
	max_bullet_group = 6
}

CreateAttachmentItem(stats)

stats = {
	attname = "padonak_mag2", 													
	item = "item_padonak_mag2", 												
	name = "Увеличенный магазин(Падонок)", 												
	desc = "Увеличенный магазин, осанщающий вас дополнительным боезопасом  в 10 патрон", 														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/ak/ak_mags/icon_mag_att_standard"
	},
	atype = "mag",														
	bodygroup = { a = 6, b = 1 },
	clipsize = 10,
	max_bullet_group = 11
}

CreateAttachmentItem(stats)

stats = {
	attname = "mag_preved", 													
	item = "item_mag_preved", 												
	name = "Магазин(Превед)", 												
	desc = "Магазин для более быстрой и удобной стрельбы с преведа", 															
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/ak/ak_mags/icon_mag_att_small"
	},
	atype = "mag",														
	bodygroup = { a = 5, b = 1 },
	clipsize = 5,
	firing_speed = 0.9,
	auto_reload = false,
	enable_mag_groups = true,
	reload_ammo_delay = -0.7,
	anims = "drum"
}

CreateAttachmentItem(stats)

stats = {
	attname = "mag_preved_default", 													
	item = "item_mag_preved_default", 												
	name = "Патрон(Превед)", 												
	desc = "Старая добрая болтовочная перезарядка", 															
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/ventil/ventil_mags/icon_mag_att_bullet"
	},
	atype = "mag",														
	bodygroup = { a = 5, b = 0 },
	clipsize = 1
}

CreateAttachmentItem(stats)

stats = {
	attname = "ashot_handguard", 													
	item = "item_ashot_handguard", 												
	name = "Ручка(Ашот)", 												
	desc = "Деревянная ручка для ашота", 														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/ruchki_ploskie/icon_ruchka_3"
	},
	atype = "handguard",														
	bodygroup = { a = 4, b = 1 },
	anims = "handguard"
}

CreateAttachmentItem(stats)

stats = {
	attname = "padonak_handguard", 													
	item = "item_padonak_handguard", 												
	name = "Ручка(Падонок)", 												
	desc = "Деревянная ручка для подонка", 														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/ruchki_ploskie/icon_ruchka_3"
	},
	atype = "handguard",														
	bodygroup = { a = 4, b = 1 },
	anims = "handguard"
}

CreateAttachmentItem(stats)

stats = {
	attname = "ashot_priklad", 													
	item = "item_ashot_priklad", 												
	name = "Приклад(Ашот)", 												
	desc = "Улучшенный прклад для ашота", 	
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/prikladi_ploskie/icon_priklad_1"
	},
	atype = "priklad",														
	bodygroup = { a = 3, b = 1 },
	anims = "priklad",
    required_att = "ashot_handguard"
}

CreateAttachmentItem(stats)

stats = {
	attname = "padonak_priklad", 													
	item = "item_padonak_priklad", 												
	name = "Приклад(Падонок)", 												
	desc = "Улучшенный прклад для подонка",  														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/prikladi_ploskie/icon_priklad_1"
	},
	atype = "priklad",														
	bodygroup = { a = 5, b = 1 },
	anims = "priklad",
	required_att = "padonak_handguard"
}

CreateAttachmentItem(stats)

stats = {
	attname = "abzats_autofire", 													
	item = "item_abzats_autofire", 												
	name = "Затворная рама(Абзац)", 										
	desc = "Механизм позволящий вести абзацу автоматическую стрельбу", 														
	weight = 0.2, 														
	model = "models/attachments/other/abzats_autofire/abzats_autofire.mdl", 
	visible = true, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/all/icon_mothing"
	},
	atype = "automod",														
	bodygroup = { a = 2, b = 1 },
	set_automatic = true
}

CreateAttachmentItem(stats)

stats = {
	attname = "padonak_autofire", 													
	item = "item_padonak_autofire", 												
	name = "Отводчик газов(Падонок)", 										
	desc = "Механизм позволящий вести падонку автоматическую стрельбу", 														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/tihar/tihar_mags/icon_tihar_att_7"
	},
	atype = "automod",														
	bodygroup = { a = 2, b = 1 },
	set_automatic = true
}

CreateAttachmentItem(stats)

stats = {
	attname = "padonak_barrel", 													
	item = "item_padonak_barrel", 												
	name = "Ствол(Падонок)", 												
	desc = "Удлиненный ствол для подонка", 														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/all/dula/icon_dulo_att_6"
	},
	atype = "barrel",														
	bodygroup = { a = 3, b = 1 },
	conemul = -0.1,
	barrel_length = 4.5
}

CreateAttachmentItem(stats)

stats = {
	attname = "revolver_barrel", 													
	item = "item_revolver_barrel", 												
	name = "Ствол(Револьер)", 												
	desc = "Удлиненный ствол для револьвера", 														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/ruchki_ploskie/icon_ruchka_3"
	},
	atype = "handguard",														
	bodygroup = { a = 1, b = 2 },	--{ a = 7, b = 1 },
	anims = "grip",
	conemul = -0.1
}

CreateAttachmentItem(stats)

stats = {
	attname = "revolver_grip", 													
	item = "item_revolver_grip", 												
	name = "Ручка(Револьер)", 												
	desc = "Деревянная ручка для револьвера", 														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments_ploskie/ruchki_ploskie/icon_ruchka_3"
	},
	atype = "priklad",														
	bodygroup = { a = 7, b = 1 },	--{ a = 7, b = 1 },
	conemul = -0.1,
	required_att = "revolver_barrel"
}

CreateAttachmentItem(stats)

stats = {
	attname = "hellsing_pneumo", 													
	item = "item_hellsing_pneumo", 												
	name = "Новая пневмо система для хельсинга", 												
	desc = "Баллон дольше держит воздух при стрельбе", 	 														
	weight = 0.2, 														
	model = "models/weapons/w_eq_eholster.mdl", 
	visible = false, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/tihar/tihar_davlenie/icon_tihar_att_3"
	},
	atype = "priklad",														
	bodygroup = { a = 5, b = 1 },	--{ a = 7, b = 1 },
	charge_take = -1.5
}

CreateAttachmentItem(stats)

stats = {
	attname = "bastard_ohladitel", 													
	item = "item_bastard_ohladitel", 												
	name = "Радиатор(Ублюдок)", 												
	desc = "Радиатор для ублюдка отводящий пороховые газы от выстрелов", 													
	weight = 0.2, 														
	model = "models/attachments/other/ubludok_radiator/ubludok_radiator.mdl", 
	visible = true, 													
	cl_data = {															
		icon = "metroui/weapon_attachments/weapons/ubludok/icon_gazootvodnik"
	},
	atype = "barrel",														
	special_bool = true
}

CreateAttachmentItem(stats)

hook.Call("MakeMoreAtts")
    
print("attachments loaded")

end

print("attachments reconfigured")
