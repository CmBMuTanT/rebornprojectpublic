ITEM.name = "Throwable Object"
ITEM.model = "models/Items/grenadeAmmo.mdl"
ITEM.description = "Throwable Object Example"
ITEM.width = 1
ITEM.height = 1
ITEM.throwent = "ix_flare"
ITEM.throwforce = 2500

-- You can use hunger table? i guess? 
ITEM.functions = ITEM.functions or {}
ITEM.functions.throw = {
	name = "Зажечь",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player
		local grd = ents.Create( item.throwent )
		grd:SetPos( client:EyePos() + client:GetAimVector() * 50 )
		grd:Spawn()

		local phys = grd:GetPhysicsObject()
		phys:SetVelocity( client:GetAimVector() * item.throwforce * math.Rand( .8, 1 ) )
		phys:AddAngleVelocity( client:GetAimVector() * item.throwforce  )
		
		return true
	end,
}