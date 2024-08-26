
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {

	["scope1"] = {
		bone = "bastard_base",
		pos = Vector(0.02, -4.1, 2), 
		ang = Angle(0, 0, -90),
		size = 1,
		IronsightPos = Vector(-4.9, -5, 0.48),
		IronsightAng = Vector(-0.5, 0, 0),
		second_attachment = "planka1"
	},
	["scope2"] = {
		bone = "bastard_base",
		pos = Vector(-0.02, -4.6, 3), 
		ang = Angle(180, -90, 0),
		size = 1,
		IronsightPos = Vector(-4.92, -2, 0.2),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka1"
	},
	["scope3"] = {
		bone = "bastard_base",
		pos = Vector(-0.04, -4.7, 2), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-4.9, -5, 0.2),
		IronsightAng = Vector(-0.5, 0, 0),
		second_attachment = "planka1"
	},
	["nv_scope"] = {
		bone = "bastard_base",
		pos = Vector(0, -4.7, 4), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-4.9, -5, 0.15),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka1"
	},
	["planka1"] = {
		bone = "bastard_base",
		pos = Vector(0.34, -2, 2.5), 
		ang = Angle(90, -90, 0),
		size = 1.4
	},
	["default_silencer"] = {
		bone = "bastard_base",
		pos = Vector(0.1, -1.75, 28), 
		ang = Angle(90, 0, 0),
		size = 1
	},
	["laser_sight"] = {
		bone = "bastard_base",
		pos = Vector(1.5, -2, 10), 
		ang = Angle(90, 15, -90),
		size = 1.1
	},
	["bastard_ohladitel"] = { 
		bone = "bastard_base",
		pos = Vector(0, -1.701, 20), 
		ang = Angle(90, 0, 0),
		size = 1
	}

}

SWEP.ZatvorBone = "bastard_zatvor"
SWEP.UseZatvorBone = true

SWEP.EmptyReload = true
SWEP.ChamberedRound = false

SWEP.MagBulletsBodyroup = 5
SWEP.ReloadAmmoDelay = 0.5

--SWEP.ShellTexture = "effects/animated/animated_gilza_3"

SWEP.GaySightAttack = true

if ( CLIENT ) then
	
	--SWEP.ViewModelFOV = 50
	
end

SWEP.AnimOverrides = {	
	["drum"] = {
		["fire"] = ACT_VM_PRIMARYATTACK,
		["draw"] = ACT_VM_DRAW,
		["reload"] = ACT_VM_RECOIL3,
		["reload_empty"] = ACT_VM_RECOIL2,
		["holster"] = ACT_VM_HOLSTER
	}
}
SWEP.OverrideAnims = "default"

