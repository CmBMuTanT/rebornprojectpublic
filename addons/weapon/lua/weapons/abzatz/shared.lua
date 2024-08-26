
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
    ["mag_abzats"] = {
		default = true
	},
	["mag_abzats_ex"] = {
		default = false
	},
	["abzats_compensator"] = {
		bone = "abzats_body",
		pos = Vector(-0.12, -1, 37), 
		ang = Angle(90, 0, 0),
		size = 1.0
	},
	["abzats_autofire"] = {
		bone = "abzats_body",
		pos = Vector(-0.12, -2.7, -0.3), 
		ang = Angle(90, 0, 0),
		size = 1.1
	},
    ["laser_sight"] = {
		bone = "abzats_body",
		pos = Vector(1.2, -1, 15), 
		ang = Angle(90, 15, -90),
		size = 1.1
	}
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

SWEP.AnimOverrides = {	
	["drum"] = {
		["fire"] = ACT_VM_PRIMARYATTACK,
		["draw"] = ACT_VM_DRAW,
		["reload"] = ACT_VM_RELOAD,
		["reload_empty"] = ACT_VM_RELOAD_EMPTY,
		["holster"] = ACT_VM_HOLSTER,
		["klin"] = ACT_VM_HITLEFT2
	}
}
SWEP.OverrideAnims = "default"

SWEP.DefaultAnims = {
	["fire"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["reload"] = ACT_VM_RELOAD,
	["reload_empty"] = ACT_VM_RELOAD_EMPTY,
	["holster"] = ACT_VM_HOLSTER,
	["klin"] = ACT_VM_HITLEFT2
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Абзац"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/abzats/v_abzats.mdl"--"models/cw2/rifles/ak74.mdl"--"models/weapons/c_357.mdl"--
SWEP.WorldModel		= "models/w_weapons/w_abzats.mdl"

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

SWEP.HoldType		= "shotgun"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.BulletDistance			= 700

SWEP.Primary.Recoil			= 3

SWEP.Primary.Damage			= 25
SWEP.Primary.NumShots		= 4
SWEP.Primary.Cone			= 0.5
SWEP.Primary.Force			= 3

SWEP.Primary.Delay			= 0.2

SWEP.Primary.ClipSize		= 20 ---1
SWEP.Primary.DefaultClip	= 40 ---1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "metro_shotgun"

SWEP.UseHands = false
SWEP.Slot    = 2
SWEP.SlotPos = 2
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.RandomPrimarySound		= false
SWEP.MaxRandomSound			= 3
SWEP.RandomSoundFileType	= ".mp3"
SWEP.PrimarySound			= "weapons/ubo_1.mp3"

SWEP.RandomSilSound			= false
SWEP.MaxRandomSilSound		= 3
SWEP.SilencedSound	= "weapons/ubo_1.mp3"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

function SWEP:SetupDataTables()

	self:NetworkVar( "Bool", 1, "AimBool" )
	self:NetworkVar( "Float", 1, "NextReload" )
	self:NetworkVar( "Bool", 2, "Holster" )
	self:NetworkVar( "Float", 2, "Charge" )
	self:NetworkVar( "Bool", 3, "Running" )
	self:NetworkVar( "Bool", 4, "Silencer" )
	self:NetworkVar( "Float", 3, "Recoil" )
	self:NetworkVar( "Float", 4, "Overheat" )
	
	self:NetworkVar( "Float", 5, "HolsterDelay" )
	self:NetworkVar( "Bool", 5, "Deployed" )
	self:NetworkVar( "Bool", 6, "Charging" )
	self:NetworkVar( "Float", 6, "NxtPump" )
	
	self:NetworkVar( "Bool", 8, "Safe" )
	
	self:SetAimBool( false )
	self:SetNextReload( 0 )
	self:SetCharge( 100 )
	self:SetHolster( false )
	self:SetRunning( false )
	self:SetSilencer( false )
	self:SetRecoil( 0 )
	self:SetOverheat( 0 )
	
	self:SetHolsterDelay( 0 )
	self:SetDeployed( false )
	self:SetCharging( false )
	
	self:SetNxtPump( 0 )

	self:NetworkVar( "Float", 7, "Burst" )
	self:NetworkVar( "Bool", 7, "Bursting" )
	
	self:SetBurst(0)
	self:SetBursting(false)
	
	self:SetSafe( false )
	
end

SWEP.MagGroupClipOffset = 6

SWEP.Burst = 0
SWEP.Bursting = false

function SWEP:SecondThink()

	local vm = self.Owner:GetViewModel()
	
	--if !IsFirstTimePredicted() then return end
	
	if self:GetBursting() and self:Clip1() > 0 then
		if self:GetNextSecondaryFire() < CurTime() then
			if self:GetBurst() > 0 then
				self:PrimaryAttack()
				
				self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay*0.7 )
				self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay*0.8 )
				self:SetBurst(self:GetBurst()-1)
			else
				self:PlayAnim("klin")
				self.Weapon:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() )
				self.Weapon:SetNextSecondaryFire( CurTime() + vm:SequenceDuration() )
				self:SetRunning(false)
				self:SetNextReload( CurTime() + vm:SequenceDuration() )
				self:SetBursting(false)
			end
		end
	else
		self:SetBursting(false)
		self:SetBurst(0)
	end
	
end

function SWEP:SecondaryAttack()
	if not IsValid(self.Owner) or self.Owner:Health() < 0 or !self:CanPrimaryAttack() or self:GetRunning() or self:GetSafe() or self:GetNextReload() > CurTime() then return end
	
	--if SERVER then
	
		self:SetBurst(5)
		self:SetBursting(true)
	
	--end
	
end
