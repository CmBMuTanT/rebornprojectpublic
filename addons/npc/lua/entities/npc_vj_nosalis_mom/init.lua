AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/magma/mutants/nosalis_mom.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 60000
ENT.HullType = HULL_LARGE
ENT.EntitiesToNoCollide = {"npc_vj_nosalis3"}
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.Immune_Physics = true -- If set to true, the SNPC won't take damage from props
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, poison, radiation
ENT.VJ_NPC_Class = {"CLASS_NOSALIS"} 
ENT.VJ_IsHugeMonster = true -- Is this a huge monster?

ENT.MeleeAttackDistance = 60 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 125 -- How far does the damage go?
ENT.MeleeAttackDamage = 20
ENT.HasMeleeAttackKnockBack = true
ENT.MeleeAttackKnockBack_Forward1 = 350
ENT.MeleeAttackKnockBack_Forward2 = 300
ENT.MeleeAttackKnockBack_Up1 = 250
ENT.MeleeAttackKnockBack_Up2 = 300
ENT.FootStepTimeRun = 0.35
ENT.FootStepTimeWalk = 0.35
ENT.NextAnyAttackTime_Melee = 0.7 -- How much time until it can use a attack again? | Counted in SecondsENT.MeleeAttackDamage = 15
ENT.TimeUntilMeleeAttackDamage = 0.3 -- This counted in seconds | This calculates the time until it hits something
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = false -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.Immune_AcidPoisonRadiation = false -- Immune to Acid, Poison and Radiation
ENT.NextStrafeTime = CurTime()
ENT.MeleeAttackAnimationFaceEnemy = false

ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 30
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 45
ENT.SlowPlayerOnMeleeAttackTime = 2.5

ENT.SlowPlayerOnMeleeAttack = true 
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 30
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 45
ENT.SlowPlayerOnMeleeAttackTime = 5.5


ENT.PushProps = true 
ENT.AttackProps = true 
ENT.PropAP_MaxSize = 100
    -- ====== Flinching Code ====== --
ENT.CanFlinch = 2 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 2 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchDamageTypes = {DMG_BLAST}
ENT.AnimTbl_Flinch = {"Shoved_Backward"} 
ENT.NextMoveAfterFlinchTime = "LetBaseDecide" -- How much time until it can move, attack, etc. | Use this for schedules or else the base will set the time 0.6 if it sees it's a schedule!

--TANK

//ENT.AnimTbl_Run = {ACT_WALK}
ENT.AlertSoundLevel = 100
ENT.CombatIdleSoundChance = 1
ENT.AlertSoundChance = 1
ENT.IdleSoundChance = 1
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.PushProps = true -- Should it push props when trying to move?
ENT.AttackProps = true
ENT.RunAwayOnUnknownDamage = false

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {
"nosalis/nosach_rider_hide.wav",
"nosalis/nosach_t4_idle_1.wav",
"nosalis/nosach_t4_idle_2.wav",
"nosalis/nosalis_medium_sniff2.wav",
"nosalis/nosalis_medium_sniff3.wav"
}


ENT.SoundTbl_Death = {
"nosalis_mom/rhino_death_1.wav",
"nosalis_mom/rhino_death_2.wav",
"arachnid/arachnid_death_3.wav"

}

ENT.SoundTbl_MeleeAttack = {
"nosalis_mom/rhino_attack_1.wav",
"nosalis_mom/rhino_attack_2.wav",
"nosalis_mom/rhino_attack_3.wav",
"nosalis_mom/rhino_attack_4.wav"
}

ENT.SoundTbl_FootStep = {
"nosalis/nosalis_foot_run_l01.mp3",
"nosalis/nosalis_foot_run_l02.mp3",
"nosalis/nosalis_foot_run_l03.mp3"
}


ENT.SoundTbl_Pain = {
"nosalis_mom/rhino_snort_1.wav",
"nosalis_mom/rhino_snort_2.wav",
"nosalis_mom/rhino_snort_3.wav",
"arachnid/arahnid_pain4.wav",
"arachnid/arahnid_pain5.wav"

}

ENT.SoundTbl_Alert = {
"nosalis_mom/rhino_longroar_2.wav"
}

