
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {

	["scope1"] = {
		bone = "kalash_base",
		pos = Vector(0.02, -2.7, 4), 
		ang = Angle(0, 0, -90),
		size = 1,
		IronsightPos = Vector(-2.651, 1, 0.6),
		IronsightAng = Vector(-0.5, 0, 0)
	},
	["scope2"] = {
		bone = "kalash_base",
		pos = Vector(0, -3.6, 4), 
		ang = Angle(180, -90, 0),
		size = 1,
		IronsightPos = Vector(-2.641, 1, 0.0),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka1"
	},
	["scope3"] = {
		bone = "kalash_base",
		pos = Vector(0, -3.8, 3), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-2.651, 1, -0.2),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka1"
	},
	["nv_scope"] = {
		bone = "kalash_base",
		pos = Vector(0, -3.7, 4), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-2.651, 1, -0.09),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka1"
	},
	["planka1"] = {
		bone = "kalash_base",
		pos = Vector(0.34, -1.201, 3.4), 
		ang = Angle(90, -90, 0),
		size = 1.2
	},
	["default_silencer"] = {
		bone = "kalash_base",
		pos = Vector(0, -0.7, 30), 
		ang = Angle(90, 0, 0),
		size = 1
	},
	["mag1"] = {
		default = true
	},
	["mag2"] = {
		default = false
	},
	["mag3"] = {
		default = false
	},
	["laser_sight"] = {
		bone = "kalash_base",
		pos = Vector(1.2, -1, 15), 
		ang = Angle(90, 15, -90),
		size = 1.1
	},
	["laser_sight_rainbow"] = {
		bone = "kalash_base",
		pos = Vector(1.2, -1, 15), 
		ang = Angle(90, 15, -90),
		size = 1.1
	}

}

SWEP.ZatvorBone = "kalash_zatvor"
SWEP.UseZatvorBone = true

SWEP.EmptyReload = true
SWEP.ChamberedRound = true

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
		["holster"] = ACT_VM_HOLSTER,
		["idle"] = ACT_VM_IDLE
	}
}
SWEP.OverrideAnims = "default"

SWEP.DefaultAnims = {
	["fire"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["reload"] = ACT_VM_RELOAD,
	["reload_empty"] = ACT_VM_RELOAD_EMPTY,
	["holster"] = ACT_VM_HOLSTER,
	["idle"] = ACT_VM_IDLE
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "AK74"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/ak_74/v_ak_74.mdl"
SWEP.WorldModel		= "models/w_weapons/w_ak_74.mdl"

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
SWEP.IronsightPos = Vector(-2.65, -2, 1.049)
SWEP.IronsightAng = Vector(-0.3, 0, 0)
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

SWEP.Primary.Damage			= 30 
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.2

SWEP.Primary.Delay			= 0.1

SWEP.Primary.ClipSize		= 30 ---1
SWEP.Primary.DefaultClip	= 30 ---1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "metro_avtomat"

SWEP.UseHands = false
SWEP.Slot    = 3
SWEP.SlotPos = 3
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.RandomPrimarySound		= false
SWEP.MaxRandomSound			= 3
SWEP.RandomSoundFileType	= ".mp3"
SWEP.PrimarySound			= "weapons/ak_boom_shot_2.mp3"

SWEP.RandomSilSound			= true
SWEP.MaxRandomSilSound		= 3
SWEP.SilencedSound	= "weapons/2012_shoot_sil"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"


function SWEP:OnDeploy()

end
