ITEM.name = "Шприц с пробиркой"
ITEM.description = "Пустой шприц с вакуумной пробиркой."
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


ITEM.functions.inject= {
	name = "Взять анализ (себе)",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player
		local character = client:GetCharacter()

		if !character:GetInventory():Add("bloodsample", 1, {bloodrad = character:GetData("RadAmount", 0)}) then
			client:Notify("Недостаточно места для этого действия.")
			return false
		end

		client:SetHealth(math.min(1, client:Health() - 1))
		client:EmitSound("items/medshot4.wav")
		return true
	end,
    OnCanRun = function(item)
		return !IsValid(item.entity)
	end
}

ITEM.functions.injectsomeone = {
	name = "Взять анализ (игроку)",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player
		local character = client:GetCharacter()
		local target = client:GetEyeTrace().Entity
		local targetchar = target:GetCharacter()

		if !character:GetInventory():Add("bloodsample", 1, {bloodrad = targetchar:GetData("RadAmount", 0)}) then
			client:Notify("Недостаточно места для этого действия.")
			return false
		end
		target:EmitSound("items/medshot4.wav")

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



