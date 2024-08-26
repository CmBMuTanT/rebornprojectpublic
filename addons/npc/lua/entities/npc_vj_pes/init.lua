AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/magma/wolf2_exodus.mdl"}  -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 120
ENT.HullType = HULL_HUMAN
ENT.FindEnemy_UseSphere = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_DOG","CLASS_CHIMERA&DOG"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodParticle = {"blood_impact_red_01"} -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = {"Blood"} -- Leave blank for none | Commonly used: Red = Blood, Yellow Blood = YellowBlood
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK_SWING} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.8 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.5 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random( 13, 16 )
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.CanFlinch = 1
ENT.FlinchDamageTypes = {DMG_BULLET}
ENT.FlinchChance = 1
ENT.NextFlinchTime = 3
ENT.FlinchAnimationDecreaseLengthAmount = 1
ENT.HasHitGroupFlinching = true
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS}
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.SightDistance = 5000 -- How far it can see
ENT.ShootDistance = 2000
ENT.LeapAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.LeapAttackAnimationFaceEnemy = false -- Should it face the enemy while playing the leap attack animation?
ENT.LeapAttackAnimationDecreaseLengthAmount = 0 -- This will decrease the time until starts chasing again. Use it to fix animation pauses until it chases the enemy.
ENT.LeapDistance = 180 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 0 -- How close does it have to be until it uses melee?
	-- To use event-based attacks, set this to false:
ENT.TimeUntilLeapAttackDamage = 0.70 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 2.6 -- How much time until it can use a leap attack?
ENT.NextLeapAttackTime_DoRand = false -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.NextAnyAttackTime_Leap = 1 -- How much time until it can use any attack again? | Counted in Seconds
ENT.NextAnyAttackTime_Leap_DoRand = false -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.LeapAttackReps = 1 -- How many times does it run the leap attack code?
ENT.StopLeapAttackAfterFirstHit = true -- Should it stop the leap attack from running rest of timers when it hits an enemy?
ENT.TimeUntilLeapAttackVelocity = 0.1 -- How much time until it runs the velocity code?
ENT.LeapAttackUseCustomVelocity = false -- Should it disable the default velocity system?
ENT.LeapAttackVelocityForward = 90 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 150 -- How much upward force should it apply?
ENT.LeapAttackVelocityRight = 0 -- How much right force should it apply?
ENT.LeapAttackDamage = 15
ENT.LeapAttackDamageDistance = 90 -- How far does the damage go?
ENT.LeapAttackDamageType = DMG_SLASH -- Type of Damage
ENT.DisableLeapAttackAnimation = false -- if true, it will disable the animation code
ENT.AnimTbl_LeapAttack = {ACT_DOD_RUN_ZOOM_BOLT}
ENT.Immune_Physics = true

ENT.NextSoundTime_Idle1 = 3
ENT.NextSoundTime_Idle2 = 6
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
ENT.FootStepTimeRun = 0.2 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
	-- ====== Flinching Code ====== --