ENT.SoundTbl_BeforeMeleeAttack = {
"nosalis_mom/rhino_foot_hit_1.wav",
"nosalis_mom/rhino_foot_hit_2.wav",
"nosalis_mom/rhino_attack_1.wav",
"nosalis_mom/rhino_attack_2.wav",
"nosalis_mom/rhino_attack_3.wav",
"nosalis_mom/rhino_attack_4.wav"
}

ENT.FootStepSoundLevel = 55
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 90
ENT.Charging = false -- Checks if the Guard is currently charging. Affects what melee animation it plays.
ENT.Haemorrhage = false -- Checks if the Guard is below 250 health to allow it to begin bleeding.
ENT.VJ_NPC_Controller = 0
---------------------------------------------------------------------------------------------------------------------------------------------







function ENT:StrafingMechanics()
local canstrafe = self:VJ_CheckAllFourSides(120)
if canstrafe.Right == true and canstrafe.Left == true then
local randstrafe = math.random(1,2)
if randstrafe == 1 then self:VJ_ACT_PLAYACTIVITY(ACT_TURN_LEFT,true,1.3,false) else self:VJ_ACT_PLAYACTIVITY(ACT_TURN_RIGHT,true,1.3,false) end
elseif canstrafe.Left == true and canstrafe.Right == false then
self:VJ_ACT_PLAYACTIVITY(ACT_TURN_LEFT,true,1.3,false)
elseif canstrafe.Right == true and canstrafe.Left == false then
self:VJ_ACT_PLAYACTIVITY(ACT_TURN_RIGHT,true,1.3,false)
end
end



function ENT:VJ_TASK_GOTO_TARGET(MoveType,CustomCode)
	MoveType = MoveType or "TASK_RUN_PATH"
	local vsched = ai_vj_schedule.New("vj_goto_target")
	vsched:EngTask("TASK_GET_PATH_TO_ENEMY_LOS", 0)
	vsched:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
	vsched:EngTask("TASK_FACE_TARGET", 1)
	vsched:EngTask("TASK_FIND_COVER_FROM_ENEMY")
	vsched.IsMovingTask = true
	if MoveType == "TASK_RUN_PATH" then self:SetMovementActivity(VJ_PICKRANDOMTABLE(self.AnimTbl_Run)) vsched.IsMovingTask_Run = true else self:SetMovementActivity(VJ_PICKRANDOMTABLE(self.AnimTbl_Walk)) vsched.IsMovingTask_Walk = true end
	if (CustomCode) then CustomCode(vsched) end
	self:StartSchedule(vsched)
end


function ENT:CustomOnInitialize()
        //self:SetHullType(self.HullType)
		self:SetCollisionBounds(Vector(25, 25, 75), Vector(-25, -25, 0))		
end

function ENT:CustomOnAlert(argent)
        self:VJ_ACT_PLAYACTIVITY(ACT_IDLE_ANGRY,true,1.74,true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(argent,attacker,inflictor)
        self:VJ_ACT_PLAYACTIVITY(ACT_ARM,true,4,true)
end
---------------------------------------------------------------------------------------------------------------------------------------------

function ENT:CustomDeathAnimationCode(dmginfo,hitgroup)
	self.DeathAnimationDecreaseLengthAmount = 0.09
	if self:IsMoving() && self:GetActivity() == ACT_RUN then
		self.AnimTbl_Death = {"vjseq_Death_2"}
		self.DeathAnimationTime = 2.2
               
	end
end

function ENT:MultipleMeleeAttacks()
	local randattack = math.random(1,2)
	if randattack == 1 then
		self.AnimTbl_MeleeAttack = {"vjges_Attack"}
		self.TimeUntilMeleeAttackDamage = 0.6
		self.MeleeAttackDamage = 50
		self.MeleeAttackDistance = 55
		self.MeleeAttackDamageDistance = 100
		self.NextAnyAttackTime_Melee = 1.6
	elseif randattack == 2 then
		self.AnimTbl_MeleeAttack = {"vjges_Attack_Incap","vjges_Attack_Moving"}
		self.TimeUntilMeleeAttackDamage = 0.6
		self.MeleeAttackDistance = 55
		self.MeleeAttackDamageDistance = 100
		self.MeleeAttackDamage = 20
		self.NextAnyAttackTime_Melee = 1.6
	end
end

