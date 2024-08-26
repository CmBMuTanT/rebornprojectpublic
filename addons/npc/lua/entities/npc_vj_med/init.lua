AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/magma/forest_god_exodus.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 5500
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_BEAR"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodParticle = {"blood_impact_red_01"} -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = {"Blood"} -- Leave blank for none | Commonly used: Red = Blood, Yellow Blood = YellowBlood
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK_SWING} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 1.5 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 1.5 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random (31, 40)
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {ACT_JUMP} -- Melee Attack Animations
ENT.LeapDistance = 500 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 255 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 0.5 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 8 -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 0.4 -- How much time until it can use a attack again? | Counted in Seconds
ENT.LeapAttackVelocityForward = 400 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 245 -- How much upward force should it apply?
ENT.LeapAttackDamage = 45
ENT.LeapAttackDamageDistance = 100 -- How far does the damage go?
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walkinging
ENT.MaxJumpLegalDistance = VJ_Set(0,0)
ENT.Immune_Physics = true
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/dog/step_paw_earth1.ogg","npc/dog/step_paw_earth3.ogg","npc/dog/step_paw_earth4.ogg","npc/dog/step_paw_earth5.ogg"}
ENT.SoundTbl_Idle = {"npc/bear/bear_idle_0.ogg"}
ENT.SoundTbl_Alert = {"npc/bear/bear_threaten_0.ogg","npc/bear/bear_threaten_1.ogg"}
ENT.SoundTbl_MeleeAttack = {"npc/bear/bear_attack_0.ogg","npc/bear/bear_attack_1.ogg"}
ENT.SoundTbl_Pain = {"npc/bear/bear_pain_0.ogg","npc/bear/bear_pain_1.ogg"}
ENT.SoundTbl_Death = {"npc/bear/bear_death_0.ogg","npc/bear/bear_death_1.ogg","npc/bear/bear_death_2.ogg","npc/bear/bear_death_3.ogg"}
ENT.SoundTbl_CombatIdle = {"npc/bear/bear_aggressive_0.ogg","npc/bear/bear_panic_0.ogg"}
ENT.SoundTbl_LeapAttackJump = {"npc/bear/bear_attack_hit_1.ogg","npc/bear/bear_attack_hit_2.ogg"}
ENT.HasMeleeAttackKnockBack = true
ENT.AnimTbl_IdleStand = {"idle_0","idle_1","idle_2","eat","look_around"} -- The idle animation when AI is enabled
----------------Simplified AI---------------------

ENT.AllowPrintingInChat = false
ENT.HasEntitiesToNoCollide = false
ENT.CanOpenDoors = false
ENT.CallForHelp = false
ENT.FollowPlayer = false
ENT.HasPoseParameterLooking = false
ENT.PushProps = false
ENT.AttackProps = false
ENT.HasDamageByPlayer = false
ENT.AllowedToGib = false -- Is it allowed to gib in general? This can be on death or when shot in a certain place
ENT.HasGibOnDeath = false -- Is it allowed to gib on death?  
ENT.HasItemDropsOnDeath = false
ENT.BringFriendsOnDeath = false
ENT.HasIdleDialogueSounds = false
ENT.OnlyDoKillEnemyWhenClear = false
ENT.DisableInitializeCapabilities = true
--------------------------------------------------
function ENT:CustomOnAlert(argent)
	if self.VJ_IsBeingControlled == true then return end
	self:VJ_ACT_PLAYACTIVITY({"treaten"},true,false,true)

 end
function ENT:MultipleMeleeAttacks()
		 		local dms = math.random(1,2)
				if ( dms == 1 ) then
self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK_SWING} -- Melee Attack Animations
self.MeleeAttackDistance = 42 -- How close does it have to be until it attacks?
self.MeleeAttackDamageDistance = 85 -- How far does the damage go?
self.TimeUntilMeleeAttackDamage = 0.5 -- This counted in seconds | This calculates the time until it hits something
self.NextAnyAttackTime_Melee = 0.5 -- How much time until it can use a attack again? | Counted in Seconds
self.MeleeAttackDamage = math.random (31, 40)
self.MeleeAttackKnockBack_Forward1 = 100 -- How far it will push you forward | First in math.random
self.MeleeAttackKnockBack_Forward2 = 100 -- How far it will push you forward | Second in math.random
self.MeleeAttackKnockBack_Up1 = 10 -- How far it will push you up | First in math.random
self.MeleeAttackKnockBack_Up2 = 10 -- How far it will push you up | Second in math.random
				elseif ( dms == 2 ) then	