ENT.Flinches = 1 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 14 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/dog/step_paw_earth1.ogg","npc/dog/step_paw_earth3.ogg","npc/dog/step_paw_earth4.ogg","npc/dog/step_paw_earth5.ogg"}
ENT.SoundTbl_Idle = {"npc/dog/bdog_idle_0.ogg","npc/dog/bdog_idle_1.ogg","npc/dog/bdog_idle_2.ogg","npc/dog/bdog_idle_3.ogg","npc/dog/bdog_idle_4.ogg","npc/dog/bdog_idle_5.ogg","npc/dog/bdog_idle_6.ogg","npc/dog/bdog_idle_7.ogg","npc/dog/bdog_idle_8.ogg","npc/dog/bdog_idle_9.ogg","npc/dog/idle_0.ogg","npc/dog/idle_1.ogg","npc/dog/idle_2.ogg"}
ENT.SoundTbl_Alert = {"npc/dog/attack_hit_5.ogg"}
ENT.SoundTbl_MeleeAttack = {"npc/dog/attack_hit_0.ogg","npc/dog/attack_hit_1.ogg","npc/dog/attack_hit_2.ogg","npc/dog/attack_hit_3.ogg","npc/dog/attack_hit_5.ogg"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/dog/attack_hit_0.ogg","npc/dog/attack_hit_1.ogg","npc/dog/attack_hit_2.ogg","npc/dog/attack_hit_3.ogg","npc/dog/attack_hit_5.ogg"}
ENT.SoundTbl_Pain = {"npc/dog/bdog_hurt_1.ogg","npc/dog/bdog_hurt_2.ogg","npc/dog/bdog_hurt_0.ogg","npc/dog/bdog_hurt_3.ogg","npc/dog/bdog_hurt_4.ogg","npc/dog/bdog_hurt_5.ogg","npc/dog/bdog_hurt_6.ogg"}
ENT.SoundTbl_Death = {"npc/dog/bdog_die_0.ogg","npc/dog/bdog_die_1.ogg","npc/dog/bdog_die_2.ogg","npc/dog/bdog_die_3.ogg","npc/dog/bdog_die_4.ogg","npc/dog/bdog_die_5.ogg","npc/dog/bdog_die_6.ogg"}
ENT.SoundTbl_CombatIdle = {"npc/dog/bdog_growl_0.ogg","npc/dog/bdog_growl_1.ogg","npc/dog/bdog_growl_2.ogg","npc/dog/bdog_attack_1.ogg","npc/dog/bdog_attack_2.ogg","npc/dog/bdog_attack_3.ogg","npc/dog/bdog_attack_4.ogg","npc/dog/bdog_attack_5.ogg","npc/dog/bdog_attack_6.ogg"}

ENT.SoundTbl_OnKilledEnemy = {"npc/dog/bdog_groan_0.ogg","npc/dog/bdog_groan_1.ogg","npc/dog/bdog_groan_2.ogg","npc/dog/bdog_groan_3.ogg","npc/dog/threaten_0.ogg","npc/dog/threaten_1.ogg"}
ENT.SoundTbl_LostEnemy = {"npc/dog/bdog_die_0.ogg","npc/dog/threaten_0.ogg","npc/dog/threaten_1.ogg"}
ENT.SoundTbl_LeapAttackJump = {"npc/dog/attack_hit_5.ogg"}
ENT.SoundTbl_LeapAttackDamage = {"npc/dog/bdog_attack_1.ogg"}
ENT.SoundTbl_LeapAttackDamageMiss = {"npc/dog/bdog_attack_1.ogg","npc/dog/threaten_0.ogg","npc/dog/threaten_1.ogg"}

ENT.AnimTbl_IdleStand = {"stand_idle_0","stand_idle_1","stand_idle_dig_ground_0","stand_threaten_0","stand_idle_smelling_up_0","stand_idle_smelling_down_0","stand_eat_0","stand_eat_1","stand_check_corpse_0","stand_idle_shake_0","stand_idle_howl_0"} -- The idle animation when AI is enabled
ENT.AnimTbl_Walk = {ACT_WALK} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_Run = {ACT_RUN} -- Set the running animations | Put multiple to let the base pick a random animation when it moves

function ENT:CustomOnThink()
	if self:IsOnFire() then
self.Behavior = VJ_BEHAVIOR_PASSIVE
	self.NextSoundTime_Pain1 = 14
self.NextSoundTime_Pain2 = 14


	end
	if not self:IsOnFire() and self:Health()> 50 then
self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
self.NextSoundTime_Pain1 = 2
self.NextSoundTime_Pain2 = 2
	end
	
	if self.damage_showsmoke == 1 then
	if (self:Health() <= 50 and (self:Health() > 26)) then 
	self.damage_showsmoke = 1

	self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("stand_idle_dmg_0","stand_idle_dmg_1","stand_idle_dmg_2"))}

	self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("stand_walk_fwd_dmg_0"))}
	
	self.AnimTbl_Run = {self:GetSequenceActivity(self:LookupSequence("stand_run_dmg_0"))}
