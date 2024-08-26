AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/magma/exodus_spider2.mdl"  -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 600
ENT.HullType = HULL_HUMAN
ENT.SightDistance = 10000

ENT.VJ_NPC_Class = {"CLASS_SPIDERS"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION

ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDistance = 50
ENT.MeleeAttackDamageDistance = 70 -- How far does the damage go?
ENT.MeleeAttackDamage = 40
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.TurningSpeed = 30

ENT.SoundTbl_Idle = {
"arachnid/arahnid_aggressive3.wav",
"arachnid/arahnid_idle_background_random2.wav",
"arachnid/arahnid_idle_background_random3.wav",
"arachnid/arahnid_idle_background_random4.wav",
"arachnid/arahnid_idle_background_random6.wav",
"arachnid/arahnid_idle_background_random7.wav"

}

ENT.SoundTbl_Death = {
"arachnid/arachnid_death_1.wav",
"arachnid/arachnid_death_2.wav",
"arachnid/arachnid_death_3.wav"

}

ENT.SoundTbl_MeleeAttack = {
"arachnid/arahnid_attack1.wav",
"arachnid/arahnid_attack2.wav",
"arachnid/arahnid_attack4.wav",
"arachnid/arahnid_attack6.wav",
"arachnid/arahnid_attack8.wav"
}

ENT.SoundTbl_FootStep = {
"arachnid/footsteps/arachnid_step_1.wav",
"arachnid/footsteps/arachnid_step_2.wav",
"arachnid/footsteps/arachnid_step_3.wav",
"arachnid/footsteps/arachnid_step_4.wav",
"arachnid/footsteps/arachnid_step_5.wav",
"arachnid/footsteps/arachnid_step_6.wav",
"arachnid/footsteps/arachnid_step_7.wav",
"arachnid/footsteps/arachnid_step_8.wav"

}

ENT.SoundTbl_Pain = {
"arachnid/arahnid_pain1.wav",
"arachnid/arahnid_pain2.wav",
"arachnid/arahnid_pain3.wav",
"arachnid/arahnid_pain4.wav",
"arachnid/arahnid_pain5.wav"

}

ENT.SoundTbl_Alert = {
"arachnid/arahnid_alert1.wav"
}

ENT.SoundTbl_BeforeMeleeAttack = {
"arachnid/arahnid_attack1.wav",
"arachnid/arahnid_attack2.wav",
"arachnid/arahnid_attack4.wav",
"arachnid/arahnid_attack6.wav",
"arachnid/arahnid_attack8.wav"
}


function ENT:CustomOnInitialize()

		self:SetSkin(math.random(0,3))

		
	end
	
-- All functions and variables are located inside the base files. It can be found in the GitHub Repository: https://github.com/DrVrej/VJ-Base

/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/