
SWEP.Base = "metro_base"

SWEP.PossibleAttachments = {
     ["scope1"] = {
        bone = "velopal_body",
        pos = Vector(-0.6, -4.2, 1.5), 
        ang = Angle(0, 0, -90),
        size = 1,
        IronsightPos = Vector(-3.5, 1, 0.4),
        IronsightAng = Vector(-0.5, 0, 0),
        second_attachment = "planka1"
    },
	["nv_scope"] = {
		bone = "velopal_body",
		pos = Vector(-0.65, -4.8, 2), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.6, 0, -1),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka1"
	},
	["scope3"] = {
		bone = "velopal_body",
		pos = Vector(-0.65, -4.8, 1), 
		ang = Angle(90, 0, -90),
		size = 1,
		IronsightPos = Vector(-3.6, 0, 0),
		IronsightAng = Vector(0, 0, 0),
		second_attachment = "planka1"
	},
	["planka1"] = {
		bone = "velopal_body",
		pos = Vector(-0.29, -2.27, 1.5), 
		ang = Angle(90, -90, 0),
		size = 1.2
	},
	["revolver_silencer"] = {
		bone = "velopal_body",
		pos = Vector(-0.401, -1.8, 26), 
		ang = Angle(90, 0, 0),
		size = 1.5
	},
	["laser_sight"] = {
		bone = "velopal_body",
		pos = Vector(1, -0.5, 14), 
		ang = Angle(90, 15, -90),
		size = 1
	}
}


SWEP.ZatvorBone = "kalash_zatvor"
SWEP.UseZatvorBone = false

SWEP.EmptyReload = true
SWEP.ChamberedRound = false
SWEP.UseMagBulletsBodyroup = true
SWEP.MagBulletsBodyroup = 4
--SWEP.ReloadBobMul = 0.5
SWEP.MagGroupClipOffset = 6

SWEP.GaySightAttack = true

SWEP.AnimOverrides = {	
	["drum"] = {
		["fire"] = ACT_VM_PRIMARYATTACK,
		["draw"] = ACT_VM_DRAW,
		["reload"] = ACT_VM_RECOIL3,
		["reload_empty"] = ACT_VM_RELOAD,
		["holster"] = ACT_VM_HOLSTER
	}
}
SWEP.OverrideAnims = "default"

SWEP.DefaultAnims = {
	["idle"] = ACT_VM_IDLE,
	["fire"] = ACT_VM_PRIMARYATTACK,
	["draw"] = ACT_VM_DRAW,
	["reload_2"] = ACT_VM_RECOIL1,
	["reload_3"] = ACT_VM_RECOIL2,
	["reload_4"] = ACT_VM_ATTACH_SILENCER,
	["reload_switch"] = ACT_VM_RECOIL3,
	["reload_5"] = ACT_VM_DETACH_SILENCER,
	["reload_6"] = ACT_VM_HAULBACK,
	["reload_empty"] = ACT_VM_RELOAD,
	["reload_finish"] = ACT_VM_MISSCENTER2,
	["reload_finish1"] = ACT_VM_MISSCENTER,
	["holster"] = ACT_VM_HOLSTER,
	["reload_start_frsthalf1"] = ACT_VM_MISSRIGHT2,
	["reload_start_frsthalf2"] = ACT_VM_IDLE_TO_LOWERED,
	["reload_start_frsthalf3"] = ACT_VM_IDLE_LOWERED,
	["reload_start_secondhalf1"] = ACT_VM_MISSRIGHT,
	["reload_start_secondhalf2"] = ACT_VM_SWINGHIT
}

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "Велопал"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/velopal/v_velopal.mdl"
SWEP.WorldModel		= "models/w_weapons/w_velopal.mdl"

SWEP.IronsightPos = Vector(-3.6, 0, 0.2)
SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.IronsightZoom = 20
SWEP.SightsConeMul = 0.5

SWEP.RunPos = Vector(1.475, -2.396, -0.369)
SWEP.RunAng = Vector(-10.323, 24.516, -9.678)

SWEP.InMenu = false

SWEP.ReloadBobMul	= 1

SWEP.HoldType		= "shotgun"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.BulletDistance			= 1000

SWEP.Primary.Recoil			= 5

SWEP.Primary.Damage			= 16  
SWEP.Primary.NumShots		= 7
SWEP.Primary.Cone			= 1

SWEP.Primary.Delay			= 0.3

SWEP.Primary.ClipSize		= 6 ---1
SWEP.Primary.DefaultClip	= 30 ---1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "metro_shotgun"