self.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
self.FootStepTimeWalk = 0.9 -- Next foot step sound when it is walking

end

	if self:Health() <= 25 then 
		 		local dm = math.random(1,200)
				if ( dm == 1 ) then
self.Behavior = VJ_BEHAVIOR_PASSIVE
	self.AnimTbl_Run = {self:GetSequenceActivity(self:LookupSequence("stand_run_0"))}
self.SoundTbl_Idle = {"npc/dog/bdog_panic_0.ogg","npc/dog/bdog_panic_1.ogg","npc/dog/bdog_panic_2.ogg","npc/dog/bdog_panic_3.ogg","npc/dog/bdog_panic_4.ogg","npc/dog/bdog_panic_5.ogg","npc/dog/bdog_panic_6.ogg","npc/dog/bdog_panic_7.ogg"}
	self.SoundTbl_CombatIdle = {"npc/dog/bdog_panic_0.ogg","npc/dog/bdog_panic_1.ogg","npc/dog/bdog_panic_2.ogg","npc/dog/bdog_panic_3.ogg","npc/dog/bdog_panic_4.ogg","npc/dog/bdog_panic_5.ogg","npc/dog/bdog_panic_6.ogg","npc/dog/bdog_panic_7.ogg"}

				elseif ( dm == 25 ) then	
self.Behavior = VJ_BEHAVIOR_AGGRESSIVE

			else
			end

end

	if self:Health()> 50 then 
	self.damage_showsmoke = 1


else
return
end
end	

end

/*function ENT:CustomOnSchedule()
	-- Idle Postion --
	if self:GetEnemy() == nil then
		self.AnimTbl_IdleStand = {}
		self:DoIdleAnimation()
		self.TakingCover = false
		if GetConVarNumber("vj_npc_sd_idle") == 0 then
			self:IdleSoundCode()
		end
	else
	-- Scared Postion --
		self.TakingCover = true
		if self.Alerted == false then
			self:AlertSoundCode()
			self.Alerted = true
		end
		self.AnimTbl_IdleStand = {ACT_COWER}
		if CurTime() > self.Sci_NextScaredRunT or !self:IsCurrentSchedule(SCHED_RUN_FROM_ENEMY) then
		if self.FollowingPlayer == false then
			if self:Visible(self:GetEnemy()) then
				self:VJ_SetSchedule(SCHED_RUN_FROM_ENEMY)
			else
				self:DoIdleAnimation(2)
			end
		end
		self.Sci_NextScaredRunT = CurTime() + 5
		end
		self.TakingCover = false
		self:IdleSoundCode()
	end
end*/

function ENT:CustomInitialize()
local randomstartbg_body = math.random(0,4)
if randomstartbg_body  == 0 then self:SetSkin( 0 ) else
if randomstartbg_body  == 1 then self:SetSkin( 1 ) else
if randomstartbg_body  == 2 then self:SetSkin( 2 ) else
if randomstartbg_body  == 3 then self:SetSkin( 3 ) else
if randomstartbg_body  == 4 then self:SetSkin( 4 ) else

end
end
end
end
end

		 		local dm = math.random(1,6)
				if ( dm == 1 ) then
	
	
	self:VJ_ACT_PLAYACTIVITY("stand_to_sit_0",true,0.38,false,0,{SequenceDuration=self.DeathFlinchTime})
		self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("sit_idle_1","sit_idle_2","sit_idle_0"))}
self.DisableWandering = true
	self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("sit_idle_1","sit_idle_2","sit_idle_0"))}

				elseif ( dm == 2 ) then	
	self:VJ_ACT_PLAYACTIVITY("stand_to_sit_0",true,0.58,false,0,{SequenceDuration=self.DeathFlinchTime})
		self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("lie_sleep_0"))}

	self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("lie_sleep_0"))}
self.DisableWandering = true

				elseif ( dm == 3 ) then	
