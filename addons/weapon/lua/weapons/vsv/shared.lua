
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {

     ["scope1"] = {
        bone = "vsv_base",
        pos = Vector(0.05, -3.45, 4.1), 
        ang = Angle(0, 0, -90),
        size = 1,
        IronsightPos = Vector(-3.13, -2, 0.2),
        IronsightAng = Vector(-0.5, 0, 0),
        second_attachment = "planka_vsv"
    },
	["scope2"] = {
		bone = "vsv_base",
		pos = Vector(0, -3.8, 4.1), 
		ang = Angle(180, -90, 0),
		size = 1,
		IronsightPos = Vector(-3.13, -2, 0.1),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka_vsv"
	},
	["scope3"] = {
		bone = "vsv_base",
		pos = Vector(0, -4, 2.9), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.13, -2, -0.1),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka_vsv"
	},
	["nv_scope"] = {
		bone = "vsv_base",
		pos = Vector(0, -3.9, 4.3), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.13, -2, 0),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka_vsv"
	},
	["planka_vsv"] = {
		bone = "vsv_base",
		pos = Vector(0.33, -2.1, 3.599), 
		ang = Angle(90, -90, 0),
		size = 1.1
	},
	["vsv_silencer"] = {
		bone = "vsv_base",
		pos = Vector(0.1, -1.6, 19.6), 
		ang = Angle(0, 0, 90),
		size = 1.1
	},
	["laser_sight"] = {
		bone = "vsv_base",
		pos = Vector(1.2, -1.2, 14), 
		ang = Angle(90, 0, -90),
		size = 1
	}

}

SWEP.ZatvorBone = "vsv_zatvor"
SWEP.UseZatvorBone = true

SWEP.EmptyReload = true
SWEP.ChamberedRound = true
SWEP.MagBulletsBodyroup = 3
SWEP.ReloadAmmoDelay = 0.8

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
	["holster"] = ACT_VM_HOLSTER
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "ВСВ"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/vsv/v_vsv.mdl"--"models/cw2/rifles/ak74.mdl"--"models/weapons/c_357.mdl"--
SWEP.WorldModel		= "models/w_weapons/w_vsv.mdl"

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
SWEP.IronsightPos = Vector(-3.150, -2, 1)
SWEP.IronsightAng = Vector(0, 0, 0)
--SWEP.IronsightPos = Vector(-2.651, -2, 0.6)
--SWEP.IronsightAng = Vector(-0.5, 0, 0)
SWEP.IronsightZoom = 20
SWEP.SightsConeMul = 0.5

SWEP.RunPos = Vector(0.475, -1.396, -0.369)
SWEP.RunAng = Vector(-10.323, 24.516, -9.678)

--SWEP.AttPos = Vector(4.421, -7.84, -2.412)
--SWEP.AttAng = Vector(33.769, 23.92, 14.774)
--SWEP.AttPos = Vector(4.609, -7.391, -1.305)
--SWEP.AttAng = Vector(32.564, 44.13, 22.826)

SWEP.InMenu = false

SWEP.ReloadBobMul	= 1

SWEP.HoldType		= "ar2"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 1

SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.2

SWEP.Primary.Delay			= 0.2

SWEP.Primary.ClipSize		= 20 ---1
SWEP.Primary.DefaultClip	= 20 ---1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "metro_avtomat"

SWEP.UseHands = false
SWEP.Slot    = 3
SWEP.SlotPos = 3
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.RandomPrimarySound		= true
SWEP.MaxRandomSound			= 6
SWEP.RandomSoundFileType	= ".mp3"
SWEP.PrimarySound			= "weapons/vsv/vsv"

SWEP.RandomSilSound			= true
SWEP.MaxRandomSilSound		= 3
SWEP.SilencedSound	= "weapons/2012_shoot_sil"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"