SWEP.UseHands = false
SWEP.Slot    = 2
SWEP.SlotPos = 2
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.PrimarySound			= "weapons/ubo_1.mp3"
SWEP.DryFireSound			= "weapons/ubo_dry_fire_0.mp3"

SWEP.DeploySound = "weapons/draw.wav"
SWEP.HolsterSound = "weapons/holster.wav"

function SWEP:SetupDataTables()

	self:NetworkVar( "Bool", 1, "AimBool" )
	self:NetworkVar( "Float", 1, "NextReload" )
	self:NetworkVar( "Bool", 2, "Holster" )
	self:NetworkVar( "Float", 2, "Charge" )
	self:NetworkVar( "Bool", 3, "Running" )
	self:NetworkVar( "Bool", 4, "Silencer" )
	self:NetworkVar( "Float", 3, "Recoil" )
	self:NetworkVar( "Float", 4, "Overheat" )
	
	self:NetworkVar( "Float", 5, "HolsterDelay" )
	self:NetworkVar( "Bool", 5, "Deployed" )
	self:NetworkVar( "Bool", 6, "Charging" )
	self:NetworkVar( "Float", 6, "NxtPump" )
	
	self:NetworkVar( "Bool", 7, "Safe" )
	
	self:SetAimBool( false )
	self:SetNextReload( 0 )
	self:SetCharge( 100 )
	self:SetHolster( false )
	self:SetRunning( false )
	self:SetSilencer( false )
	self:SetRecoil( 0 )
	self:SetOverheat( 0 )
	
	self:SetHolsterDelay( 0 )
	self:SetDeployed( false )
	self:SetCharging( false )
	
	self:SetNxtPump( 0 )

	self:NetworkVar( "Bool", 7, "Reloading" )
	self:NetworkVar( "Bool", 8, "Started" )
	self:NetworkVar( "Bool", 9, "Second" )
	
	self:SetReloading(false)
	self:SetStarted(false)
	self:SetSecond(false)
	
	self:SetSafe( false )
	
end

function SWEP:ShellsStuff()
		self:CallOnClient("RollDrum", "1")
		
		self.Shl2 = true
		self.NxtShell2 = CurTime() + 0.01
		pring("che")
end


SWEP.NxtReloadCheck = 0
SWEP.Scnd = false
SWEP.Started = false

SWEP.Shl = false
SWEP.NxtShell = 0

SWEP.Shl2 = false
SWEP.NxtShell2 = 0

local drumroll = Angle(0, 0, 0)
local drmrltmp = Angle(0, 0, 0)

function SWEP:RollDrum()
	drumroll = Angle(0, 0, 0)
	drmrltmp = drumroll + Angle(0, 60, 0)
end

function SWEP:ResetDrum()
	local vm = self.Owner:GetViewModel()
	local drum = vm:LookupBone("velopal_roll_3")
	local drum1 = vm:LookupBone("velopal_roll")
	vm:ManipulateBoneAngles(drum, Angle(0, 0, 0))
	vm:ManipulateBoneAngles(drum1, Angle(0, 0, 0))
	drumroll = Angle(0, 0, 0)
	drmrltmp = drumroll
end



function SWEP:PrimaryAttack()
	if not IsValid(self.Owner) or self.Owner:Health() < 0 or !self:CanPrimaryAttack() or self:GetRunning() or self:GetNextReload() > CurTime()+0.1 then return end
	
		self.SightsConeMul = math.Clamp(self.SightsConeMul, 0, 1)
		
		if self:GetReloading() then
			self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
			self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
			self:SetReloading(false)
			if self.Started then
				if self:Clip1() > 3 then
					self:PlayAnim("reload_finish")
				else
					self:PlayAnim("reload_finish1")
				end
				self.Scnd = false
				self.Started = false
				return
			end
		end
				
		if self:GetAimBool() then
			--if self.GaySightAttack then
			--	self:CallOnClient("GayAttack", "1")
			--else
			--end
			self:ShootBullet(self.Primary.Damage, self.Primary.NumShots*self.Primary.TakeAmmo, self.Primary.Cone*self.SightsConeMul)
		else
			self:ShootBullet(self.Primary.Damage, self.Primary.NumShots*self.Primary.TakeAmmo, self.Primary.Cone)
		end
		
		self:PlayAnim("fire")
		
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self:CallOnClient("RollDrum", "1")
		
		--self.Shl2 = true
		--self.NxtShell2 = CurTime() + 0.6
		
		if SERVER then self.Owner:EmitSound(self.PrimarySound) end

		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
		self.idledelay = CurTime() + self:SequenceDuration()
		
		self:Recoil()
