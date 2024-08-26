ITEM.name = "Пробирка с кровью"
ITEM.description = "Пробирка с чьей то кровью."
ITEM.category = "[REBORN] MEDICINE"
ITEM.exRender = true 
ITEM.model = "models/cmbmtk/eft/bloodsample.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-3.92, -0.05, 734.06),
	ang = Angle(89.69, 360.4, 0),
	fov = 0.61
}

ITEM.functions.inject= {
	name = "Залить «РАДАЛИЗ»",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player
		local character = client:GetCharacter()
		character:GetInventory():HasItem("analisitem"):Remove()

		ix.chat.Send(client, "me", "Перелил 'РАДАЛИЗ' в пробирку с кровью, потряс ею, и получил значение: "..item:GetData("bloodrad", 0)..".")

		return true
	end,
    OnCanRun = function(item)
		local client = item.player
		local character = client:GetCharacter()

		return !IsValid(item.entity) and character:GetInventory():HasItem("analisitem")
	end
}