SWEP.DefaultAnims = {
	["fire"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["reload"] = ACT_VM_RELOAD,
	["reload_empty"] = ACT_VM_RELOAD_EMPTY,
	["holster"] = ACT_VM_HOLSTER,
	["klin"] = ACT_VM_RECOIL3,
	["idle"] = ACT_VM_IDLE
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Ублюдок"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/bastard/v_bastard.mdl"--"models/cw2/rifles/ak74.mdl"--"models/weapons/c_357.mdl"--
SWEP.WorldModel		= "models/w_weapons/w_bastard.mdl"

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
SWEP.IronsightPos = Vector(-4.875, -5, 1.81)
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

SWEP.HoldType		= "ar2"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 1

SWEP.Primary.Damage			= 24
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.3

SWEP.Primary.Delay			= 0.1

SWEP.Primary.ClipSize		= 30 ---1
SWEP.Primary.DefaultClip	= 130 ---1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "metro_avtomat"
SWEP.Slot    = 3
SWEP.SlotPos = 3
SWEP.UseHands = false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.RandomPrimarySound		= true
SWEP.MaxRandomSound			= 6
SWEP.RandomSoundFileType	= ".mp3"
SWEP.PrimarySound			= "weapons/ubl/aka"

SWEP.RandomSilSound			= true
SWEP.MaxRandomSilSound		= 3
SWEP.SilencedSound	= "weapons/2012_shoot_sil"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"



local steam = 0
local steamshit = 0

local emitter = nil

local MagPos = Vector(0,0,0)

local Up = true
local upvar = 0

local mag_bone = nil
local shit_bone = nil

function SWEP:GetMagBone()
	if mag_bone == nil then
		local vm = self.Owner:GetViewModel()
		mag_bone = vm:LookupBone("bastard_mag_1")
	end
	return mag_bone
end

function SWEP:GetShitBone()
	if shit_bone == nil then
		local vm = self.Owner:GetViewModel()
		shit_bone = vm:LookupBone("bastard_mag_1_dop")
	end
	return shit_bone
end

function SWEP:BastardMagShit()
	local vm = self.Owner:GetViewModel()
	--print(vm:LookupBone("bastard_mag_1_dop"))
	--MagPos.x = MagPos.x - 0.25
	if Up then
		upvar = 0.35
	else
		upvar = 0
	end
	Up = !Up
	--vm:ManipulateBonePosition( 52, MagPos )
	--self:StartSteamEffect()
	
end

function SWEP:ResetMagPos()
	Up = false
	upvar = 0
	MagPos = Vector(0,0,0)
	local vm = self.Owner:GetViewModel()
	vm:ManipulateBonePosition( self:GetMagBone(), Vector(0, 0, 0) )
	vm:ManipulateBonePosition( self:GetShitBone(), Vector(0, 0, 0) )
end

local next_sound = 0

function SWEP:StartSteamEffect(duration)

	local vm = self.Owner:GetViewModel()
	local att = vm:GetAttachment(1)
	
	if emitter == nil then
		emitter = ParticleEmitter(att.Pos)
	end
	
	steam = CurTime() + tonumber(duration)

end

local uppp = 0
local magdelay = 0

SWEP.OverHeat = 0
SWEP.NxtOverHeat = 0

function SWEP:SecondThink()

	local vm = self.Owner:GetViewModel()
	
	if CLIENT then
		
		local att = vm:GetAttachment(1)
		
		if steam > CurTime() then
		
			local particle = emitter:Add( "particle/particle_noisesphere", att.Pos + att.Ang:Forward() * -20 + att.Ang:Right() * -4 )
			particle:SetVelocity( 1 * VectorRand() )
			particle:SetAirResistance( 400 )
			particle:SetGravity( Vector(0, 0, math.Rand(100, 200) ) + att.Ang:Right() * -100 )
			particle:SetDieTime( 0.5 )
			particle:SetStartAlpha( math.Rand( 1, 6 ) )
			particle:SetEndAlpha( 0 )
			
			particle:SetStartSize(1)
			particle:SetEndSize(6)
			
			particle:SetRoll( math.Rand( 0, 1 ) )
			particle:SetRollDelta( 0.1 )	
				
		end
		
		--if steam > CurTime() and next_sound <= CurTime() then
		--	self.Owner:EmitSound("weapons/ubl_steam.wav")
		--	next_sound = CurTime() + 1
		--end
		--print(self:Clip1())
		--if self:Clip1() <= 0 then return end
		
		if magdelay < CurTime() then
			MagPos.x = (self:Clip1()*0.25)-7.5
		end
		
		uppp = Lerp(FrameTime()*25, uppp, upvar)
		MagPos.y = uppp
		
		vm:ManipulateBonePosition( self:GetMagBone(), MagPos )
		vm:ManipulateBonePosition( self:GetShitBone(), Vector(0, uppp, 0) )
	end
	
		if self:GetOverheat() > 0 and self.NxtOverHeat < CurTime() then
			self:SetOverheat(self:GetOverheat()-1)
			self.NxtOverHeat = CurTime() + 0.05
		end
		
		if self:GetOverheat() >= 20 then	
			self:SetOverheat(0)
			if SERVER then
				self:CallOnClient("StartSteamEffect", "2")
				timer.Simple( 0.5, function() 
					self.Owner:EmitSound("weapons/ubl_broken_1.mp3") 
				end)
			end
			self:PlayAnim("klin")
			self.Weapon:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() )
			self.Weapon:SetNextSecondaryFire( CurTime() + vm:SequenceDuration() )
			--self.idledelay = CurTime() + self:SequenceDuration()
			self:SetRunning(false)
			self:SetNextReload( CurTime() + vm:SequenceDuration() )
		end
	
end

function SWEP:OnReload()

	if CLIENT then
		if self:Clip1() <= 0 then
			self:ResetMagPos()
			magdelay = CurTime() + 10
		else
			timer.Simple( self.ReloadAmmoDelay, function() 
				self:ResetMagPos()
			end)
		end
	end
	
end

function SWEP:PrimaryAttack()
	if not IsValid(self.Owner) or self.Owner:Health() < 0 or !self:CanPrimaryAttack() or self:GetRunning() or self:GetNextReload() > CurTime() or (self.Chargeable and self:GetCharge() <= 0) then 
	return 
	end
		--if !IsFirstTimePredicted() then return end
		self.SightsConeMul = math.Clamp(self.SightsConeMul, 0, 1)
	
		if CLIENT then
			magdelay = 0
		end
	
		self:CallOnClient("BastardMagShit", "1")
		--self:CallOnClient("StartSteamEffect", "2")
		if self.SpecialBool == false then
			self:SetOverheat(self:GetOverheat()+1)
			self.NxtOverHeat = CurTime() + 0.15
		end
		
		if self:GetAimBool() then
			if self.GaySightAttack then
				self:CallOnClient("GayAttack", "1")
			else
				self:PlayAnim("fire")
			end
			self:ShootBullet(self.Primary.Damage, self.Primary.NumShots*self.Primary.TakeAmmo, self.Primary.Cone*self.SightsConeMul)
		else
			self:PlayAnim("fire")
			self:ShootBullet(self.Primary.Damage, self.Primary.NumShots*self.Primary.TakeAmmo, self.Primary.Cone)
		end
		
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		
		self:Muzzle()
		
		if SERVER then
			if self:GetSilencer() then
				if self.RandomSilSound then
					self.Owner:EmitSound(self.SilencedSound.."_"..math.random(1, self.MaxRandomSilSound)..self.RandomSoundFileType)
				else
					self.Owner:EmitSound(self.SilencedSound)
				end
			else
				if self.RandomPrimarySound then
					self.Owner:EmitSound(self.PrimarySound.."_"..math.random(1, self.MaxRandomSound)..self.RandomSoundFileType)
				else
					self.Owner:EmitSound(self.PrimarySound)
				end
			end
		end
		
		if self.Chargeable then
			self:SetCharge(self:GetCharge()-self.ChargeTake)
		end
		
		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
		
		self:Recoil()
end

print("bastard")
