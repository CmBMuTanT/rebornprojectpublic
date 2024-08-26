ITEM.name = "Чемодан с инструментами"
ITEM.description = "Необходим для уничтожения конструкций."
ITEM.category = "[REBORN] BUILDING"
ITEM.model = "models/props_c17/suitcase_passenger_physics.mdl"
ITEM.time = 2 
ITEM.width = 1
ITEM.height = 2


ITEM.functions.Destroy = {
	name = "Уничтожить объект",
	tip = "Уничтожить объект на который смотришь",
	icon = "icon16/delete.png",
	OnRun = function(item)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor() 
		local entTrace = trace.Entity
		
		client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0), item.time-0.1, 0.1 )
		client:SetAction("De-Constructing", item.time)
		client:DoStaredAction(entTrace, function() 

			entTrace:Remove()
			client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0), item.time-0.1, 1 )
			
		end, item.time)
		
		return false	
	end,
	OnCanRun = function(item)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor() 
		local entTrace = trace.Entity
		
		return !IsValid(item.entity) and IsValid(client) and entTrace:GetClass() == "prop_physics" and entTrace.isConstruct
	end
}


