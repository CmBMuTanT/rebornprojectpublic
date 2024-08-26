
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
	["tihar_scope"] = {
		bone = "tihar_bone",
		pos = Vector(-0.03, -3.8, 1.5),  
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.08, 1, -0.5),
		IronsightAng = Vector(-0.5, 0, 0),
		second_attachment = "planka2"
	},
	["scope3"] = {
		bone = "tihar_bone",
		pos = Vector(-0.03, -4.4, 2),  
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.05, -2, -0.3),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka2"
	},
	["scope2"] = {
		bone = "tihar_bone",
		pos = Vector(-0.03, -4.3, 4), 
		ang = Angle(180, -90, 0),
		size = 1,
		IronsightPos = Vector(-3.1, 1, -0.24),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka2"
	},
	["scope_optics"] = {
		bone = "tihar_bone",
		pos = Vector(-0.2, -4.3, 6), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.25, 0, -1.1),
		IronsightAng = Vector(0, 0, 0)
	},
	["planka2"] = {
		bone = "tihar_bone",
		pos = Vector(-0.03, -3.2, 2.2), 
		ang = Angle(90, -90, 0),
		size = 1.2
	},
	["laser_sight"] = {
		bone = "tihar_bone",
		pos = Vector(1.2, -1, 9), 
		ang = Angle(90, 15, -90),
		size = 1.1
	}
	--["abzats_autofire"] = {default = false}
}

SWEP.ZatvorBone = "kalash_zatvor"
SWEP.UseZatvorBone = false

SWEP.EmptyReload = false
SWEP.ChamberedRound = false

SWEP.MagGroupOffset = 2
SWEP.ReloadAmmoDelay = 2

SWEP.Chargeable = true
SWEP.ChargeTake = 3
SWEP.ChargeAdd = 5
SWEP.ChargeStrelkaBone = "tihar_strelka_1"

SWEP.ChargeStrelkaMul = 2.7
SWEP.StrelkaOffset = 0

SWEP.UseProjectiles = true

SWEP.ChargeInSound = "weapons/tikhar_pump_in.mp3"
SWEP.ChargeOutSound = "weapons/tikhar_pump_out.mp3"

SWEP.PumpSound = "weapons/tikhar_pump_0.mp3"
SWEP.PumpHardSound = "weapons/tikhar_pump_2_0.mp3"

SWEP.GaySightAttack = true

SWEP.SilentByDefault = true

SWEP.EffectShell = false

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
	["pump_start"] = ACT_VM_HITLEFT2,
	["pump"] = ACT_VM_HITRIGHT,
	["pump2"] = ACT_VM_HITRIGHT2,
	["pump_finish"] = ACT_VM_HITCENTER
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Тихарь"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/tihar/v_tihar.mdl"--"models/cw2/rifles/ak74.mdl"--"models/weapons/c_357.mdl"--
SWEP.WorldModel		= "models/w_weapons/w_tihar.mdl"

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
SWEP.IronsightPos = Vector(-3.08, -4, 0.73)
SWEP.IronsightAng = Vector(-0.5, 0, 0)
--SWEP.IronsightPos = Vector(-2.651, -2, 0.6)
--SWEP.IronsightAng = Vector(-0.5, 0, 0)
SWEP.IronsightZoom = 20
SWEP.SightsConeMul = 0.5

SWEP.RunPos = Vector(1.475, -2.396, -0.369)
SWEP.RunAng = Vector(-10.323, 24.516, -9.678)

--SWEP.AttPos = Vector(4.421, -7.84, -2.412)
--SWEP.AttAng = Vector(33.769, 23.92, 14.774)
SWEP.AttPos = Vector(4.609, -7.391, -1.305)
SWEP.AttAng = Vector(32.564, 44.13, 22.826)

SWEP.ReloadBobMul	= 1

SWEP.HoldType		= "ar2"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 1

SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.2

SWEP.Primary.Delay			= 0.25

SWEP.Primary.ClipSize		= 15 ---1
SWEP.Primary.DefaultClip	= 30 ---1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "metro_shariki"
SWEP.Slot    = 5
SWEP.SlotPos = 5
SWEP.UseHands = false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.PrimarySound			= "weapons/tikhar_shoot_2_0.mp3"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"


