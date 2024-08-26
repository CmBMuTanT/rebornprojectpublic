
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
	["boomstick"] = {default = false},
	["longbarrel"] = {default = false},
	["shortbarrel"] = {default = false},
	["stock"] = {default = false}
}

SWEP.ZatvorBone = "pkm_zatvor"
SWEP.UseZatvorBone = false

SWEP.UseMagBulletsBodyroup = true
SWEP.MagBulletsBodyroup = 7

SWEP.EmptyReload = true
SWEP.ChamberedRound = false
SWEP.Ironsights = false
SWEP.GaySightAttack = false

SWEP.AttackSteps = 2

SWEP.AnimOverrides = {
    ["quad"] = {
        ["fire"] = ACT_VM_HITRIGHT,
        ["fire_2"] = ACT_VM_HITRIGHT2,
        ["fire_1"] = ACT_VM_HITCENTER,
        ["draw"] = ACT_VM_PULLBACK_LOW,
        ["reload"] = ACT_VM_RECOIL3,
        ["reload_empty"] = ACT_VM_RECOIL2,
        ["holster"] = ACT_VM_SWINGHARD,
		["idle"] = ACT_VM_IDLE_LOWERED
    }
}
    --["fire_1"] = ACT_VM_HITLEFT,
    --["fire_2"] = ACT_VM_HITLEFT2,
SWEP.OverrideAnims = "default"

SWEP.DefaultAnims = {
    ["fire"] = ACT_VM_PRIMARYATTACK,
    ["fire_2"] = ACT_VM_HITLEFT,
    ["fire_1"] = ACT_VM_HITLEFT2,
    ["draw"] = ACT_VM_DRAW,
    ["reload"] = ACT_VM_RECOIL1,
    ["reload_empty"] = ACT_VM_RELOAD,
    ["holster"] = ACT_VM_HOLSTER,
	["idle"] = ACT_IDLE
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Дуплет"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/duplet/v_duplet.mdl"--"models/cw2/rifles/ak74.mdl"--
SWEP.WorldModel		= "models/w_weapons/w_duplet.mdl"

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
--SWEP.IronsightPos = Vector(-2.651, -2, 1.049)
--SWEP.IronsightAng = Vector(-0.5, 0, 0)

SWEP.IronsightPos = Vector(-3.254, -2, 0.639)
SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.IronsightZoom = 20

SWEP.RunPos = Vector(1.475, -2.396, -0.369)
SWEP.RunAng = Vector(-10.323, 24.516, -9.678)

SWEP.ReloadBobMul	= 1

SWEP.HoldType		= "ar2"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 5.5
SWEP.Primary.Damage			= 16  
SWEP.Primary.NumShots		= 4
SWEP.Primary.Cone			= 0.7
SWEP.Primary.TakeAmmo		= 1

SWEP.Primary.Force			= 5

SWEP.Primary.Delay			= 0.2

SWEP.Primary.ClipSize		= 2 ---1
SWEP.Primary.DefaultClip	= 30 ---1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "metro_shotgun"

SWEP.UseHands = false
SWEP.Slot    = 2
SWEP.SlotPos = 2
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.PrimarySound			= "weapons/duplet_shoot_1.mp3"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

SWEP.VecticalRecoil = 1
SWEP.HorisontalRecoil = 0.5

SWEP.SwayScale			= 0.0		
SWEP.BobScale			= 0.0	



function SWEP:SecondaryAttack()
	if not IsValid(self.Owner) or self.Owner:Health() < 0 or !self:CanPrimaryAttack() or self:GetRunning() or self:GetNextReload() > CurTime() then return end
	
		self.SightsConeMul = math.Clamp(self.SightsConeMul, 0, 1)

		if SERVER then
			if self:GetAimBool() then
				self:ShootBullet(self.Primary.Damage, self.Primary.NumShots*self:Clip1(), self.Primary.Cone*self.SightsConeMul)
			else
				self:ShootBullet(self.Primary.Damage, self.Primary.NumShots*self:Clip1(), self.Primary.Cone)
			end
		end
		self:PlayAnim("fire")
		
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		
		if SERVER then self.Owner:EmitSound("weapons/duplet_double_shot.mp3") end

		self:TakePrimaryAmmo(self:Clip1())
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
		self.idledelay = CurTime() + self:SequenceDuration()
		
		self:Recoil()
end
