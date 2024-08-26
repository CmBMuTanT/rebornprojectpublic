
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
	["revolver_barrel"] = {
		default = false,
		IronsightPos = Vector(-3.5, -1, 1.1),--Vector(-4.1, -4, 1.09)
		IronsightAng = Vector(0, 0, 0)
	},
	["revolver_grip"] = {
	    default = false,
	},
	["laser_sight"] = {
		bone = "revolver_Base",
		pos = Vector(0.8, -1.8, 4), 
		ang = Angle(90, 15, -90),
		size = 0.6
	},
	["scope1"] = {
		bone = "revolver_Base",
		pos = Vector(0.03, -3, 3),  
		ang = Angle(0, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.44, -1, 0.3),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka2",
		anim_sight_overrides = {
			["grip"] = {
				IronsightPos = Vector(-3.47, 1, 0.35),
				IronsightAng = Vector(0, 0, 0)			
			}
		}
	},
	["scope2"] = {
		bone = "revolver_Base",
		pos = Vector(-0.015, -3.65, 4), 
		ang = Angle(0, 90, 180),
		size = 1.1,
		IronsightPos = Vector(-3.46, -1, 0.0),
		IronsightAng = Vector(0, 0, 0),
		anim_sight_overrides = {
			["grip"] = {
				IronsightPos = Vector(-3.5, 1, 0.1),
				IronsightAng = Vector(0, 0, 0)			
			}
		}
	},
	["scope3"] = {
		bone = "revolver_Base",
		pos = Vector(-0.01, -3.5, 3),  
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.45, -1, 0.2),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka2",
		anim_sight_overrides = {
			["grip"] = {
				IronsightPos = Vector(-3.47, 1, 0.25),
				IronsightAng = Vector(0, 0, 0)			
			}
		}
	},
	["planka2"] = {
		bone = "revolver_Base",
		pos = Vector(-0.1, -2.5, 3.1), 
		ang = Angle(90, -90, 0),
		size = 1.0
	}
}

SWEP.ZatvorBone = "padonak_zatvor"
SWEP.UseZatvorBone = false

SWEP.UseMagBulletsBodyroup = false
SWEP.MagBulletsBodyroup = 10
SWEP.MaxMagGroup = 5

SWEP.EmptyReload = false
SWEP.ChamberedRound = false

SWEP.GaySightAttack = false

SWEP.SilentByDefault = false

SWEP.EffectShell = true

if ( CLIENT ) then
	
	--SWEP.ViewModelFOV = 50
	
end

SWEP.AnimOverrides = {	
	["grip"] = {
		["fire"] = ACT_VM_RECOIL2,
		["draw"] = ACT_VM_PULLBACK_HIGH,
		["reload"] = ACT_VM_HITLEFT,
		["holster"] = ACT_VM_THROW,
		["idle"] = ACT_VM_FIDGET
	}
}
SWEP.OverrideAnims = "default"

SWEP.DefaultAnims = {
	["fire"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["reload"] = ACT_VM_RELOAD,
	["holster"] = ACT_VM_HOLSTER,
	["idle"] = ACT_IDLE
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Револьер"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/revolver/v_revolver.mdl"--"models/cw2/rifles/ak74.mdl"--"models/weapons/c_357.mdl"--
SWEP.WorldModel		= "models/w_weapons/w_revolver.mdl"

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
SWEP.IronsightPos = Vector(-3.44, -1, 1.1)
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
SWEP.ReloadAmmoDelay = 1

SWEP.HoldType		= "revolver"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil			= 1

SWEP.Primary.Damage			= 20  
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.3

SWEP.Primary.Delay			= 0.35

SWEP.Primary.ClipSize		= 6 ---1
SWEP.Primary.DefaultClip	= 12 ---1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "metro_pistol"

SWEP.UseHands = false
SWEP.Slot    = 1
SWEP.SlotPos = 1
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.RandomPrimarySound		= false
SWEP.PrimarySound			= "weapons/revolver_shot_1.wav"

SWEP.RandomSilSound			= false
SWEP.SilencedSound	= "weapons/gold_shoot_sil_0.mp3"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

SWEP.Penetration = true


local drum_bone = nil

local drumroll = Angle(0, 0, 0)
local drmrltmp = Angle(0, 0, 0)

function SWEP:GetDrumBone()
	if drum_bone == nil then
		local vm = self.Owner:GetViewModel()
		drum_bone = vm:LookupBone("revolver_baraban_roll")
	end
	return drum_bone
end

function SWEP:SecondThink()

	if CLIENT and self:GetNextReload() < CurTime() then
		local vm = self.Owner:GetViewModel()
		local drum = self:GetDrumBone()
		
		--drmrltmp = Angle(64*self:Clip1(), 0, 0)
		
		drumroll = LerpAngle(FrameTime()*6, drumroll, drmrltmp)
		
		vm:ManipulateBoneAngles(drum, drumroll)
	end
	
end

function SWEP:RollDrum()
	drumroll = Angle(0, 0, 0)
	drmrltmp = drumroll - Angle(64, 0, 0)
end

function SWEP:ResetDrum()
	local vm = self.Owner:GetViewModel()
	local drum = self:GetDrumBone()
	drumroll = Angle(0, 0, 0)
	drmrltmp = drumroll
	vm:ManipulateBoneAngles(drum, Angle(0, 0, 0))
end

function SWEP:OnReload()

	--timer.Simple( self.ReloadAmmoDelay, function() 
	self:CallOnClient("ResetDrum", "")
	--end)
	
end

function SWEP:PrimaryAttack()
	if not IsValid(self.Owner) or self.Owner:Health() < 0 or !self:CanPrimaryAttack() or self:GetRunning() or self:GetNextReload() > CurTime() or (self.Chargeable and self:GetCharge() <= 0) then 
	return 
	end
	
		self.SightsConeMul = math.Clamp(self.SightsConeMul, 0, 1)
	
		self:CallOnClient("RollDrum", "1")
	
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
		
		--if SERVER then
			if self:GetSilencer() then
				if self.RandomSilSound then
					self:EmitSound(self.SilencedSound.."_"..math.random(1, self.MaxRandomSilSound)..self.RandomSoundFileType)
				else
					self:EmitSound(self.SilencedSound)
				end
			else
				if self.RandomPrimarySound then
					self:EmitSound(self.PrimarySound.."_"..math.random(1, self.MaxRandomSound)..self.RandomSoundFileType)
				else
					self:EmitSound(self.PrimarySound)
				end
			end
		--end
		
		if self.Chargeable then
			self:SetCharge(self:GetCharge()-self.ChargeTake)
		end
		
		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
		
		self:Recoil()
end
