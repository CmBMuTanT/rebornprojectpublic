ITEM.name = "Стяжка"
ITEM.description = "Обычная стяжка которой можно кого либо завязать"
ITEM.exRender = true
ITEM.model = "models/kek1ch/rope.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-89.8, -87.72, 723.26),
	ang = Angle(99.85, 224.32, 0),
	fov = 0.78
}
ITEM.weight = 0.4
ITEM.inventoryType = "hotkey"

ITEM.functions.use = {
	name = "Связать",
	icon = "icon16/link.png",
	OnRun = function(itemTable)
		local client = itemTable.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client
		local target = util.TraceLine(data).Entity

		if (IsValid(target) and target:IsPlayer() and target:GetCharacter()
		and !target:GetNetVar("tying") and !target:IsRestricted()) then
			itemTable.bBeingUsed = true

			client:SetAction("Связываю...", 5)

			client:DoStaredAction(target, function()
				target:SetRestricted(true)
				target:SetNetVar("tying")
				target:NotifyLocalized("fTiedUp")

				--
				target:SetNetVar("ziptie:closeeyes", false)
				target:SetNetVar("ziptie:mute", false)
				
				-- local leftForearm = target:LookupBone("bip01_l_forearm")
				-- local rightUpperArm = target:LookupBone("bip01_r_forearm")
				-- if leftForearm and rightUpperArm then 
				-- 	target:ManipulateBoneAngles(leftForearm, Angle(75, 0, -60))
				-- 	target:ManipulateBoneAngles(rightUpperArm, Angle(-75, 50, 60))
				-- end

				target:ForceSequence("soldier_ohrana_1", nil, 0)
				--

				itemTable:Remove()
			end, 5, function()
				client:SetAction()

				target:SetAction()
				target:SetNetVar("tying")

				itemTable.bBeingUsed = false
			end)

			target:SetNetVar("tying", true)
			target:SetAction("Вас связывают...", 5)
		else
			itemTable.player:NotifyLocalized("plyNotValid")
		end

		return false
	end,
	OnCanRun = function(itemTable)
		local client = itemTable.player
		return (!IsValid(itemTable.entity) or itemTable.bBeingUsed) and (client:GetEyeTrace().Entity:IsPlayer()) --дистанцию я делать не буду мне лень, если надо сам и сделай
	end
}

function ITEM:CanTransfer(inventory, newInventory)
	return !self.bBeingUsed
end