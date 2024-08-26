AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/monsters/biomassa.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 735
ENT.HullType = HULL_HUMAN
ENT.FindEnemy_UseSphere = true

---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_BIOMASS"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodParticle = {"blood_impact_red_01"} -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = {"Blood"} -- Leave blank for none | Commonly used: Red = Blood, Yellow Blood = YellowBlood
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK_SWING} -- Melee Attack Animations
ENT.MeleeAttackDistance = 45 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.5 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.3 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random( 22, 23 )
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage

ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.SightDistance = 8000 -- How far it can see
ENT.ShootDistance = 2500
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
ENT.LeapAttackVelocityUp = 270 -- How much upward force should it apply?
ENT.LeapAttackVelocityRight = 0 -- How much right force should it apply?
ENT.LeapAttackDamage = 22
ENT.LeapAttackDamageDistance = 90 -- How far does the damage go?
ENT.LeapAttackDamageType = DMG_SLASH -- Type of Damage
ENT.DisableLeapAttackAnimation = false -- if true, it will disable the animation code
ENT.AnimTbl_LeapAttack = {ACT_MELEE_ATTACK_SWING}
ENT.Immune_Physics = true

ENT.SoundTbl_Idle = {"npc/biomassa/idle_1.ogg","npc/biomassa/idle_fail_1.ogg","npc/biomassa/idle_fail_2.ogg","npc/biomassa/idle_fail_3.ogg","npc/biomassa/idle_bzdox.ogg","npc/biomassa/idle_born_ameba_1.ogg"}
ENT.SoundTbl_Alert = {"npc/biomassa/attack_start.ogg"}
ENT.SoundTbl_Pain = {"npc/biomassa/hit_2.ogg"}
ENT.SoundTbl_Death = {"npc/biomassa/death.ogg"}
ENT.SoundTbl_CombatIdle = {"npc/biomassa/attack_stop_1.ogg"}
--------------------------------------------------
  
-- Leave blank if you don't want any sounds to play


 function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)


				local Rand = math.random(1,12)
				if Rand == 1 then 
					 self:VJ_ACT_PLAYACTIVITY("jump",true,0.5)
					self:SetLocalVelocity(self:GetRight()*-300 + self:GetUp()*30)
				elseif Rand == 2 then 
					self:VJ_ACT_PLAYACTIVITY("jump",true,0.5)
					self:SetLocalVelocity(self:GetRight()*300 + self:GetUp()*30)

				end

 end
function ENT:CustomOnThink()

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

	util.BlastDamage(self,self,self:GetPos(),450,125)
	util.ScreenShake(self:GetPos(),200,300,1,1000)
		local energy = EffectData()
		energy:SetOrigin(self:GetPos() +self:OBBCenter())
		energy:SetColor(VJ_Color2Byte(Color(100,0,0)))
		energy:SetScale(300)
		util.Effect("VJ_Blood1",energy)

		local energy2 = EffectData()
		energy2:SetOrigin(self:GetPos() +self:OBBCenter())
		energy2:SetColor(VJ_Color2Byte(Color(150,150,35)))
		energy2:SetScale(200)
		util.Effect("VJ_Blood1",energy2)
			

		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() +self:OBBCenter()) -- the vector of were you want the effect to spawn
		effectdata:SetScale(100) -- how big the particles are, can even be 0.1 or 0.6
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/liver_gib.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl")		
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/liver_gib.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl")		
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/liver_gib.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/liver_gib.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/liver_gib.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl")	
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_01.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_02.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_03.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_03.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_04.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_05.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_06.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_07.mdl")
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl")			
		self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
		self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")

	self:CreateGibEntity("prop_physics","models/gibs/antlion_gib_medium_3.mdl",{Pos=self:LocalToWorld(Vector(0,3,0)),Ang=self:GetAngles(),Vel=self:GetRight()*math.Rand(-150,-250)+self:GetForward()*math.Rand(-200,200)})
	self:CreateGibEntity("prop_physics","models/gibs/antlion_gib_medium_2.mdl",{Pos=self:LocalToWorld(Vector(4,3,4)),Ang=self:GetAngles(),Vel=self:GetRight()*math.Rand(-150,-250)+self:GetForward()*math.Rand(-200,200)})
	self:CreateGibEntity("prop_physics","models/gibs/antlion_gib_medium_1.mdl",{Pos=self:LocalToWorld(Vector(6,3,2)),Ang=self:GetAngles(),Vel=self:GetRight()*math.Rand(-150,-250)+self:GetForward()*math.Rand(-200,200)})
	self:CreateGibEntity("prop_physics","models/gibs/antlion_gib_small_3.mdl",{Pos=self:LocalToWorld(Vector(0,6,0)),Ang=self:GetAngles(),Vel=self:GetRight()*math.Rand(-150,-250)+self:GetForward()*math.Rand(-200,200)})
	self:CreateGibEntity("prop_physics","models/gibs/antlion_gib_small_2.mdl",{Pos=self:LocalToWorld(Vector(2,6,4)),Ang=self:GetAngles(),Vel=self:GetRight()*math.Rand(-150,-250)+self:GetForward()*math.Rand(-200,200)})
	self:CreateGibEntity("prop_physics","models/gibs/antlion_gib_small_1.mdl",{Pos=self:LocalToWorld(Vector(6,6,2)),Ang=self:GetAngles(),Vel=self:GetRight()*math.Rand(-150,-250)+self:GetForward()*math.Rand(-200,200)})
		
 end