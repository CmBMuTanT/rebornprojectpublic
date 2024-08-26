
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {

}

SWEP.ZatvorBone = "saiga_zatvor"
SWEP.UseZatvorBone = false

SWEP.EmptyReload = false
SWEP.ChamberedRound = true
SWEP.Ironsights = false

SWEP.ShellTexture = "effects/animated/animated_gilza_3"

SWEP.GaySightAttack = true

if ( CLIENT ) then
	
	--SWEP.ViewModelFOV = 50
	
end

SWEP.DefaultAnims = {
	["fire"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["reload"] = ACT_VM_RELOAD,
	["holster"] = ACT_VM_HOLSTER,
	["start_fire"] = ACT_VM_HITLEFT,
	["end_fire"] = ACT_VM_HITLEFT2,
	["pump_start"] = ACT_VM_RECOIL1,
	["pump"] = ACT_VM_RECOIL2,
	["pump2"] = ACT_VM_RECOIL3,
	["pump_finish"] = ACT_VM_ATTACH_SILENCER
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Огнемет"
SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/ognemet/v_ognemet.mdl"--"models/cw2/rifles/ak74.mdl"--"models/weapons/c_357.mdl"--
SWEP.WorldModel		= "models/w_weapons/w_ognemet.mdl"

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
SWEP.IronsightPos = Vector(-2.95, -2, 0.85)
SWEP.IronsightAng = Vector(-0.5, 0, 0)
--SWEP.IronsightPos = Vector(-2.651, -2, 0.6)
--SWEP.IronsightAng = Vector(-0.5, 0, 0)
SWEP.IronsightZoom = 20
SWEP.SightsConeMul = 0.5

SWEP.RunPos = Vector(1.475, -2.396, -0.369)
SWEP.RunAng = Vector(-10.323, 24.516, -9.678)

--SWEP.AttPos = Vector(4.421, -7.84, -2.412)
--SWEP.AttAng = Vector(33.769, 23.92, 14.774)
--SWEP.AttPos = Vector(4.609, -7.391, -1.305)
--SWEP.AttAng = Vector(32.564, 44.13, 22.826)

SWEP.ReloadBobMul	= 1

SWEP.MagGroupOffset = 0
SWEP.ReloadAmmoDelay = 2

SWEP.Chargeable = true
SWEP.ChargeTake = 1
SWEP.ChargeAdd = 10
SWEP.ChargeStrelkaBone = "strelka"
SWEP.ChargeStrelkaMul = -2.4
SWEP.StrelkaOffset = 0

SWEP.HoldType		= "shotgun"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 0.5

SWEP.Primary.Damage			= 99 
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 99
SWEP.Primary.Force			= 3

SWEP.Primary.Delay			= 0.2

SWEP.Primary.ClipSize		= 100 ---1
SWEP.Primary.DefaultClip	= 100 ---1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "metro_fuel"

SWEP.UseHands = false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.RandomPrimarySound		= false
SWEP.MaxRandomSound			= 3
SWEP.RandomSoundFileType	= ".mp3"
SWEP.PrimarySound			= "ambient/fire/mtov_flame2.wav"
SWEP.Slot    = 5
SWEP.SlotPos = 5
SWEP.RandomSilSound			= false
SWEP.MaxRandomSilSound		= 3
SWEP.SilencedSound	= "weapons/ubo_1.mp3"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

SWEP.ChargeInSound = "weapons/tikhar_pump_in.mp3"
SWEP.ChargeOutSound = "weapons/tikhar_pump_out.mp3"

SWEP.PumpSound = "weapons/gatling/gatling_wind_up.wav"
SWEP.PumpHardSound = "weapons/gatling/gatling_wind_up.wav"

SWEP.MagGroupClipOffset = 6

SWEP.NextWindUp = 0
SWEP.Holding = false

SWEP.FlamerRange = 400

SWEP.NxtPunch = 0

local mutant_base = "npc_vj_creature_base"

function SWEP:SecondThink()

	if self.NextWindUp > CurTime() then
	
		if self.NxtPunch < CurTime() then
			local rand_roll = math.random(-0.1, 0.1)
			self.Owner:ViewPunch( Angle( rand_roll/2, 0, math.sin(CurTime()*10)*0.5 ) )
			self.NxtPunch = CurTime() + 0.1
			self:Muzzle()
			if SERVER then
				local tr = util.TraceHull( {
					start = self.Owner:GetShootPos(),
					endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * self.FlamerRange ),
					filter = self.Owner,
					mins = Vector( -10, -10, -10 ),
					maxs = Vector( 10, 10, 10 ),
					mask = MASK_SHOT_HULL
				} )
				
				if ( tr.Hit ) then
					local dmginfo = DamageInfo()
					dmginfo:SetDamageType(DMG_BURN)
					dmginfo:SetAttacker(self.Owner)
					dmginfo:SetInflictor(self)
                    
                    if tr.Entity and tr.Entity.Base and tr.Entity.Base == mutant_base then
						dmginfo:SetDamage(10)
                    else
                        dmginfo:SetDamage(5)
					end
                    
					tr.Entity:Ignite(10)
					
					if tr.Entity:IsNPC() or tr.Entity:IsPlayer() then
						dmginfo:SetDamageForce(self.Owner:GetForward()*3000)
					else
						if IsValid(tr.Entity:GetPhysicsObject()) then
							tr.Entity:GetPhysicsObject():ApplyForceCenter(self.Owner:GetForward()*1500)
						end
					end
					
					tr.Entity:TakeDamageInfo(dmginfo)
				end
			end
		end
		
	end
	
end

SWEP.MuzzleName = "m_flamer"

function SWEP:PrimaryAttack()
	if not IsValid(self.Owner) or self.Owner:Health() < 0 or !self:CanPrimaryAttack() or self:GetRunning() or self:GetNextReload() > CurTime() or (self.Chargeable and self:GetCharge() <= 0) then 
	return 
	end
		
		self.NextWindUp = CurTime() + 0.5
		--self.idledelay = CurTime() + 1
		
		--self:ShootBullet(self.Primary.Damage, self.Primary.NumShots*self.Primary.TakeAmmo, self.Primary.Cone)
		self:PlayAnim("fire")
		--self.Owner:SetAnimation(PLAYER_ATTACK1)
	
		if self.RandomPrimarySound then
			self:EmitSound(self.PrimarySound.."_"..math.random(1, self.MaxRandomSound)..self.RandomSoundFileType)
		else
			self:EmitSound(self.PrimarySound)
		end
		
		if self.Chargeable then
			self:SetCharge(self:GetCharge()-self.ChargeTake)
		end
		
		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
		self.idledelay = CurTime() + self:SequenceDuration()
		
		--self:Recoil()
end

function SWEP:SecondaryAttack()
	--[[local seqs = self:GetSequenceList()
	
	for k, v in ipairs(seqs) do
		print(v.." = "..self:GetSequenceActivityName(self:LookupSequence(v)))
	end]]
end
