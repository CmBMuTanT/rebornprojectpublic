ITEM.name = "Шприц с 'ПЛУТОНИН'ом'"
ITEM.description = "Шприц с жидкостью 'ПЛУТОНИН', скорее всего в нем содержится радиация. На шприце все та же известная компания ООО 'Мутьев-Фармстандарт'"
ITEM.category = "[REBORN] MEDICINE"
ITEM.exRender = true 
ITEM.model = "models/cmbmtk/eft/medsyringe.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-0.9, 156, 717.3),
	ang = Angle(77.73, 270.33, 0),
	fov = 0.45
}
ITEM.bDropOnDeath = true
ITEM.inventoryType = "hotkey"

ITEM.functions.use= {
	name = "Вколоть (себе)",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player
		local character = client:GetCharacter()

   		character:SetData("RadAmount", math.max(0, character:GetData("RadAmount", 0) + 150))
		client:EmitSound("items/medshot4.wav")
		client:SetNetVar("RadAmount", character:GetData("RadAmount", 0))

		client:Notify("Мне кажется зря я это сделал...")
		return true
	end,
    OnCanRun = function(item)
		return !IsValid(item.entity)
	end
}

ITEM.functions.injectsomeone = {
	name = "Вколоть (игроку)",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player
		local target = client:GetEyeTrace().Entity
		local targetchar = target:GetCharacter()

		targetchar:SetData("RadAmount", math.max(0, targetchar:GetData("RadAmount", 0) + 150))
		target:EmitSound("items/medshot4.wav")
		target:SetNetVar("RadAmount", targetchar:GetData("RadAmount", 0))

		return true
	end,
    OnCanRun = function(item)
		local client = item.player
        local tr = client:GetEyeTrace()
        local target = tr.Entity
        local distance = tr.StartPos:Distance(tr.HitPos)

		return (!IsValid(item.entity)) and item:GetData("Equip", true) and (distance <= 50 and target:IsPlayer())
	end
}



