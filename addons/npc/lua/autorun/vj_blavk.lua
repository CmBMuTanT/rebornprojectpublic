/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Black SNPCs"
local AddonName = "Black"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_m2033_vj_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')


game.AddParticles("particles/blackmetro2033.pcf")
game.AddParticles("particles/vortigaunte_fx.pcf")
local particlename = {
	
"shadow3",
"shadow4",
"swadow5",

}
for _,v in ipairs(particlename) do PrecacheParticleSystem(v) end
	  for k, v in pairs( player.GetAll() ) do

		

	if v:IsPlayer() then

					v.friclass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.SquadName = "vj_neutral"
					v.Class = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.Classify = "CLASS_NEUTRAL" and "CLASS_NEUTRALS" 
					v.VJ_NPC_Class = {"CLASS_HERO_NEUTRAL","CLASS_HERO_BANDIT","CLASS_HERO_FREEDOM","CLASS_HERO_DUTY","CLASS_HERO_CS","CLASS_HERO_HUNTER","CLASS_HERO_SKIT","CLASS_HERO_UCHENIY","CLASS_HERO_KILLER","CLASS_HERO_GREH"}
					v.GetClass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.SetClass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
		  	   
	

			end

		end
		end


hook.Add("Think","loyal",function()
	  for k, v in pairs( player.GetAll() ) do
			if v:IsValid() && v:IsPlayer() && v:Alive() then

	    if v then

			if	v.PlayerAIUser == true then return end

	if v:IsPlayer()  then

					v.friclass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.SquadName = "vj_neutral"
					v.Class = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.Classify = "CLASS_NEUTRAL" and "CLASS_NEUTRALS" 
					v.VJ_NPC_Class = {"CLASS_HERO_NEUTRAL","CLASS_HERO_BANDIT","CLASS_HERO_FREEDOM","CLASS_HERO_DUTY","CLASS_HERO_CS","CLASS_HERO_HUNTER","CLASS_HERO_SKIT","CLASS_HERO_UCHENIY","CLASS_HERO_KILLER","CLASS_HERO_GREH"}
					v.GetClass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
					v.SetClass = "CLASS_NEUTRAL" and "CLASS_NEUTRALS"
		  	   
	

			end

		end
		end
		end

end)


