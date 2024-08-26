AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/magma/exodus_lurker.mdl"}  -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 450
ENT.HullType = HULL_HUMAN
ENT.SightDistance = 10000

ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDistance = 60
ENT.MeleeAttackDamageDistance = 90 -- How far does the damage go?
ENT.MeleeAttackDamage = 50
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.TurningSpeed = 30
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {"leapstrike"} -- Melee Attack Animations
ENT.LeapDistance = 200 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 150 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 0.2 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 3 -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 0.4 -- How much time until it can use any attack again? | Counted in Seconds
ENT.LeapAttackExtraTimers = {0.4,0.6,0.8,1} -- Extra leap attack timers | it will run the damage code after the given amount of seconds
ENT.TimeUntilLeapAttackVelocity = 0.2 -- How much time until it runs the velocity code?
ENT.LeapAttackVelocityForward = 200 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 150 -- How much upward force should it apply?
ENT.LeapAttackDamage = 10
ENT.LeapAttackDamageDistance = 100 -- How far does the damage go?

ENT.SoundTbl_Idle = {
"lurker/lurker_idle_breath1.wav",
"lurker/lurker_aggressive_2.wav",
"lurker/lurker_aggressive_3.wav",
"lurker/lurker_aggressive_4.wav",
"lurker/lurker_idle_breath2.wav",
"lurker/lurker_idle_breath3.wav",
"lurker/lurker_idle_breath4.wav"

}

ENT.SoundTbl_Death = {
"lurker/lurker_silent_death1.wav",
"lurker/lurker_silent_death2.wav",
"lurker/lurker_silent_death3.wav"
}

ENT.SoundTbl_MeleeAttack = {
"lurker/churzik_hit_1.wav",
"lurker/churzik_hit_3.wav",
"lurker/lurker_attack_1.wav",
"lurker/lurker_attack_3.wav",
"lurker/lurker_attack_2.wav"
}

ENT.SoundTbl_FootStep = {
"nosalis/nosalis_foot_run_l01.mp3",
"nosalis/nosalis_foot_run_l02.mp3",
"nosalis/nosalis_foot_run_l03.mp3"
}

ENT.SoundTbl_Pain = {
"nosalis/nosach_t4_hit_2.wav",
"nosalis/nosach_t4_hit_3.wav",
"nosalis/nosach_t4_hit_1.wav"
}



ENT.SoundTbl_BeforeMeleeAttack = {
"lurker/churzik_hit_1.wav",
"lurker/churzik_hit_3.wav",
"lurker/lurker_attack_1.wav",
"lurker/lurker_attack_3.wav",
"lurker/lurker_attack_2.wav",
"nosalis/nosach_t4_attack_2.wav",
"nosalis/nosach_t4_attack_1.wav"
}

function ENT:CustomOnInitialize()

		self:SetSkin(math.random(0,4))

		
	end
	
-- All functions and variables are located inside the base files. It can be found in the GitHub Repository: https://github.com/DrVrej/VJ-Base

/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/