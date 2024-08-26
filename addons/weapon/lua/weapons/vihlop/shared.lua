
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
	["scope_optics"] = {
		bone = "vihlop_body",
		pos = Vector(-0.045, -3.201, -4), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.64, 3, -0.53),
		IronsightAng = Vector(0, 0, 0)
	},
	["laser_sight"] = {
		bone = "vihlop_body",
		pos = Vector(1.2, -0.5, -1), 
		ang = Angle(90, 0, -90),
		size = 1
	},
	["scope2"] = {
		bone = "vihlop_body",
		pos = Vector(-0.045, -4, -0.7), 
		ang = Angle(180, -90, 0),
		size = 1,
		IronsightPos = Vector(-3.64, 3, -0.48),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka3"
	},
	["planka3"] = {
		bone = "vihlop_body",
		pos = Vector(0, -2.575, -0.9), 
		ang = Angle(90, -90, 0),
		size = 1
	}
}

SWEP.ZatvorBone = "kalash_zatvor"
SWEP.UseZatvorBone = false

SWEP.EmptyReload = true
SWEP.ChamberedRound = true

SWEP.GaySightAttack = true

SWEP.SilentByDefault = true

SWEP.EffectShell = false

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

SWEP.PrintName		= "Выхлоп"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/vihlop/v_vihlop.mdl"--"models/cw2/rifles/ak74.mdl"--"models/weapons/c_357.mdl"--
SWEP.WorldModel		= "models/w_weapons/w_vihlop.mdl"

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
SWEP.IronsightPos = Vector(-3.641, -5, 0.5)
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
SWEP.ReloadAmmoDelay = 1.2

SWEP.HoldType		= "ar2"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 8

SWEP.Primary.Damage			= 160  
SWEP.Primary.Force			= 25
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.2

SWEP.Primary.Delay			= 0.9

SWEP.Primary.ClipSize		= 5 ---1
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

SWEP.RandomPrimarySound		= true
SWEP.MaxRandomSound			= 3
SWEP.RandomSoundFileType	= ".mp3"
SWEP.PrimarySound			= "weapons/gold_shoot_sil"

SWEP.RandomSilSound			= true
SWEP.MaxRandomSilSound		= 3
SWEP.SilencedSound	= "weapons/gold_shoot_sil_0.mp3"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

SWEP.Penetration = true

