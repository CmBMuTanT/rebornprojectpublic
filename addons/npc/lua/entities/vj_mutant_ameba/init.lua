AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/monsters/ameba.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 50
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_AMEBA", "CLASS_BIOMASS"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodParticle = {"blood_impact_red_01"} -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = {"Blood"} -- Leave blank for none | Commonly used: Red = Blood, Yellow Blood = YellowBlood
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK_SWING} -- Melee Attack Animations
ENT.MeleeAttackDistance = 25 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 1 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.8 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random( 17, 21 )
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.Immune_Physics = true
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking

	-- ====== Flinching Code ====== --


ENT.SoundTbl_Idle = {"npc/flesh/flesh_eat_0.ogg","npc/flesh/flesh_eat_1.ogg","npc/flesh/flesh_eat_2.ogg","npc/flesh/flesh_eat_3.ogg","npc/flesh/flesh_eat_4.ogg","npc/flesh/flesh_eat_5.ogg","npc/flesh/flesh_eat_6.ogg","npc/flesh/flesh_idle_0.ogg","npc/flesh/flesh_idle_1.ogg","npc/flesh/flesh_idle_2.ogg","npc/flesh/flesh_idle_3.ogg","npc/flesh/flesh_idle_4.ogg"}

ENT.SoundTbl_Idle = {"npc/biomassa/idle_1.ogg","npc/biomassa/idle_fail_1.ogg","npc/biomassa/idle_fail_2.ogg","npc/biomassa/idle_fail_3.ogg","npc/biomassa/idle_bzdox.ogg","npc/biomassa/idle_born_ameba_1.ogg"}
ENT.SoundTbl_Alert = {"npc/biomassa/attack_start.ogg"}
ENT.SoundTbl_Pain = {"npc/biomassa/hit_2.ogg"}

ENT.SoundTbl_CombatIdle = {"npc/biomassa/attack_stop_1.ogg"}

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

ENT.AnimTbl_IdleStand = {"stand_idle_0","stand_idle_1","stand_idle_2","stand_check_corpse_0","stand_eat_0","stand_eat_1","stand_eat_2","stand_eat_3","stand_attack_rat_0","stand_crawl_0","stand_look_around_0","stand_scared_0","stand_to_eat_0"}

function ENT:CustomOnAlert(argent)
  self.AnimTbl_IdleStand = {"stand_idle_0","stand_idle_1","stand_idle_2","stand_check_corpse_0","stand_eat_0","stand_eat_1","stand_eat_2","stand_eat_3","stand_attack_rat_0","stand_crawl_0","stand_look_around_0","stand_scared_0","stand_to_eat_0"}

		 		local dm = math.random(1,2)
				if ( dm == 1 ) then
	if self.VJ_IsBeingControlled == true then return end
	self:VJ_ACT_PLAYACTIVITY({"stand_threaten_0"},true,false,true)
	end
 end
  function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)

 if not self:IsOnFire() then
				local Rand = math.random(1,100)
				if Rand == 1 then 
					 self:VJ_ACT_PLAYACTIVITY({"stand_jump_left_0"},true,false,true)
					self:SetLocalVelocity(self:GetForward()*350 + self:GetUp()*150 + self:GetRight()*-450)	
        elseif	Rand == 2 then 	
						 self:VJ_ACT_PLAYACTIVITY({"stand_jump_right_0"},true,false,true)
					self:SetLocalVelocity(self:GetForward()*350 + self:GetUp()*150+ self:GetRight()*450)	
					
				end
				end
 end
function ENT:CustomOnThink()

	if self:IsOnFire() then
self.Behavior = VJ_BEHAVIOR_PASSIVE

	self.NextSoundTime_Pain1 = 2
self.NextSoundTime_Pain2 = 3
	end
	if not self:IsOnFire() then
self.Behavior = VJ_BEHAVIOR_AGGRESSIVE

self.NextSoundTime_Pain1 = 2
self.NextSoundTime_Pain2 = 2
	end
	

end
function ENT:CustomInitialize()


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
ENT.HasDeathRagdoll = false
function ENT:CustomOnKilled(dmginfo,hitgroup)
--self:EmitSound("f1_explode.ogg", 100, 15000)

	util.BlastDamage(self,self,self:GetPos(),250,125)
	util.ScreenShake(self:GetPos(),200,300,1,1000)
		local energy = EffectData()
		energy:SetOrigin(self:GetPos() +self:OBBCenter())
		energy:SetColor(VJ_Color2Byte(Color(255,0,0)))
		energy:SetScale(300)
		util.Effect("VJ_Blood1",energy)

		local energy2 = EffectData()
		energy2:SetOrigin(self:GetPos() +self:OBBCenter())
		energy2:SetColor(VJ_Color2Byte(Color(150,150,35)))
		energy2:SetScale(300)
		util.Effect("VJ_Blood1",energy2)
		
		local energy3 = EffectData()
		energy3:SetOrigin(self:GetPos() +self:OBBCenter())
		energy3:SetColor(VJ_Color2Byte(Color(150,150,35)))
		energy3:SetScale(300)
		util.Effect("VJ_Blood1",energy3)


		local energy4 = EffectData()
		energy4:SetOrigin(self:GetPos() +self:OBBCenter())
		energy4:SetColor(VJ_Color2Byte(Color(150,150,35)))
		energy4:SetScale(300)
		util.Effect("VJ_Blood1",energy4)


		local energy5 = EffectData()
		energy5:SetOrigin(self:GetPos() +self:OBBCenter())
		energy5:SetColor(VJ_Color2Byte(Color(150,150,35)))
		energy5:SetScale(300)
		util.Effect("VJ_Blood1",energy5)


		local energy6 = EffectData()
		energy6:SetOrigin(self:GetPos() +self:OBBCenter())
		energy6:SetColor(VJ_Color2Byte(Color(150,150,35)))
		energy6:SetScale(300)

		util.Effect("VJ_Blood1",energy6)

		local energy7 = EffectData()
		energy7:SetOrigin(self:GetPos() +self:OBBCenter())
		energy7:SetColor(VJ_Color2Byte(Color(255,150,0)))
		energy7:SetScale(300)
				util.Effect("VJ_Blood1",energy7)
		end