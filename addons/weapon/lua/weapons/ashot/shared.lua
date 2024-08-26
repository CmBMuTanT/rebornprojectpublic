
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
	["laser_sight"] = {
		bone = "ashot_body",
		pos = Vector(0.9, -1, -2), 
		ang = Angle(-90, 0, 90),
		size = 0.5
	},
	["ashot_handguard"] = {
		default = false,
		IronsightPos = Vector(-1.601, -2, 0.28),--Vector(-4.1, -4, 1.09)
		IronsightAng = Vector(0, 0.865, 0)
	},
	["ashot_priklad"] = {
		default = false,
		IronsightPos = Vector(-2.11, 0, 1.1),--Vector(-4.1, -4, 1.09)
		IronsightAng = Vector(0, 0.865, 0)
	},
	["revolver_silencer"] = {
		bone = "ashot_roll",
		pos = Vector(-1.05, 9, 0.25), 
		ang = Angle(180, 90, 0),
		size = 1
	}
}

SWEP.UseMagBulletsBodyroup = false
SWEP.MagBulletsBodyroup = 10
SWEP.ZatvorBone = "pkm_zatvor"
SWEP.UseZatvorBone = false

SWEP.EmptyReload = false
SWEP.ChamberedRound = false

SWEP.GaySightAttack = false

SWEP.AnimOverrides = {
	["handguard"] = {
		["fire"] = ACT_VM_HITLEFT2,
		["draw"] = ACT_VM_PULLBACK_LOW,
		["reload"] = ACT_VM_RECOIL2,
		["reload_empty"] = ACT_VM_RECOIL3,
		["holster"] = ACT_VM_SWINGHARD,
		["idle"] = ACT_VM_IDLE_LOWERED
	},
	["priklad"] = {
		["fire"] = ACT_VM_HITRIGHT2,
		["draw"] = ACT_VM_PULLBACK_HIGH,
		["reload"] = ACT_VM_ATTACH_SILENCER,
		["reload_empty"] = ACT_VM_DETACH_SILENCER,
		["holster"] = ACT_VM_SWINGMISS,
		["idle"] = ACT_VM_IDLE_TO_LOWERED
	}
}

SWEP.OverrideAnims = "default"

SWEP.DefaultAnims = {
	["fire"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["reload"] = ACT_VM_RELOAD,
	["reload_empty"] = ACT_VM_RECOIL1,
	["holster"] = ACT_VM_HOLSTER,
	["idle"] = ACT_IDLE
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Ашот"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/ashot/v_ashot.mdl"--"models/cw2/rifles/ak74.mdl"--
SWEP.WorldModel		= "models/w_weapons/w_ashot.mdl"

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
--SWEP.IronsightPos = Vector(-2.651, -2, 1.049)
--SWEP.IronsightAng = Vector(-0.5, 0, 0)

SWEP.IronsightPos = Vector(-1.601, -2, 0.28)
SWEP.IronsightAng = Vector(0, 0.865, 0)

SWEP.IronsightZoom = 20

SWEP.RunPos = Vector(1.475, -2.396, -0.369)
SWEP.RunAng = Vector(-10.323, 24.516, -9.678)

SWEP.ReloadBobMul	= 1

SWEP.HoldType		= "revolver"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 1.5
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 6
SWEP.Primary.Cone			= 0.5

SWEP.Primary.Delay			= 0.1
SWEP.Slot    = 1
SWEP.SlotPos = 1
SWEP.Primary.ClipSize		= 1 ---1
SWEP.Primary.DefaultClip	= 30 ---1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "metro_shotgun"

SWEP.UseHands = false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.PrimarySound			= "weapons/ubo_1.mp3"

SWEP.SilencedSound	= "weapons/ashot_shoot_s_1.wav"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

SWEP.VecticalRecoil = 1
SWEP.HorisontalRecoil = 0.5

SWEP.SwayScale			= 0.0		
SWEP.BobScale			= 0.0	

