
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
	["scope2"] = {
		bone = "preved_base",
		pos = Vector(-0.045, -5.2, 7.5), 
		ang = Angle(180, -90, 0),
		size = 1,
		IronsightPos = Vector(-3.1, 3, 0.6),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka3"
	},
	["scope_optics"] = {
		bone = "preved_base",
		pos = Vector(-0.045, -4.4, 4), 
		ang = Angle(90, -90, 0),
		size = 1,
		IronsightPos = Vector(-3.1, 3, 0.57),
		IronsightAng = Vector(0, 0, 0)
	},
	["mag_preved_default"] = { default = true },
	["mag_preved"] = { default = false },
	["planka3"] = {
		bone = "preved_base",
		pos = Vector(0, -3.74, 7.1), 
		ang = Angle(90, -90, 0),
		size = 1
	}
}

SWEP.ZatvorBone = "kalash_zatvor"
SWEP.UseZatvorBone = false

SWEP.UseMagBulletsBodyroup = false
SWEP.MagBulletsBodyroup = 6

SWEP.EmptyReload = false
SWEP.ChamberedRound = false
SWEP.AutoReload = true

SWEP.GaySightAttack = false

SWEP.SilentByDefault = false

SWEP.EffectShell = false

if ( CLIENT ) then
	
	--SWEP.ViewModelFOV = 50
	
end

SWEP.LastShot = true

SWEP.AnimOverrides = {	
	["drum"] = {
		["fire"] = ACT_VM_SECONDARYATTACK,
		["fire_last"] = ACT_VM_PRIMARYATTACK,
		["draw"] = ACT_VM_DRAW,
		["reload"] = ACT_VM_MISSLEFT,
		["reload_empty"] = ACT_VM_MISSRIGHT,
		["holster"] = ACT_VM_HOLSTER,
		["idle"] = ACT_IDLE
	}
}
SWEP.OverrideAnims = "default"

SWEP.DefaultAnims = {
	["fire"] = ACT_VM_PRIMARYATTACK,
	["fire_last"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["reload"] = ACT_VM_RELOAD,
	["reload_empty"] = ACT_VM_RELOAD,
	["holster"] = ACT_VM_HOLSTER,
	["idle"] = ACT_IDLE
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Превед"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/preved/v_preved.mdl"--"models/cw2/rifles/ak74.mdl"--"models/weapons/c_357.mdl"--
SWEP.WorldModel		= "models/w_weapons/w_preved.mdl"

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
SWEP.IronsightPos = Vector(-3.12, -2, 1.6)
SWEP.IronsightAng = Vector(0, 0, 0)
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
SWEP.ReloadAmmoDelay = 1.4

SWEP.HoldType		= "ar2"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 5

SWEP.Primary.Damage			= 200 
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.2

SWEP.Primary.Delay			= 0.6--1.5

SWEP.Primary.ClipSize		= 1 ---1
SWEP.Primary.DefaultClip	= 5 ---1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "metro_sniper"

SWEP.UseHands = false
SWEP.Slot    = 4
SWEP.SlotPos = 4
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.RandomPrimarySound		= false
SWEP.PrimarySound			= "weapons/preved/preved_base_shot.wav"

SWEP.RandomSilSound			= true
SWEP.MaxRandomSilSound		= 3
SWEP.SilencedSound	= "weapons/gold_shoot_sil_0.mp3"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

SWEP.Penetration = true

