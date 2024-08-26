
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
    ["scope2"] = {
		bone = "hellsing_body",
		pos = Vector(0, -3.7 , 4), 
		ang = Angle(180, -90, 0),
		size = 1,
		IronsightPos = Vector(-2.4, 1, -1.13),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka2"
	},
	["planka2"] = {
		bone = "hellsing_body",
		pos = Vector(0, -2.6, 3), 
		ang = Angle(90, -90, 0),
		size = 1
	},
	["hellsing_pneumo"] = { default = false },
	["scope_optics"] = {
		bone = "hellsing_body",
		pos = Vector(-0, -3.35, -1), 
		ang = Angle(90, 0, -90),
		size = 0.7,
		IronsightPos = Vector(-2.4, 3, -1.35),
		IronsightAng = Vector(0, 0, 0)
	}
}

SWEP.UseMagBulletsBodyroup = true
SWEP.MagBulletsBodyroup = 6
--SWEP.MagGroupOffset = -1

SWEP.ZatvorBone = "kalash_zatvor"
SWEP.UseZatvorBone = false

SWEP.EmptyReload = false
SWEP.ChamberedRound = false

SWEP.MagGroupOffset = 0
SWEP.ReloadAmmoDelay = 1

SWEP.Chargeable = true
SWEP.ChargeTake = 3
SWEP.ChargeAdd = 10
SWEP.ChargeStrelkaBone = "hellsing_barometr"
SWEP.ChargeStrelkaUseScale = true

SWEP.ProjectileBasicForce = 1500
SWEP.ProjectileChargedForce = 550
SWEP.ProjectileGravity = -5

SWEP.ChargeStrelkaMul = 2.7
SWEP.StrelkaOffset = 0

SWEP.UseProjectiles = true

SWEP.ChargeInSound = "weapons/tikhar_pump_in.mp3"
SWEP.ChargeOutSound = "weapons/tikhar_pump_out.mp3"

SWEP.PumpSound = "weapons/tikhar_pump_0.mp3"
SWEP.PumpHardSound = "weapons/tikhar_pump_0.mp3"

SWEP.GaySightAttack = true

SWEP.SilentByDefault = true

SWEP.EffectShell = false

SWEP.Projectile = "metro_arrow"

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
	["pump2"] = ACT_VM_HITRIGHT,
	["pump_finish"] = ACT_VM_HITRIGHT2
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Хельсинг"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/hellsing/v_hellsing.mdl"
SWEP.WorldModel		= "models/w_weapons/w_hellsing.mdl"

SWEP.IronsightPos = Vector(-2.385, 0, 0)
SWEP.IronsightAng = Vector(0, 0, 0)

--SWEP.IronsightPos = Vector(-2.488, -6.125, -8.23)
--SWEP.IronsightAng = Vector(28.804, 0.67, -2.01)

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

SWEP.Primary.Recoil			= 2

SWEP.Primary.Damage			= 80
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.1

SWEP.Primary.Delay			= 0.3

SWEP.Primary.ClipSize		= 8 ---1
SWEP.Primary.DefaultClip	= 16 ---1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "metro_arrow"
SWEP.Slot    = 5
SWEP.SlotPos = 5
SWEP.UseHands = false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.PrimarySound			= "weapons/arrow/helsing_shoot_0.wav"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

local drum_bone = nil


local drumroll = Angle(0, 0, 0)
local drmrltmp = Angle(0, 0, 0)

function SWEP:GetDrumBone()
	if drum_bone == nil then
		local vm = self.Owner:GetViewModel()
		drum_bone = vm:LookupBone("hellsing_roll")
	end
	return drum_bone
end

function SWEP:RollDrum()
--	drumroll = Angle(0, 0, 0)
	drmrltmp = drumroll + Angle(0, 45, 0)
end

function SWEP:ResetDrum()
	local vm = self.Owner:GetViewModel()
	local drum = self:GetDrumBone()
	vm:ManipulateBoneAngles(drum, Angle(0, 0, 0))
	drumroll = Angle(0, 0, 0)
	drmrltmp = drumroll
end

function SWEP:SecondThink()

	local vm = self.Owner:GetViewModel()
	
	if CLIENT then
		
		local drum = self:GetDrumBone()
		--local cur_shell = vm:LookupBone("uboinik_bullet_2")
		
		drmrltmp = Angle(0, 45*self:Clip1(), 0)
		
		drumroll = LerpAngle(FrameTime()*6, drumroll, drmrltmp)
		
		vm:ManipulateBoneAngles(drum, drumroll)
		
	end
	
end

function SWEP:PrimaryAttack()
	if not IsValid(self.Owner) or self.Owner:Health() < 0 or !self:CanPrimaryAttack() or self:GetRunning() or self:GetNextReload() > CurTime() or (self.Chargeable and self:GetCharge() <= 0) then 
	return 
	end
	
		self.SightsConeMul = math.Clamp(self.SightsConeMul, 0, 1)
	
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
		self.idledelay = CurTime() + self:SequenceDuration()
		
		--self:CallOnClient("RollDrum", "1")
		self:Recoil()
end

function SWEP:OnReload()

	timer.Simple( self.ReloadAmmoDelay, function() 
		self:CallOnClient("ResetDrum", "")
	end)
	
end