end

function SWEP:SecondThink()

	local vm = self.Owner:GetViewModel()
	local drum = vm:LookupBone("velopal_roll_3")
	local drum1 = vm:LookupBone("velopal_roll")
	--local cur_shell = vm:LookupBone("uboinik_bullet_2")
	
	drumroll = LerpAngle(FrameTime()*6.5, drumroll, drmrltmp)
	vm:ManipulateBoneAngles(drum, drumroll)
	
	drumroll = LerpAngle(FrameTime()*6.5, drumroll, drmrltmp)
	vm:ManipulateBoneAngles(drum1, drumroll)
	--vm:ManipulateBonePosition(cur_shell, Vector(0,0,0))
	
	if self.Shl and self.NxtShell < CurTime() then
		local rnd = math.random(0, 7)
		if SERVER then self.Owner:EmitSound("weapons/ubo_patron_"..rnd..".mp3") end
		self.Shl = false
	end
	
	if self:GetReloading() then
		if self:GetNextReload() <= CurTime() then
			if self:Clip1() < self.Primary.ClipSize and self.Weapon:Ammo1() > 0 then
				if self:Clip1() == 1 and !self:GetStarted() then
					self:PlayAnim("reload_start_frsthalf1")
					--if SERVER then self.Owner:EmitSound("weapons/ubo_shlep_3.mp3") end
					self:SetStarted(true)
					self:SetNextReload( CurTime() + 0.4 )
					return
				elseif self:Clip1() <= 3 then
					self.Weapon:SetClip1( self.Weapon:Clip1()+1 )
					self.Owner:SetAmmo( self.Weapon:Ammo1() - 1, self.Primary.Ammo ) 
					self:PlayAnim("reload_"..self:Clip1())
					self.Shl = true
					self.NxtShell = CurTime() + 0.2
					--print("gg")
				else
					if !self:GetSecond() then
						self:PlayAnim("reload_switch")
						if SERVER then self.Owner:EmitSound("weapons/ubo_move_0.mp3") end
						self:SetSecond(true)
					else	
						self.Weapon:SetClip1( self.Weapon:Clip1()+1 )
						self.Owner:SetAmmo( self.Weapon:Ammo1() - 1, self.Primary.Ammo ) 
						self:PlayAnim("reload_"..self:Clip1())
						self.Shl = true
						self.NxtShell = CurTime() + 0.2
					end
				end
				
				self:SetNextReload( CurTime() + 0.5 )
				
			else
				if self:Clip1() > 3 then
					self:PlayAnim("reload_finish")
				elseif self:Clip1() > 1 then
					self:PlayAnim("reload_finish1")
				end
				self:SetSecond(false)
				self:SetReloading(false)
				self:SetStarted(false)
			end
		end
	end
end

SWEP.Reloading = false

function SWEP:Reeload()

	if (self:Clip1() >= self.Primary.ClipSize) or self:GetReloading() or self.Weapon:Ammo1() < 0 or self:Ammo1() <= 0 or self:GetNextReload() > CurTime() or self:GetNextPrimaryFire() > CurTime() then return end
	--print("g")
	local ammomath = 0
	local empty = false
	self:CallOnClient("ResetDrum", "1")
		if self.Weapon != nil then
			self.Owner:SetAnimation(PLAYER_RELOAD)
		end
		if !self:GetReloading() then
			self:SetReloading(true)
			if self:Clip1() <= 0 then
				self.Weapon:SetClip1( self.Weapon:Clip1()+1 )
				self.Owner:SetAmmo( self.Weapon:Ammo1() - 1, self.Primary.Ammo ) 
				self:PlayAnim("reload_empty")
				
				self.Shl = true
				self.NxtShell = CurTime() + 1.5
				
				self.NxtReloadCheck = CurTime() + 2.6
				self:SetNextReload( CurTime() + 2.6 )
			elseif self:Clip1() <= 3 then
				self:SetStarted(true)
				self:PlayAnim("reload_start_frsthalf"..self:Clip1())
				self.NxtReloadCheck = CurTime() + 0.65
				self:SetNextReload( CurTime() + 0.65 )
			elseif self:Clip1() >= 4 then
				self:SetSecond(true)
				self:PlayAnim("reload_start_secondhalf"..self:Clip1()-3)
				self.NxtReloadCheck = CurTime() + 0.65
				self:SetNextReload( CurTime() + 0.65 )
			end
		end

	--self.idledelay = CurTime() + self:SequenceDuration()
	self:SetRunning(false)
	
end
