SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
}

SWEP.UseZatvorBone = false

SWEP.UseMagBulletsBodyroup = false

SWEP.EmptyReload = true
SWEP.ChamberedRound = false

SWEP.GaySightAttack = false

SWEP.SilentByDefault = false

SWEP.EffectShell = true

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Stallion"
SWEP.Author			= "naimina7"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/metro/weapons/stallion/v_stallion.mdl"
SWEP.WorldModel		= "models/w_weapons/w_padonak.mdl"

SWEP.IronsightPos = Vector(-1.67, 0, 1.159)
SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.IronsightZoom = 20
SWEP.SightsConeMul = 0.5

SWEP.RunPos = Vector(1.475, -2.396, -0.369)
SWEP.RunAng = Vector(-10.323, 24.516, -9.678)

SWEP.ReloadBobMul	= 1
SWEP.ReloadAmmoDelay = 0.7

SWEP.HoldType		= "revolver"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 1

SWEP.Primary.Damage			= 22  
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.3

SWEP.Primary.Delay			= 0.15

SWEP.Primary.ClipSize		= 15 ---1
SWEP.Primary.DefaultClip	= 15 ---1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "metro_pistol"

SWEP.UseHands = false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.RandomPrimarySound		= false
SWEP.PrimarySound			= "weapons/vsv/vsv_1.mp3"

SWEP.RandomSilSound			= false
SWEP.SilencedSound	= "weapons/gold_shoot_sil_0.mp3"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

--SWEP.Penetration = true

function SWEP:OnDeploy()

end
