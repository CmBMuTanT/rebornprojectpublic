ITEM.name = "Термометр"
ITEM.description = "Обычный термометр, можно использовать за место градусника..."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 0
ITEM.category = "[REBORN] MEDICINE"
ITEM.exRender = false
ITEM.weight = 0.1

ITEM.exRender = true
ITEM.model = "models/phas/eqp_thermometer.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(21.97, -0.21, 198.79),
	ang = Angle(84.02, -180.63, 0),
	fov = 3.39
}


ITEM.functions.Apply = {
	name = "Измерить свою температуру",
	icon = "icon16/pill.png",
	OnRun = function(itemTable)
		local client = itemTable.player
		local character = client:GetCharacter()
        local temp = character:GetData("diseaseInfoTemp") or "Error"
			client:Notify(temp)
			return false
	end
}
ITEM.functions.Give = {
	name = "Измерить чью-то температуру",
	icon = "icon16/pill.png",
	OnRun = function(itemTable)
		local client = itemTable.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client
		local trace = util.TraceLine(data)
		local entity = trace.Entity


		-- Check if the entity is a valid door.
		if (IsValid(entity) and entity:IsPlayer()) then
            local temp = entity:GetCharacter():GetData("diseaseInfoTemp") or "Error"
            client:Notify(temp)
            return false
		else
			client:Notify("Ты должен смотреть на игрока")
			return false
		end
	end
}