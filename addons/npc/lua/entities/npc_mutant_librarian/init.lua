AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/magma/librarian_2033.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 2000
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_BIBLIO", "CLASS_CONTROLLER", "CLASS_ZOMBIE"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodParticle = {"blood_impact_red_01"} -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = {"Blood"} -- Leave blank for none | Commonly used: Red = Blood, Yellow Blood = YellowBlood
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK_SWING} -- Melee Attack Animations
ENT.MeleeAttackDistance = 65 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 1 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 1.1 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random (27, 28)
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.MeleeAttackKnockBack_Forward1 = 355
ENT.MeleeAttackKnockBack_Forward2 = 455
ENT.MeleeAttackKnockBack_Up1 = 100
ENT.MeleeAttackKnockBack_Up2 = 120
ENT.MeleeAttackWorldShakeOnMiss = false	
ENT.HasMeleeAttackKnockBack = true
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
	-- ====== Flinching Code ====== --

ENT.AnimTbl_LeapAttack = {ACT_JUMP}
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {""}
ENT.SoundTbl_Alert = {"npc/izlome/izlome_enemy_1.ogg","npc/izlome/izlome_enemy_2.ogg","npc/izlome/izlome_enemy_3.ogg","npc/izlome/izlome_enemy_4.ogg","npc/izlome/izlome_enemy_5.ogg"}
ENT.SoundTbl_Idle = {"npc/izlome/izlome_idle_1.ogg","npc/izlome/izlome_idle_2.ogg","npc/izlome/izlome_idle_3.ogg","npc/izlome/izlome_idle_4.ogg","npc/izlome/izlome_idle_12.ogg"}
ENT.SoundTbl_MeleeAttack = {"npc/fracture/izlom_attack_hit_0.ogg"}
ENT.SoundTbl_Pain = {"npc/izlome/izlome_hit_1.ogg","npc/izlome/izlome_hit_2.ogg","npc/izlome/izlome_hit_3.ogg","npc/izlome/izlome_hit_4.ogg"}
ENT.SoundTbl_Death = {"npc/izlome/izlome_death_2.ogg","npc/izlome/izlome_death_3.ogg","npc/izlome/izlome_death_4.ogg","npc/izlome/izlome_death_5.ogg","npc/izlome/izlome_death_6.ogg"}
ENT.SoundTbl_CombatIdle = {"npc/izlome/izlome_attack_1.ogg","npc/izlome/izlome_attack_2.ogg","npc/izlome/izlome_attack_3.ogg","npc/izlome/izlome_attack_4.ogg","npc/izlome/izlome_attack_5.ogg","npc/izlome/izlome_attack_6.ogg","npc/izlome/izlome_attack_7.ogg","npc/izlome/izlome_attack_8.ogg"}

ENT.AnimTbl_IdleStand = {"stand_check_corpse_0","stand_idle_0","stand_idle_1","stand_idle_2","stand_look_around_0"} -- The idle animation when AI is enabled

ENT.HasMeleeAttackKnockBack = true
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

 function ENT:CustomOnThink()

	if self.damage_showsmoke == 1 then
if self:Health() <= 50  then 

	self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("stand_walk_fwd_dmg_0"))}

end
	if self:Health()> 50 then 
	self.damage_showsmoke = 1
else
return
end
end	

end
function ENT:CustomInitialize()

local randomstartbg_body = math.random(0,5)
if randomstartbg_body  == 0 then self:SetSkin( 0 ) else
if randomstartbg_body  == 1 then self:SetSkin( 1 ) else
if randomstartbg_body  == 2 then self:SetSkin( 2 ) else
if randomstartbg_body  == 3 then self:SetSkin( 3 ) else
if randomstartbg_body  == 4 then self:SetSkin( 4 ) else
if randomstartbg_body  == 5 then self:SetSkin( 5 ) else

end
end
end
end
end
end

		 		local dm = math.random(1,3)
				if ( dm == 1 ) then
	
	self:VJ_ACT_PLAYACTIVITY("stand_sit_down_0",true,1.1,false,0,{SequenceDuration=self.DeathFlinchTime})
		self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("sit_idle_0"))}
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