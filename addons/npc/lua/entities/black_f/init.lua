AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/spitball_medium.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 50 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 150 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.DirectDamage = 220
ENT.RadiusDamageForce = 250
ENT.RadiusDamageForce_Up = 10
ENT.RadiusDamageType = DMG_SLASH -- Damage type
//ENT.DecalTbl_DeathDecals = {"BeerSplash"}
ENT.SoundTbl_Startup = {"wolf/ball.wav"}

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:EnableDrag(false)
        phys:EnableGravity(false)
	phys:SetBuoyancyRatio(0)
end
------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
               self:SetNoDraw(true)
	end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)   
end
--------------------------------------------------------------------------------------
function ENT:CustomOnThink()
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/