self.DisableWandering = true

			else			
			end



	self.damage_showsmoke = 1
 if self:Health() >= 51 then 

	end
end

ENT.FootStepSoundLevel = 60
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
function ENT:VJ_ACT_PLAYACTIVITY(vACT_Name,vACT_StopActivities,vACT_StopActivitiesTime,vACT_FaceEnemy,vACT_DelayAnim,vACT_AdvancedFeatures,vACT_CustomCode)
	if vACT_Name == nil or vACT_Name == false then return end
	vACT_StopActivities = vACT_StopActivities or false
	if vACT_StopActivitiesTime == nil then
		vACT_StopActivitiesTime = 0 -- Set this value to false to let the base calculate the time
	end
	vACT_FaceEnemy = vACT_FaceEnemy or false
	vACT_DelayAnim = vACT_DelayAnim or 0
	vACT_AdvancedFeatures = vACT_AdvancedFeatures or {}
	vTbl_AlwaysUseSequence = vACT_AdvancedFeatures.AlwaysUseSequence or false
	vTbl_SequenceDuration = vACT_AdvancedFeatures.SequenceDuration -- Done automatically
	vTbl_SequenceInterruptible = vACT_AdvancedFeatures.SequenceInterruptible or false -- Can it be Interrupted? (Mostly used for idle animations)
	vTbl_AlwaysUseGesture = vACT_AdvancedFeatures.AlwaysUseGesture or false
	vTbl_PlayBackRate = vACT_AdvancedFeatures.PlayBackRate or 0.5
	//vACT_CustomCode = vACT_CustomCode or function() end
	if istable(vACT_Name) then vACT_Name = VJ_PICK(vACT_Name) end
	local IsGesture = false
	local IsSequence = false
	if string.find(vACT_Name, "vjges_") then
		IsGesture = true
		vACT_Name = string.Replace(vACT_Name,"vjges_","")
		if string.find(vACT_Name, "vjseq_") then
			IsSequence = true
			vACT_Name = string.Replace(vACT_Name,"vjseq_","")
		end
		if self:LookupSequence(vACT_Name) == -1 then vACT_Name = tonumber(vACT_Name) end
		//vACT_Name = tonumber(string.Replace(vACT_Name,"vjges_",""))
	end
	
	if vACT_StopActivitiesTime == false then
		vACT_StopActivitiesTime = self:DecideAnimationLength(vACT_Name,false)
	end
	
	if type(vACT_Name) != "string" && VJ_AnimationExists(self,vACT_Name) == false then
		if self:GetActiveWeapon() != NULL then
			if self:GetActiveWeapon().IsVJBaseWeapon && VJ_HasValue(table.GetKeys(self:GetActiveWeapon().ActivityTranslateAI),vACT_Name) != true then return end
		else
			return
		end
	end
	if type(vACT_Name) == "string" && VJ_AnimationExists(self,vACT_Name) == false then return end

	local vsched = ai_vj_schedule.New("vj_act_"..vACT_Name)
	if vTbl_AlwaysUseSequence == true then
		IsSequence = true
		if type(vACT_Name) == "number" then
			vACT_Name = self:GetSequenceName(self:SelectWeightedSequence(vACT_Name))
		end
	end
	if vTbl_AlwaysUseGesture == true then
		IsGesture = true
		if type(vACT_Name) == "number" then
			vACT_Name = self:GetSequenceName(self:SelectWeightedSequence(vACT_Name))
		end
	end
	//vsched:EngTask("TASK_RESET_ACTIVITY", 0)
	if vACT_StopActivities == true then
		self:StopAttacks(true)
		self.vACT_StopAttacks = true
		self.NextChaseTime = CurTime() + vACT_StopActivitiesTime
		self.NextIdleTime = CurTime() + vACT_StopActivitiesTime
		if timer.Exists("timer_act_stopattacks") then
			timer.Adjust("timer_act_stopattacks"..self:EntIndex(),vACT_StopActivitiesTime,1,function() self.vACT_StopAttacks = false end)
		else
			timer.Create("timer_act_stopattacks"..self:EntIndex(),vACT_StopActivitiesTime,1,function() self.vACT_StopAttacks = false end)
		end
		//timer.Simple(vACT_StopActivitiesTime,function() self.vACT_StopAttacks = false end)
	end
	self.NextIdleStandTime = 0
	if (vACT_CustomCode) then vACT_CustomCode(vsched) end

	if vTbl_AlwaysUseSequence == false && type(vACT_Name) == "string" then
		local checkanim = self:GetSequenceActivity(self:LookupSequence(vACT_Name))
		if string.find(vACT_Name, "vjseq_") then
			IsSequence = true
			vACT_Name = string.Replace(vACT_Name,"vjseq_","")
		else
			if checkanim == nil or checkanim == -1 then
				IsSequence = true
			else
				vACT_Name = checkanim
			end
		end
	end
	if IsSequence == false then self.VJ_PlayingSequence = false end
	if self.VJ_IsPlayingInterruptSequence == true then self.VJ_IsPlayingInterruptSequence = false end

	if !isnumber(vACT_DelayAnim) then vACT_DelayAnim = 0 end
	timer.Simple(vACT_DelayAnim,function()
	if IsValid(self) then
		if IsGesture == true then
			local gesttest = false
			if IsSequence == false then gesttest = self:AddGesture(vACT_Name) end
			if IsSequence == true then gesttest = self:AddGestureSequence(self:LookupSequence(vACT_Name)) end
			if gesttest != false then
				//self:ClearSchedule()
				//self:SetLayerBlendIn(1,0)
				//self:SetLayerBlendOut(1,0)
				self:SetLayerPriority(gesttest,1) // 2
				//self:SetLayerWeight(gesttest,1)
				self:SetLayerPlaybackRate(gesttest,vTbl_PlayBackRate)
				//self:SetLayerDuration(gesttest,3)
				//print(self:GetLayerDuration(gesttest))
			end
		end
		if IsSequence == true && IsGesture == false then
			seqwait = true
			if vTbl_SequenceDuration == false then seqwait = false end
			vTbl_SequenceDuration = vTbl_SequenceDuration or self:SequenceDuration(self:LookupSequence(vACT_Name))
			if vACT_FaceEnemy == true then self:FaceCertainEntity(self:GetEnemy(),true,vTbl_SequenceDuration) end
			self:VJ_PlaySequence(vACT_Name,1,seqwait,vTbl_SequenceDuration,vTbl_SequenceInterruptible)
		end
		if IsGesture == false then
			self:StartEngineTask(GetTaskList("TASK_RESET_ACTIVITY"), 0)
			//vsched:EngTask("TASK_RESET_ACTIVITY", 0)
			//if self.Dead == true then vsched:EngTask("TASK_STOP_MOVING", 0) end
			//vsched:EngTask("TASK_STOP_MOVING", 0)
			//vsched:EngTask("TASK_STOP_MOVING", 0)
			//self:FrameAdvance(0)
			self:StopMoving()
			self:ClearSchedule()
			///self:ClearGoal()
			if IsSequence == false then
				self.VJ_PlayingSequence = false
				if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then
					vsched:EngTask("TASK_SET_ACTIVITY",vACT_Name) -- To avoid AutoMovement stopping the velocity
				else
					if vACT_FaceEnemy == true then
						vsched:EngTask("TASK_PLAY_SEQUENCE_FACE_ENEMY",vACT_Name)
					else
						vsched:EngTask("TASK_PLAY_SEQUENCE",vACT_Name)
					end
				end
			end
			//self:ClearSchedule()
			//self:StartEngineTask(GetTaskList("TASK_RESET_ACTIVITY"), 0)
			self:StartSchedule(vsched)
			//self:MaintainActivity()
		end
	 end
	end)
	//self:MaintainActivity()
	//self:TaskComplete()
end