self.AnimTbl_MeleeAttack = {ACT_DOD_STAND_AIM_PSCHRECK} -- Melee Attack Animations
self.MeleeAttackDistance = 45 -- How close does it have to be until it attacks?
self.MeleeAttackDamageDistance = 95 -- How far does the damage go?
self.TimeUntilMeleeAttackDamage = 1.5 -- This counted in seconds | This calculates the time until it hits something
self.NextAnyAttackTime_Melee = 1.5 -- How much time until it can use a attack again? | Counted in Seconds
self.MeleeAttackDamage = math.random (48, 55)
		self.MeleeAttackKnockBack_Forward1 = 255
		self.MeleeAttackKnockBack_Forward2 = 355
		self.MeleeAttackKnockBack_Up1 = 180
		self.MeleeAttackKnockBack_Up2 = 280
		self.MeleeAttackWorldShakeOnMiss = false			
			end
 end
function ENT:CustomOnThink()
	if self.damage_showsmoke == 1 then
	if ((self:Health() <= 250) and (self:Health() > 50))  then 
	self.damage_showsmoke = 1
	self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("stand_idle_dmg_0"))}
	self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("stand_steal_0"))}
	
	self.AnimTbl_Run = {self:GetSequenceActivity(self:LookupSequence("_stand_run_dmg_0"))}
	elseif self:Health() <= 50 then 

	self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("stand_walk_fwd_dmg_0"))}
	
	self.AnimTbl_Run = {self:GetSequenceActivity(self:LookupSequence("stand_run_dmg_0"))}
end
	if self:Health()> 50 then 
	self.damage_showsmoke = 1


else
return
end
end	

end



function ENT:CustomInitialize()


		 		local dm = math.random(1,6)
				if ( dm == 1 ) then
	
		self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("sit_1","sit_2","sit_3"))}
self.DisableWandering = true

				elseif ( dm == 2 ) then	
		self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("sleep","sleep2"))}	
self.DisableWandering = true
				elseif ( dm == 3 ) then	
		self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("lie_0","lie_1"))}					
self.DisableWandering = true
				elseif ( dm == 4 ) then					
self.DisableWandering = true
			else			
			end

	self.damage_showsmoke = 1
 if self:Health() >= 51 then 

	end
end
ENT.FootStepSoundLevel = 80
ENT.BreathSoundPitch1 = 100
ENT.BreathSoundPitch2 = 100
ENT.IdleSoundPitch1 = 100
ENT.IdleSoundPitch2 = 100
ENT.CombatIdleSoundPitch1 = 100
ENT.CombatIdleSoundPitch2 = 100
ENT.OnReceiveOrderSoundPitch1 = 100
ENT.OnReceiveOrderSoundPitch2 = 100
ENT.MoveOutOfPlayersWaySoundPitch1 = 100
ENT.MoveOutOfPlayersWaySoundPitch2 = 100
ENT.BeforeHealSoundPitch1 = 100
ENT.BeforeHealSoundPitch2 = 100
ENT.AfterHealSoundPitch1 = 100
ENT.AfterHealSoundPitch2 = 100
ENT.MedicReceiveHealSoundPitch1 = 100
ENT.MedicReceiveHealSoundPitch2 = 100
ENT.OnPlayerSightSoundPitch1 = 100
ENT.OnPlayerSightSoundPitch2 = 100
ENT.AlertSoundPitch1 = 100
ENT.AlertSoundPitch2 = 100
ENT.CallForHelpSoundPitch1 = 100
ENT.CallForHelpSoundPitch2 = 100
ENT.BecomeEnemyToPlayerPitch1 = 100
ENT.BecomeEnemyToPlayerPitch2 = 100
ENT.SuppressingPitch1 = 100
ENT.SuppressingPitch2 = 100
ENT.WeaponReloadSoundPitch1 = 100
ENT.WeaponReloadSoundPitch2 = 100
ENT.GrenadeAttackSoundPitch1 = 100
ENT.GrenadeAttackSoundPitch2 = 100
ENT.OnGrenadeSightSoundPitch1 = 100
ENT.OnGrenadeSightSoundPitch2 = 100
ENT.OnKilledEnemySoundPitch1 = 100
ENT.OnKilledEnemySoundPitch2 = 100
ENT.PainSoundPitch1 = 100
ENT.PainSoundPitch2 = 100
ENT.ImpactSoundPitch1 = 80
ENT.ImpactSoundPitch2 = 100
ENT.DamageByPlayerPitch1 = 100
ENT.DamageByPlayerPitch2 = 100
ENT.DeathSoundPitch1 = 100
ENT.DeathSoundPitch2 = 100