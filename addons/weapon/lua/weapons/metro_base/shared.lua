
SWEP.PossibleAttachments = {}

SWEP.CurrentAttachments = {} --ne trogat

SWEP.ZatvorBone = "kalash_zatvor"
SWEP.UseZatvorBone = true

SWEP.UseMagBulletsBodyroup = true
SWEP.MagBulletsBodyroup = 4

SWEP.MagGroupOffset = 0
SWEP.MagGroupClipOffset = 0

SWEP.EmptyReload = true
SWEP.ChamberedRound = true
SWEP.AutoReload = false

SWEP.GaySightAttack = false

SWEP.SilentByDefault = false

SWEP.Chargeable = false
SWEP.ChargeTake = 5
SWEP.ChargeAdd = 5
SWEP.ChargeStrelkaBone = "tihar_strelka_1"
SWEP.ChargeStrelkaUseScale = false
SWEP.StrelkaOffset = 0

SWEP.UseProjectiles = false
SWEP.Projectile = "metro_projectile"

SWEP.MuzzleName = "m_muzzle1"

SWEP.EffectShell = true

SWEP.ShellTexture = "effects/animated/animated_gilza_1"

SWEP.Ironsights = true

SWEP.RTSight = false

SWEP.ForwardMod = 3

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
	["idle"] = ACT_VM_IDLE
}

if (SERVER) then

	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false

end

if ( CLIENT ) then
	
	local rtsize = ScrH()
	
	SWEP.RTTexture = GetRenderTarget("rt_metro_scope12", rtsize, rtsize, false)
	SWEP.RTMat = CreateMaterial("mat_metro_scope", "UnlitGeneric", {
		['$basetexture'] = ""
	})
	
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 50
	SWEP.ViewModelFlip		= false
	
end

SWEP.BounceWeaponIcon  = false

SWEP.PrintName		= "metro base"
SWEP.Author			= "hoobsug"
SWEP.Contact		= "https://steamcommunity.com/id/hoobsucc/"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/weapons/ak_74/v_ak_74.mdl"--"models/cw2/rifles/ak74.mdl"--"models/weapons/c_357.mdl"--
SWEP.WorldModel		= "models/weapons/w_357.mdl"

SWEP.projected_texture = nil

--SWEP.IronsightPos = Vector(-2.441, -3.83, 0.908)
--SWEP.IronsightAng = Vector(0.21, -0.401, 0)
SWEP.IronsightPos = Vector(-2.651, -2, 1.049)
SWEP.IronsightAng = Vector(-0.5, 0, 0)
--SWEP.IronsightPos = Vector(-2.651, -2, 0.6)
--SWEP.IronsightAng = Vector(-0.5, 0, 0)
SWEP.IronsightZoom = 20
SWEP.SightsConeMul = 0.5

SWEP.RunPos = Vector(1.475, -2.396, -0.369)
SWEP.RunAng = Vector(-10.323, 24.516, -9.678)

--SWEP.AttPos = Vector(4.421, -7.84, -2.412)
--SWEP.AttAng = Vector(33.769, 23.92, 14.774)
SWEP.AttPos = Vector(7, -7.3, -1.3)
SWEP.AttAng = Vector(32, 44, 22)

SWEP.InMenu = false

SWEP.ReloadBobMul	= 1

SWEP.HoldType		= "slam"

SWEP.Category		= "METRO BASE"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.BulletDistance 		= 56756

SWEP.Primary.Recoil			= 0.5

SWEP.Primary.Damage			= 40  
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.2

SWEP.Primary.Delay			= 0.1

SWEP.Primary.Force			= 3

SWEP.Primary.ClipSize		= 30 ---1
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.DefaultClip	= 30 ---1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"

SWEP.UseHands = false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.PrimarySound			= "weapons/cw_ak74/fire.wav"
SWEP.SilencedSound			= "weapons/cw_ak74/fire_suppressed.wav"

SWEP.DryFireSound			= "weapons/ubo_dry_fire_0.mp3"

SWEP.ReloadSound			= "weapons/ak74_reload_0.mp3"

SWEP.DeploySound = "HMC/weapons/Gun_Pull_01.wav"
SWEP.HolsterSound = "HMC/weapons/Gun_Holster_01.wav"

--SWEP.VecticalRecoil = 1
--SWEP.HorisontalRecoil = 0.5

SWEP.SwayScale			= 0.0
SWEP.BobScale			= 0.0

SWEP.ReloadPlayback		= 1
SWEP.DeployPlayback		= 1

SWEP.idledelay = 0

local AimBool = false

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
	
	self:SetSafe( false )
	
end

function SWEP:Initialize()

	if ( SERVER ) then
		self:SetNPCMinBurst( 30 )
		self:SetNPCMaxBurst( 30 )
		self:SetNPCFireRate( 0.01 )
	end
	
	self:SetHoldType( self.HoldType )

end

function SWEP:PlayAnim(anim)

	--if not IsFirstTimePredicted() then return end
	
	local vm = self.Owner:GetViewModel()
	
	local seq = nil
	local playback = 1
	
	if self.OverrideAnims != "default" then
		seq = vm:SelectWeightedSequence( self.AnimOverrides[self.OverrideAnims][anim] )
	else
		seq = vm:SelectWeightedSequence( self.DefaultAnims[anim] )
	end
	
	--if IsFirstTimePredicted() then
		
	vm:SendViewModelMatchingSequence( seq )
	--self.Weapon:SendWeaponAnim(seq)
	
	if anim == "reload" or anim == "reload_empty" then 
		playback = self.ReloadPlayback
	elseif anim == "draw" or anim == "holster" then
		playback = self.DeployPlayback
	else
		playback = 1
	end
	
	vm:SetPlaybackRate( playback )
		
	--end
	
	local duration = vm:SequenceDuration()
	
	self.idledelay = ( CurTime() + duration / playback )
	
end

SWEP.FirstTimeDeploy = true

function SWEP:DefaultAtts()

	for k, v in pairs(self.PossibleAttachments) do
		if v.default and v.default == true then
			local data = all_attachments[k]
			if data == nil then return end
			--if self.CurrentAttachments[all_attachments[k].atype] == nil then
				--self:SvClearAttachment(all_attachments[k].atype)			
					self:SvClearAttachment(data.atype)
					self.CurrentAttachments[data.atype] = {name = k}
					self:SetServerAttachments(k)
					self:CallOnClient("SetClientAttachments", k)
			--end
			self:Load()
		end
		
	end
	
	self:SetupBodygroupsTable()
	
end

function SWEP:OnDeploy()

end

SWEP.BodygroupsTable = nil

function SWEP:ResetBodygroups()
	
	--if !IsFirstTimePredicted() and !SERVER then return false end
	local vm = self.Owner:GetViewModel()
	if not IsValid(vm) then return end
	
	for k, v in pairs( vm:GetBodyGroups() ) do
		vm:SetBodygroup(v.id, 0)
	end
	
	if (!vm:GetBoneCount()) then return end
	
	for i = 0, vm:GetBoneCount() do
		vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
		vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
		vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
	end
	
	if self.projected_texture != nil then
		self.projected_texture:Remove()
		self.projected_texture = nil
	end

	--[[if CLIENT then
		if self.UseZatvorBone then
			if self.zatvor == nil then
				self.zatvor = vm:LookupBone(self.ZatvorBone)
			end
			vm:ManipulateBonePosition(self.zatvor, Vector(0,0,0))
		end
	end]]
	--print("loh ubral "..self.PrintName)

end

function SWEP:SetupBodygroupsTable()
	if self.BodygroupsTable == nil then
		local vm = self.Owner:GetViewModel()
		self.BodygroupsTable = {}
		
		local g = vm:GetBodyGroups()
		for k, v in pairs(g) do
			self.BodygroupsTable[v.id] = {submodel = 0}
			vm:SetBodygroup(v.id, 0)
		end
	end
end

function SWEP:LoadBodygroups()
	local vm = self.Owner:GetViewModel()
	
	if self.BodygroupsTable == nil then
		self:SetupBodygroupsTable()
	else
		for k, v in pairs(self.BodygroupsTable) do
			vm:SetBodygroup(k, v.submodel)
		end
	end
end

function SWEP:SetAttachmentBodygroup(a, b)
	
	local vm = self.Owner:GetViewModel()
	self:SetupBodygroupsTable()
	vm:SetBodygroup(a, b)
	if self.BodygroupsTable[a] != nil then
		self.BodygroupsTable[a].submodel = b
	end
end

SWEP.BodyGroupsCheck = false
SWEP.Safe = false

function SWEP:ResetScope()
	self.curscope = nil
end

function SWEP:Deploy()
	
	if CLIENT then
		self.curscope = nil
	else
		self:CallOnClient("ResetScope")
	end
	--PrintTable(self.BodygroupsTable)

	for k, v in pairs( self.CurrentAttachments ) do
		if v.attdata == nil then v.attdata = all_attachments[v.name] end
	end
	
	self:EmitSound(self.DeploySound, 100, 100)
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)
	self:SetNextReload( CurTime() + 1 )
	self.idledelay = ( CurTime() + 1 )

	self:SetHolster(false)
	self:SetRunning(false)
	
	self.BodyGroupsCheck = false
	
	self:LoadBodygroups()
	self:CallOnClient("LoadBodygroups")
	self:PlayAnim("draw")
	self:SetDeployed(true)
	
	--self.Owner:SetPos(Vector(0,0,0))
	
	self:OnDeploy()
	return true
end

		
function SWEP:SecondaryAttack()	
	return
end

function SWEP:Unload()

self.Owner:SetAmmo( self.Weapon:Ammo1() + self.Weapon:Clip1(), self.Primary.Ammo )
self.Weapon:SetClip1( 0 )
local vm = self.Owner:GetViewModel()
vm:SetBodygroup(self.MagBulletsBodyroup, 0)

end

function SWEP:Load()
	local ammomath = 0
	
		if self.Weapon:Ammo1() >= self.Primary.ClipSize - self.Weapon:Clip1() then
			ammomath = self.Primary.ClipSize - self.Weapon:Clip1()
			self.Owner:SetAmmo( self.Weapon:Ammo1() - ammomath, self.Primary.Ammo ) 			
		elseif self.Weapon:Ammo1() < self.Primary.ClipSize - self.Weapon:Clip1() then
			ammomath = self.Weapon:Ammo1()
			self.Owner:SetAmmo( 0, self.Primary.Ammo ) 		
		end	
		
		if ( self.Weapon:Clip1() >= self.Primary.ClipSize ) then return end
		self.Weapon:SetClip1( self.Weapon:Clip1()+ammomath )
end

SWEP.ReloadAmmoDelay = 0.55

function SWEP:OnReload()

end

function SWEP:CanReload()
	if (self.ChamberedRound and self:Clip1() >= self.Primary.ClipSize + 1) or (!self.ChamberedRound and self:Clip1() >= self.Primary.ClipSize) or self.Weapon:Ammo1() < 0 or self:Ammo1() <= 0 or self:GetNextReload() > CurTime() then 
		return false
	end
	return true
end

function SWEP:Reeload()

	if !IsFirstTimePredicted() then return false end
	if self.Owner:KeyDown(IN_USE) then 
		self:SetSafe( !self:GetSafe() ) 
		self:SetNextPrimaryFire( CurTime() + 0.1 )
	return end
	if !self:CanReload() or self:GetSafe() then return end
	
	self:OnReload()
	
	local empty = false
	
		if self.Weapon != nil then
			self.Owner:SetAnimation(PLAYER_RELOAD)
		end
		
		if self:Clip1() <= 0 then
			if self.EmptyReload then
				self:PlayAnim("reload_empty")
			else
				self:PlayAnim("reload")
			end
			empty = true
		else
			self:PlayAnim("reload")
			empty = false
		end
	
	local vm = self.Owner:GetViewModel()
	self:SetRunning(false)
	self:SetNextReload( CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate() )
	self:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate() )
	
	local ammomath = 0
	local delay = vm:SequenceDuration()
	
	if self.ReloadAmmoDelay != 0 then
		delay = self.ReloadAmmoDelay
	end
	
	timer.Simple( delay, function() 
		if self.Weapon == nil then return end
		
		if self.Weapon:Ammo1() >= self.Primary.ClipSize - self.Weapon:Clip1() then
			if !empty and self.Weapon:Ammo1() >= self.Primary.ClipSize - self.Weapon:Clip1()+1 and self.ChamberedRound then
				ammomath = self.Primary.ClipSize - self.Weapon:Clip1()+1
				self.Owner:SetAmmo( self.Weapon:Ammo1() - ammomath, self.Primary.Ammo ) 
			else
				ammomath = self.Primary.ClipSize - self.Weapon:Clip1()
				self.Owner:SetAmmo( self.Weapon:Ammo1() - ammomath, self.Primary.Ammo ) 			
			end
		elseif self.Weapon:Ammo1() < self.Primary.ClipSize - self.Weapon:Clip1() then
			ammomath = self.Weapon:Ammo1()
			self.Owner:SetAmmo( 0, self.Primary.Ammo ) 		
		end	
		
		if ( self.ChamberedRound and self.Weapon:Clip1() >= self.Primary.ClipSize + 1 ) or ( !self.ChamberedRound and self.Weapon:Clip1() >= self.Primary.ClipSize ) then return end
		self.Weapon:SetClip1( self.Weapon:Clip1()+ammomath )
	end)
	
end

function SWEP:Reload()
	
end

function SWEP:SecondThink()

end

SWEP.Charging = false
SWEP.ChargeHold = 0
SWEP.NxtPump = 0

function SWEP:Think()

	self:SecondThink()
	
	if not self.Owner:IsPlayer() then return end
		
		if SERVER and self.idledelay < CurTime() and !self:GetCharging() then
			self:PlayAnim("idle")
		end
		
		self:SetRecoil( math.Approach(self:GetRecoil(), 0, FrameTime()*10 ) )
		
		if self:GetDeployed() and self:GetHolster() and self:GetHolsterDelay() < CurTime() then
			if not IsFirstTimePredicted() then return end
			self:ResetBodygroups()
			self:CallOnClient("ResetBodygroups")
			if SERVER then 
				self.Owner:SelectWeapon(self.ChangeTo)			
			end
			--print("holster")
			self.Weapon:SetDeployed(false)
		end

		if self.FirstTimeDeploy then
			self:DefaultAtts()
			self.FirstTimeDeploy = false
		end

		local vel = self.Owner:GetVelocity():LengthSqr()*0.001
		
		if self.Owner:KeyDown(IN_SPEED) and self.Owner:OnGround() and vel >= 30 then
			self:SetRunning(true)
		else
			self:SetRunning(false)
		end
	
		if self.Owner:KeyDown(IN_ATTACK2) and self:GetNextReload() < CurTime() and self.Ironsights and !self:GetRunning() and !self:GetSafe() and self.Owner:GetNWBool("offhand_on") == false then 
			self:SetAimBool(true)
		else
			self:SetAimBool(false)
		end
	
		if self:GetRunning() or self:GetSafe() then
			self:SetHoldType( "passive" )
		else
			self:SetHoldType( self.HoldType )
		end
	
		if self.AutoReload and self:GetNextPrimaryFire() < CurTime() and self:Clip1() <= 0 and self:CanReload() and IsFirstTimePredicted() then
			self:Reeload()
		end
		
		local vm = self.Owner:GetViewModel()
		
		if self.Chargeable and self:GetCharge() < 100 then
			if ALWAYS_RAISED[self:GetClass()] == nil or !ALWAYS_RAISED[self:GetClass()] then
				ALWAYS_RAISED[self:GetClass()] = true
			end
		else
			if ALWAYS_RAISED[self:GetClass()] then
				ALWAYS_RAISED[self:GetClass()] = false
			end
		end
    
		if self:GetCharging() then
			if self:GetCharge() < 100 then
				if self.Owner:KeyDown(IN_ATTACK) and self:GetNxtPump() < CurTime() then
						if self:GetCharge() < 80 then
							self:PlayAnim("pump")	
							if SERVER and IsFirstTimePredicted() then
								self.Owner:EmitSound(self.PumpSound)
							end
						else
							self:PlayAnim("pump2")
							if SERVER and IsFirstTimePredicted() then	
								self.Owner:EmitSound(self.PumpHardSound)
							end
						end
						self:SetNxtPump(CurTime() + vm:SequenceDuration())
						self:SetCharge(self:GetCharge() + self.ChargeAdd)
						self:SetNextReload(CurTime() + vm:SequenceDuration())
						self:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() )
				else
					self:SetNextReload(CurTime() + 0.1)
				end
			else
				if self:GetNxtPump() < CurTime() then
					self:PlayAnim("pump_finish")	
					self.Owner:EmitSound(self.ChargeOutSound)	
					self:SetCharging(false)
					self:SetNextReload(CurTime() + vm:SequenceDuration())
					self:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() )
				end
			end
			self:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() )
		end
		
		if self.Owner:KeyDown(IN_RELOAD) and self.ChargeHold < 11 then
			self.ChargeHold = self.ChargeHold + 0.15
			if self.Chargeable and self:GetCharge() < 100 then		
				if !self:GetCharging() and self.ChargeHold > 10 and self:GetNxtPump() < CurTime() and ( SERVER and IsFirstTimePredicted() ) then
					self:SetCharging(true)
					self:PlayAnim("pump_start")	
					self.Owner:EmitSound(self.ChargeInSound)
					self:SetNxtPump(CurTime() + vm:SequenceDuration())
					self:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() )		
				end
			end
		end
		
		if !self.Owner:KeyDown(IN_RELOAD) then
			if self:GetCharging() and self:GetNxtPump() < CurTime() then 
				self:SetCharging(false)
				self:PlayAnim("pump_finish")	
				if SERVER and IsFirstTimePredicted() then
					self.Owner:EmitSound(self.ChargeOutSound)	
				end
				self:SetNxtPump(CurTime() + vm:SequenceDuration())
				self:SetNextReload(CurTime() + vm:SequenceDuration())
				self:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() )
			else
				if self.ChargeHold > 0 and self.ChargeHold < 5 then
					self:Reeload()
				end
			end
			self.ChargeHold = 0
		end
		
	--end
	
	local vm = self.Owner:GetViewModel()

	if self.UseMagBulletsBodyroup then
		
		local magnum = self:Clip1()
		local magsize = self.Primary.ClipSize
		local maxgroup = vm:GetBodygroupCount(self.MagBulletsBodyroup)
		
		if self.MagGroupClipOffset != 0 then
			magnum = math.Clamp(magnum, 0, self.MagGroupClipOffset)
			magsize = math.Clamp(magsize, 0, self.MagGroupClipOffset)
		end
		
		if self.MaxMagGroup > 0 then
			maxgroup = self.MaxMagGroup
		else
			maxgroup = vm:GetBodygroupCount(self.MagBulletsBodyroup)
		end
	
		local magcnt = math.Clamp(math.floor(magnum/(magsize/maxgroup)), 0, maxgroup-1)
		
		--draw.SimpleText( magcnt .. " / "..maxgroup, "MetroInventoryFont1", 122, 64, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
		vm:SetBodygroup(self.MagBulletsBodyroup, magcnt-self.MagGroupOffset)
	--else
	--	vm:SetBodygroup(self.MagBulletsBodyroup, 0)
	end
	
	if self.BodygroupsTable != nil and self.BodyGroupsCheck == false then
		for k, v in pairs(self.BodygroupsTable) do
			if k != self.MagBulletsBodyroup then
				vm:SetBodygroup(k, v.submodel)
			end
		end
		self.BodyGroupsCheck = true
	end
	
end

function SWEP:OnRemove()
	if not self.Owner:IsPlayer() then return end
	self:ResetBodygroups()
end

SWEP.AttackSteps = 0
SWEP.LastShot = false

function SWEP:Recoil()

	local sss = 2
	if self:GetAimBool() then
		sss = 4
	else
		sss = 2
	end
	local rand_roll = math.random(-self.Primary.Recoil/sss, self.Primary.Recoil/sss)
	local ply = self.Owner
	
	self:SetRecoil( self.Primary.Recoil/sss )
	
	   if !ply:IsNPC() and ( (game.SinglePlayer() and SERVER) or ( !game.SinglePlayer() and CLIENT and IsFirstTimePredicted() ) ) then
               local shotang = self.Owner:EyeAngles()
				shotang.pitch = shotang.pitch - math.random(0, self.Primary.Recoil/(sss))
				shotang.yaw = shotang.yaw - math.random(-self.Primary.Recoil/sss, self.Primary.Recoil/sss)
                ply:SetEyeAngles( shotang )
       end	
	self.Owner:ViewPunch( Angle( -self.Primary.Recoil/sss, 0, rand_roll/sss ) )
	
end

function SWEP:Muzzle() 
	if IsFirstTimePredicted() then
	
		local fx = EffectData()
		fx:SetEntity(self.Weapon) 
		fx:SetOrigin(self.Owner:GetShootPos())
		fx:SetNormal(self.Owner:GetAimVector())
		fx:SetAttachment(1)
		
		util.Effect(self.MuzzleName, fx)
		
	end
end

function SWEP:PrimaryAttack()
	if not IsValid(self.Owner) or self.Owner:Health() < 0 or !self:CanPrimaryAttack() or self:GetRunning() or self:GetSafe() or self:GetNextReload() > CurTime() or (self.Chargeable and self:GetCharge() <= 0) then 
	return 
	end
		
		--if !IsFirstTimePredicted() then return end
		
		self.SightsConeMul = math.Clamp(self.SightsConeMul, 0, 1)
	
		if self:GetAimBool() then
			if self.GaySightAttack then
				if (!game.SinglePlayer() and CLIENT) then 
					self:GayAttack() 
				elseif game.SinglePlayer() then
					self:CallOnClient("GayAttack", "")
				end
			else
				if self.LastShot and self:Clip1() == 1 then
					self:PlayAnim("fire_last")
				else
					self:PlayAnim("fire")
				end
			end
			self:ShootBullet(self.Primary.Damage, self.Primary.NumShots*self.Primary.TakeAmmo, self.Primary.Cone*self.SightsConeMul)
		else
			if self.LastShot and self:Clip1() == 1 then
				self:PlayAnim("fire_last")
			else
				self:PlayAnim("fire")
			end
			self:ShootBullet(self.Primary.Damage, self.Primary.NumShots*self.Primary.TakeAmmo, self.Primary.Cone)
		end
		
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		
		self:Muzzle()
		
		--if game.SinglePlayer() or (!game.SinglePlayer() and !SERVER) then
			if self:GetSilencer() then
				if self.RandomSilSound then
					self:EmitSound(self.SilencedSound.."_"..math.random(1, self.MaxRandomSilSound)..self.RandomSoundFileType, 75, 100, 1, CHAN_ITEM)
				else
					self:EmitSound(self.SilencedSound, 75, 100, 1, CHAN_ITEM)
				end
			else
				if self.RandomPrimarySound then
					self:EmitSound(self.PrimarySound.."_"..math.random(1, self.MaxRandomSound)..self.RandomSoundFileType, 75, 100, 1, CHAN_ITEM)
				else
					self:EmitSound(self.PrimarySound, 75, 100, 1, CHAN_ITEM)
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

SWEP.Penetration = false
SWEP.PenetrationSpread = 1
SWEP.MaxDamageDist = 1000

function SWEP:BulletCallback1(attacker, tr, amginfo)

	if tr.Entity:IsValid() and ( tr.Entity:IsNPC() or tr.Entity:IsPlayer() ) then
					
		local bullet = {}
		bullet.Num = 1
		bullet.Src = tr.HitPos + (tr.HitNormal*-1)*15
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector( self.Primary.Cone*0.1, self.Primary.Cone*0.1, 0)
		bullet.Tracer = 1
		bullet.Force = self.Primary.Force/2
		bullet.Damage = self.Primary.Damage/2
		bullet.AmmoType = self.Primary.Ammo
		self.Owner:FireBullets(bullet)
					
	end
	
end

SWEP.ProjectileBasicForce = 1100
SWEP.ProjectileChargedForce = 300
SWEP.ProjectileGravity = -5

function SWEP:ShootBullet(dmg, num, cone)
	
	if !self.UseProjectiles then
		local bulletcallback = function(attacker, tr, dmginfo)
			
			local shootpos = attacker:GetShootPos()
			local hitpos = tr.HitPos
			local distance = shootpos:DistToSqr(hitpos)
			local mxdist = self.MaxDamageDist*self.MaxDamageDist
			
			local range = mxdist*2 - mxdist
			local distance2 = ((distance - mxdist) / range)*0.2
			
			dmginfo:SetDamage( Lerp(distance2, dmginfo:GetDamage(), self.Primary.Damage/2) )
			
			if self.Penetration then
				self:BulletCallback1(attacker, tr, dmginfo)
			end
			
		end

		local bullet = {}
	
		--for i = 1, num do
			bullet.Num = num
			bullet.Src = self.Owner:GetShootPos()
			bullet.Dir = self.Owner:GetAimVector()
			bullet.Spread = Vector(cone*0.1, cone*0.1, 0)
			bullet.Distance = self.BulletDistance
			if math.random(0, 1) == 1 then
				bullet.Tracer = 1
			else
				bullet.Tracer = 0
			end
			if self.Chargeable then
				bullet.Damage = 3+(dmg*(self:GetCharge()*0.01))
				bullet.Force = (self.Primary.Force*(self:GetCharge()*0.01))
			else
				bullet.Damage = dmg
				bullet.Force = self.Primary.Force
			end
			bullet.AmmoType = self.Primary.Ammo
			bullet.Callback = bulletcallback
			self.Owner:FireBullets(bullet)	
	else
		if !SERVER then return end
		local projectile = ents.Create( self.Projectile )
		if ( !IsValid( projectile ) ) then return end
		--button:SetModel( "models/dav0r/buttons/button.mdl" )
		if self:GetAimBool() then
			projectile:SetPos( self.Owner:GetShootPos()+self.Owner:GetAimVector()*20+(self.Owner:EyeAngles():Up()*-2) )
		else
			projectile:SetPos( self.Owner:GetShootPos()+self.Owner:GetAimVector()*20+(self.Owner:EyeAngles():Right()*3+self.Owner:EyeAngles():Up()*-2) )
		end
		projectile:Spawn()		
		projectile:Activate()
		projectile.PlyEnt = self.Owner
		if self.Projectile == "metro_projectile" then
			projectile:SetPlyEnt(self.Owner)
		end
		projectile.Damage = 3+(dmg*(self:GetCharge()*0.01))
		projectile.Gravity = self.ProjectileGravity
		projectile:SetAngles(self.Owner:GetAimVector():Angle())
		projectile:GetPhysicsObject():ApplyForceCenter( (Vector(0,0,15)*self:GetCharge()*0.01) + self.Owner:GetAimVector()*(self.ProjectileBasicForce+(self.ProjectileChargedForce*self:GetCharge())))
		
	end
	
	--self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	--self.Owner:SetAnimation(PLAYER_ATTACK1)
end

function SWEP:CanPrimaryAttack()

	if self:GetNextPrimaryFire() > CurTime() then return end

	if self:Clip1() <= 0 and self:Clip1() <= 1 then
			if self.Weapon:Ammo1() > 0 then
				self:Reeload()
			else
				self:DryFire()
				self:SetNextPrimaryFire( CurTime() + 0.3 )
				self:SetNextSecondaryFire( CurTime() + 0.3 )		
			end
		return false
 
	end
 
	return true
end

function SWEP:DryFire()
	--if SERVER then
		self:EmitSound(self.DryFireSound)
	--	self.Weapon:SendWeaponAnim(ACT_VM_DRYFIRE)
	--	self.idledelay = CurTime() + self:SequenceDuration()
	--end
end

local near_wall_dist = 0

function SWEP:NearWall()
if self.Owner:IsNPC() or !self.Owner:IsValid() then return end
near_wall_dist = self.Owner:GetShootPos():Distance(self.Owner:GetEyeTrace().HitPos)
	if near_wall_dist <= 35 and !self.Owner:GetEyeTrace().Entity:IsPlayer() and !self.Owner:GetEyeTrace().Entity:IsNPC() then
	return true end
end

SWEP.NearWallAng = Vector(0, 3, 15)
SWEP.NearWallPos = Vector(0, 0, 0)

local Mul = 0
local NearWallMul = 0

local att_ang = Angle(0,0,0)
local att_pos = Vector(0,0,0)
local tst = 0
local aimlerp = 0
local unaim_lerp = 0

local runmul = 0

local zatvor_vec = Vector(0,0,0)
local recoil = 0

local vm_roll = 0
local lean_f = 0

SWEP.ZatvorVector = Vector(0, 0, -3)

function SWEP:GayAttack(arg)
	zatvor_vec = self.ZatvorVector
	recoil = 0.6
end

local old_ang = Angle(0,0,0)
local new_ang = Angle(0, 0, 0)

local menu_lerp = 0

local ironpos = Vector(0,0,0)
local ironang = Angle(0,0,0)

SWEP.curscope = nil

local sense_mod = 1

SWEP.add_fov = 0
SWEP.rt_ang = Angle(0,0,0)

function SWEP:GetViewModelPosition( pos, ang )

local FT = FrameTime()
local pitch = self.Owner:EyeAngles().pitch
local add_fov = self.add_fov
	
	local vel = math.Clamp(self.Owner:GetVelocity():LengthSqr()*0.00002, -1.3, 1.3)
	
		if self:GetAimBool() then
			vel = vel*0.5
		else
			vel = vel
		end
	
		ang:RotateAroundAxis( ang:Right(), (self.RunAng.x*runmul) + (ironang.x * aimlerp) - (new_ang.p*(aimlerp*0.9)) - 2*lean_f + (self.AttAng.x * menu_lerp) + (vel*math.sin( CurTime()*12 )*unaim_lerp) )
		ang:RotateAroundAxis( ang:Up(), (self.RunAng.y*runmul) + (ironang.y * aimlerp) - (new_ang.y*(-aimlerp*0.9)) + (self.AttAng.y * menu_lerp) )
		ang:RotateAroundAxis( ang:Forward(), (self.RunAng.z*runmul) + (ironang.z * aimlerp) - (new_ang.y/2) + (vel*4*vm_roll) + (self.AttAng.z * menu_lerp) - (new_ang.y*unaim_lerp) - (vel*0.1*lean_f) + (vel*math.sin( CurTime()*6 )*unaim_lerp) )
		
		self.rt_ang = ang
		
	if self.Owner:OnGround() then
	
	end
	--vel = vel*0.7
	pos = pos+(ang:Forward()*-4*NearWallMul + ang:Forward()*(0.2*math.sin( CurTime()*0.2 ))*unaim_lerp)+( (ang:Right()*(vel*math.sin( CurTime()*6 ) + (0.2*math.sin( CurTime()*1 ))*unaim_lerp))+(ang:Up()*(vel*0.5*math.sin( CurTime()*-12 )+(0.2*math.sin( CurTime()*2 ))*unaim_lerp)) )*(0.4-aimlerp/4)
	pos = pos+(ang:Right()*((ironpos.x*aimlerp)+(new_ang.y*(0.5-aimlerp*0.3))))+(ang:Forward()*((ironpos.y*aimlerp)-5*recoil))+(ang:Up()*(ironpos.z*aimlerp+(new_ang.p*(0.5-aimlerp*0.3))))
	pos = pos+( ang:Right()*(self.AttPos.x*menu_lerp) + ang:Forward()*(self.AttPos.y*menu_lerp) + ang:Up()*(self.AttPos.z*menu_lerp))
	
	pos = pos + ang:Forward()*self.ForwardMod
	
	return pos, ang

end

local newang = Angle(0,0,0)
local zeroang = Angle(0,0,0)
local zeropos = Vector(0,0,0)
local clamped = 0

SWEP.AimFovMod = 0

function SWEP:TranslateFOV( current_fov )
	local add_fov = self.add_fov
	self.ViewModelFOV = 50-(((add_fov/8)+self.AimFovMod/5)*aimlerp)
	return current_fov-((self.IronsightZoom+add_fov)*aimlerp)
end

SWEP.AimMouseSensetivity = 0.5

function SWEP:AdjustMouseSensitivity()
	
	if !self:GetAimBool() then 
		sense_mod = 1 
		else
		sense_mod = self.AimMouseSensetivity
	end
	
	return sense_mod

end

function SWEP:CalcView( ply, pos, ang, fov ) 

	if !CLIENT then return end
	
	local FT = FrameTime()
	
	local vm = ply:GetViewModel()
	
	--PrintTable(vm:GetBodyGroups())
	
		if (self:NearWall() or (!self.Owner:OnGround() and !self:GetAimBool() ) ) and self:GetNextReload() < CurTime() then
			NearWallMul = Lerp(FT*10, NearWallMul, 1)
		else
			NearWallMul = Lerp(FT*10, NearWallMul, 0)
		end
	
	if self.curscope == nil then
		if self.CurrentAttachments["scope"] != nil or self.CurrentAttachments["handguard"] != nil or self.CurrentAttachments["priklad"] != nil then
			if self.CurrentAttachments["scope"] != nil then 
				self.curscope = self.CurrentAttachments["scope"].name 
				if self.OverrideAnims != "default" and self.PossibleAttachments[self.curscope].anim_sight_overrides != nil then	
					ironpos = self.PossibleAttachments[self.curscope].anim_sight_overrides[self.OverrideAnims].IronsightPos
					ironang = self.PossibleAttachments[self.curscope].anim_sight_overrides[self.OverrideAnims].IronsightAng
				else
					ironpos = self.PossibleAttachments[self.curscope].IronsightPos
					ironang = self.PossibleAttachments[self.curscope].IronsightAng
				end
			else
				if self.CurrentAttachments["handguard"] != nil and self.CurrentAttachments["priklad"] == nil then
					self.curscope = self.CurrentAttachments["handguard"].name 
				elseif self.CurrentAttachments["priklad"] != nil then
					if self.PossibleAttachments[self.CurrentAttachments["priklad"].name].IronsightPos != nil then
						self.curscope = self.CurrentAttachments["priklad"].name 
					elseif self.CurrentAttachments["handguard"] != nil then
						self.curscope = self.CurrentAttachments["handguard"].name
					end
				end
				if self.curscope != nil then
					ironpos = self.PossibleAttachments[self.curscope].IronsightPos
					ironang = self.PossibleAttachments[self.curscope].IronsightAng	
				end
			end
		else
			ironpos = self.IronsightPos
			ironang = self.IronsightAng		
		end
	end
	
	if self:GetAimBool() and self:GetNextReload() < CurTime() then
		aimlerp = Lerp(FT*10, aimlerp, 1)
		unaim_lerp = Lerp(FT*10, unaim_lerp, 0)
	else
		aimlerp = Lerp(FT*10, aimlerp, 0)	
		unaim_lerp = Lerp(FT*10, unaim_lerp, 1)
	end
	
	if self.InMenu then
		menu_lerp = Lerp(FT*10, menu_lerp, 1)
	else
		menu_lerp = Lerp(FT*10, menu_lerp, 0)
	end
	
    local ang_delta = self.Owner:EyeAngles() - old_ang
    old_ang = self.Owner:EyeAngles()
    new_ang = LerpAngle( FT*6, new_ang, ang_delta )
	
	new_ang.p = math.Clamp(new_ang.p, -3, 3)
	new_ang.y = math.Clamp(new_ang.y, -4, 4)
	new_ang.r = math.Clamp(new_ang.r, -3, 3)
	
	recoil = Lerp(FT*10, recoil, 0)
	
		if (self:GetRunning() or self:GetSafe()) and self:GetNextReload() < CurTime() then
			runmul = Lerp(FT*10, runmul, 1)
		else
			runmul = Lerp(FT*10, runmul, 0)		
		end
		
		if self.Owner:KeyDown( IN_MOVERIGHT ) then
			vm_roll = Lerp(FT*10, vm_roll, 1)
		elseif self.Owner:KeyDown( IN_MOVELEFT ) then
			vm_roll = Lerp(FT*10, vm_roll, -1)
		else
			vm_roll = Lerp(FT*10, vm_roll, 0)
		end
		
		if self.Owner:KeyDown( IN_FORWARD ) and self.Owner:OnGround() and self:GetNextPrimaryFire() < CurTime() and !self:NearWall() and !self:GetRunning() and !self:GetAimBool() then
			lean_f = Lerp(FT*10, lean_f, 1)
		else
			lean_f = Lerp(FT*10, lean_f, 0)
		end
	
	ang = ang * 1
	
	if self:GetNextReload()-0.2 >= CurTime() then
		newang = LerpAngle(FrameTime()*25, newang, (ang-att_ang)*0.1)
	else
		newang = LerpAngle(FrameTime()*5, newang, zeroang)
	end
	
	ang:RotateAroundAxis( ang:Right(), (newang.p*0.8)*-1*self.ReloadBobMul )
	
	--===========sick fixes===========--
	clamped = Lerp(FrameTime()*10, clamped, math.Clamp(newang.y, -1, 1))
	
	ang:RotateAroundAxis( ang:Up(), clamped*self.ReloadBobMul)
	ang:RotateAroundAxis( ang:Forward(), ((newang.p + newang.r) * 0.1)*self.ReloadBobMul)
	
	fov = fov-self:GetRecoil()--((self.IronsightZoom+add_fov)*aimlerp)
	--pos = pos + (ang:Forward()*add_fov)*aimlerp
	
	--print(bone)
	return pos, ang, fov

end

local toytownlerp = 0

function SWEP:DrawHUDBackground()

	local FT = FrameTime()

	if self.Owner:OnGround() then
		toytownlerp = Lerp(FT*5, toytownlerp, 0)
	else
		toytownlerp = Lerp(FT*5, toytownlerp, 1)
	end
	
	if toytownlerp > 0.05 then
		DrawToyTown( 2*toytownlerp, ScrH()/2.5 )
	end
	
end

SWEP.ChargeStrelkaMul = 2.7

SWEP.last_strelka = 0
SWEP.strelka_pos = Angle(0,0,0)

SWEP.strelka_pos2 = Vector(1,1,1)

SWEP.StrelkaSinMul = 1

SWEP.strelka_delay = 0
SWEP.strelka_sin_mul = 0

SWEP.strelka = nil

SWEP.zatvor = nil

SWEP.MaxMagGroup = 0

function SWEP:DrawHUD()
	self:Crosshair()
	
	local FT = FrameTime()
	
	local vm = self.Owner:GetViewModel()
	local att = vm:GetAttachment(1)
	
	if self.UseZatvorBone then
	
		if self.zatvor == nil then
			self.zatvor = vm:LookupBone(self.ZatvorBone)
		end
		
		zatvor_vec = LerpVector(FrameTime()*30, zatvor_vec, zeropos)
		vm:ManipulateBonePosition(self.zatvor, zatvor_vec)
		
	end

	if self.Chargeable and self.ChargeStrelkaBone != nil then
	
		if self.strelka == nil then
			self.strelka = vm:LookupBone(self.ChargeStrelkaBone)
		end
		
		--if self:GetCharge() >= 100 then
		--	strelka_pos.y = self:GetCharge()*self.ChargeStrelkaMul + math.random(-0.1, 5)
		--end
		
		--strelka_pos.y = strelka_pos.y-self.StrelkaOffset
		
		if self.last_strelka != self:GetCharge() then
			self.strelka_delay = CurTime() + 0.1
			self.last_strelka = self:GetCharge()
		else
			if self.strelka_delay > CurTime() then
				self.strelka_sin_mul = Lerp(FT*5, self.strelka_sin_mul, 1*self.StrelkaSinMul)
			else
				self.strelka_sin_mul = Lerp(FT*5, self.strelka_sin_mul, 0)
			end
		end
		
		if !self.ChargeStrelkaUseScale then
			self.strelka_pos.y = Lerp(FT*10, self.strelka_pos.y, (((self:GetCharge()+(100*math.sin( CurTime()*15 )*self.strelka_sin_mul))*self.ChargeStrelkaMul)-self.StrelkaOffset))
		
			vm:ManipulateBoneAngles(self.strelka, self.strelka_pos)
		else
			self.strelka_pos2.y = Lerp(FT*10, self.strelka_pos2.y, (self:GetCharge()*0.01))
		
			vm:ManipulateBoneScale(self.strelka, self.strelka_pos2)
		end
	end
	
	if att then
		att_ang = att.Ang
		att_pos = att.Pos
	end
	
end

function SWEP:Crosshair()

end

local srface = surface

function SWEP:PrintWeaponInfo( x, y, alpha )

	if ( self.DrawWeaponInfoBox == false ) then return end

	if (self.InfoMarkup == nil ) then
		local str
		local title_color = "<color=230,230,230,255>"
		local text_color = "<color=150,150,150,255>"
		
		str = "<font=HudSelectionText>"
		if ( self.Author != "" ) then str = str .. title_color .. "Author:</color>\t"..text_color..self.Author.."</color>\n" end
		if ( self.Contact != "" ) then str = str .. title_color .. "Contact:</color>\t"..text_color..self.Contact.."</color>\n\n" end
		if ( self.Purpose != "" ) then str = str .. title_color .. "Purpose:</color>\n"..text_color..self.Purpose.."</color>\n\n" end
		if ( self.Instructions != "" ) then str = str .. title_color .. "Instructions:</color>\n"..text_color..self.Instructions.."</color>\n" end
				-- Moar info --
		str = str .. title_color .. "Caliber:</color>\t"..text_color..self.Primary.Ammo.. "</color>\n"
		str = str .. title_color .. "Clip capacity:</color>\t"..text_color..self.Primary.ClipSize.."</color>\n"
		str = str .. "</font>"
		
		self.InfoMarkup = markup.Parse( str, 250 )
	end
	
	srface.SetDrawColor( 60, 60, 60, alpha )
	srface.SetTexture( self.SpeechBubbleLid )
	
	srface.DrawTexturedRect( x, y - 64 - 5, 128, 64 ) 
	draw.RoundedBox( 8, x - 5, y - 6, 260, self.InfoMarkup:GetHeight() + 18, Color( 60, 60, 60, alpha ) )
	
	self.InfoMarkup:Draw( x+5, y+5, nil, nil, alpha )
	
end

function SWEP:OnRestore()

	self.NextSecondaryAttack = 0
	
end

function SWEP:Holster(wep)
local vm = self.Owner:GetViewModel()
	if not IsFirstTimePredicted() then return end
	if self:IsValid() and self.Owner:IsValid() and IsValid(vm) then
		
		if IsValid(wep) and self:GetNextPrimaryFire() < CurTime() and !self:GetHolster() then
			self.idledelay = nil
			self:PlayAnim("holster")
			self:SetNextReload( CurTime() + vm:SequenceDuration() )
			self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration() )
			self:SetNextSecondaryFire(CurTime() + vm:SequenceDuration() )
			self:SetHolster(true)
			self:EmitSound(self.HolsterSound, 100, 100)
			self:SetHolsterDelay( CurTime() + vm:SequenceDuration() )
			if SERVER then self.ChangeTo = wep:GetClass() end
		elseif self:GetHolster() and self:GetHolsterDelay() <= CurTime() then
			if SERVER then self.ChangeTo = nil end
			return true
		end
	end
	return false
end

function SWEP:PreDrawViewModel(vm, wep, ply)

end

SWEP.SilencerForwardMod = 0

function SWEP:ViewModelDrawn(vm)

	local FT = FrameTime()
	
	for k, v in pairs(self.CurrentAttachments) do
		
		if not v then return end
		if v.attdata == nil then v.attdata = all_attachments[v.name] end
		
		if v.attdata.visible then

			if v.cmodel == nil then
			
				v.cmodel = ClientsideModel(v.attdata.model, RENDERGROUP_BOTH)
				v.cmodel:SetNoDraw( true )
				
			else
				local data = self.PossibleAttachments[v.name]
				local bone = vm:LookupBone(data.bone)
				
				if not bone then
					return
				end
				
				--local m = vm:GetBoneMatrix(bone)
				--local newpos, newang = Vector(0,0,0), Angle(0,0,0)
				--if (m) then
				--	newpos, newang = m:GetTranslation(), m:GetAngles()
				--end
				local newpos, newang = vm:GetBonePosition(bone)
				newpos = ( newpos + newang:Forward() * data.pos.x + newang:Right() * data.pos.y + newang:Up() * data.pos.z )
				
				if v.attdata.atype == "silencer" then
					newpos = (newpos + newang:Up() * self.SilencerForwardMod )
				end
				
				v.cmodel:SetPos( newpos )
				
				newang:RotateAroundAxis(newang:Up(), data.ang.y)
				newang:RotateAroundAxis(newang:Right(), data.ang.p)
				newang:RotateAroundAxis(newang:Forward(), data.ang.r)
				
				if v.attdata.cl_data.drawfunc != nil then
					v.attdata.cl_data.drawfunc(self, newpos, newang, v.cmodel)
				end
				--v.cmodel:SetPos( newpos )
				v.cmodel:SetModelScale( data.size )
				v.cmodel:SetAngles( newang )
				v.cmodel:SetupBones()
				v.cmodel:DrawModel()
				
			end
			
		end
	end

end

SWEP.DefaultClipSize = 0
SWEP.SpecialBool = false

function SWEP:SharedStats(data, add)
	--PrintTable(data)
	if CLIENT then self.curscope = nil end
	
	self.idledelay = 0
	
	if add then
	
		if data.bodygroup then 
			self:SetAttachmentBodygroup(data.bodygroup.a, data.bodygroup.b)
		end
	
		if data.recoil != nil then self.Primary.Recoil = self.Primary.Recoil + data.recoil end
		if data.dispersion != nil then self.Primary.Cone = self.Primary.Cone + data.dispersion end
		if data.conemul != nil then self.SightsConeMul = self.SightsConeMul + data.conemul end
		
		if data.damage != nil then self.Primary.Damage	= self.Primary.Damage + data.damage end
		
		if data.clipsize != nil then 
			if SERVER then self:Unload() end 
			if self.DefaultClipSize == 0 then self.DefaultClipSize = self.Primary.ClipSize end 
			self.Primary.ClipSize = data.clipsize 
		end
	
		if data.anims != nil then self.OverrideAnims = data.anims end
		
		if data.take_ammo != nil then self.Primary.TakeAmmo = self.Primary.TakeAmmo + data.take_ammo end
		if data.reloading_speed != nil then self.ReloadPlayback = self.ReloadPlayback + data.reloading_speed end
		if data.deploy_speed != nil then self.DeployPlayback = self.DeployPlayback + data.deploy_speed end
		
		if data.firing_speed != nil then self.Primary.Delay = self.Primary.Delay + data.firing_speed end
		
		if data.dmg_distance != nil then self.MaxDamageDist = self.MaxDamageDist + data.dmg_distance end
		
		if data.aim_sense != nil then self.AimMouseSensetivity = data.aim_sense end
		
		if data.aim_fov_mod != nil then self.AimFovMod = self.AimFovMod + data.aim_fov_mod end
		
		if data.set_chargeable != nil then self.Chargeable = data.set_chargeable end
		
		if data.set_automatic != nil then self.Primary.Automatic = data.set_automatic end
		
		if data.max_bullet_group != nil then self.MaxMagGroup = data.max_bullet_group end
		
		if data.auto_reload != nil then self.AutoReload = data.auto_reload end
		
		if data.enable_mag_groups != nil then self.UseMagBulletsBodyroup = data.enable_mag_groups end
		
		if data.reload_ammo_delay != nil then self.ReloadAmmoDelay = self.ReloadAmmoDelay + data.reload_ammo_delay end
		
		if data.charge_take != nil then self.ChargeTake = self.ChargeTake + data.charge_take end
		
		if data.special_bool != nil then self.SpecialBool = data.special_bool end
		if data.barrel_length != nil then self.SilencerForwardMod = self.SilencerForwardMod + data.barrel_length end 
		
	else
	
		if data.bodygroup then 
			self:SetAttachmentBodygroup(data.bodygroup.a, 0)
		end
	
		if data.dispersion != nil then self.Primary.Cone = self.Primary.Cone - data.dispersion end
		if data.recoil != nil then self.Primary.Recoil = self.Primary.Recoil - data.recoil end
		if data.conemul != nil then self.SightsConeMul = self.SightsConeMul - data.conemul end
		
		if data.damage != nil then self.Primary.Damage	= self.Primary.Damage - data.damage end
		
		if data.clipsize != nil then 
			if SERVER then self:Unload() end 
			self.Primary.ClipSize = self.DefaultClipSize 
		end
		
		if data.anims != nil then 
			if data.required_att != nil then
				self.OverrideAnims = all_attachments[data.required_att].anims
			else
				self.OverrideAnims = "default" 
			end
		end
		
		if data.take_ammo != nil then self.Primary.TakeAmmo = self.Primary.TakeAmmo - data.take_ammo end
		if data.reloading_speed != nil then self.ReloadPlayback = self.ReloadPlayback - data.reloading_speed end
		if data.deploy_speed != nil then self.DeployPlayback = self.DeployPlayback - data.deploy_speed end
		
		if data.firing_speed != nil then self.Primary.Delay = self.Primary.Delay - data.firing_speed end
		
		if data.dmg_distance != nil then self.MaxDamageDist = self.MaxDamageDist - data.dmg_distance end
		
		if data.aim_sense != nil then self.AimMouseSensetivity = 0.5 end
		
		if data.aim_fov_mod != nil then self.AimFovMod = self.AimFovMod - data.aim_fov_mod end
		
		if data.set_chargeable != nil then self.Chargeable = !data.set_chargeable end
		
		if data.set_automatic != nil then self.Primary.Automatic = !data.set_automatic end
		
		if data.auto_reload != nil then self.AutoReload = !data.auto_reload end
		
		if data.enable_mag_groups != nil then self.UseMagBulletsBodyroup = !data.enable_mag_groups end
		
		if data.reload_ammo_delay != nil then self.ReloadAmmoDelay = self.ReloadAmmoDelay - data.reload_ammo_delay end
		
		if data.charge_take != nil then self.ChargeTake = self.ChargeTake - data.charge_take end
		
		if data.special_bool != nil then self.SpecialBool = !data.special_bool end
		if data.barrel_length != nil then self.SilencerForwardMod = self.SilencerForwardMod - data.barrel_length end 
		
	end
	
end

function SWEP:HasAttInstalled(att)

	local all = self.CurrentAttachments
	
	for a, b in pairs(all) do
		if self.CurrentAttachments[a].name == att then
			return true
		end
	end
	
	return false
	
end

function SWEP:GetInstalledAtt(slot)
	local attachment = "none"
	
	if self.CurrentAttachments[slot] != nil then
		attachment = self.CurrentAttachments[slot].name
	end
	
	return attachment
end

function SWEP:SetClientAttachments(att)

	local data = all_attachments[att]
	
	self.CurrentAttachments[data.atype] = {name = att}
	
	self:SharedStats(data, true)
	
	if data.sights_zoom then self.add_fov = self.add_fov + data.sights_zoom end
	if data.enable_rendertarget then self.RTSight = true end
	if data.cl_data and data.cl_data.rtfunc then self.rtfunc = data.cl_data.rtfunc end
    
end

function SWEP:ClearAttachment(k)

	if self.CurrentAttachments[k] == nil then return end
	
	local data = all_attachments[self.CurrentAttachments[k].name]
	
	if data.sights_zoom then self.add_fov = self.add_fov - data.sights_zoom end
	
	self:SharedStats(data, false)
	if data.enable_rendertarget then self.RTSight = false end
    
	if data.cl_data and data.cl_data.rtfunc then self.rtfunc = nil end
    
	self.CurrentAttachments[k] = nil
	
end

function SWEP:SetServerAttachments(att)

	local data = all_attachments[att]
	
	if data.atype == "mag" then self:Unload() end
	if data.atype == "silencer" then self:SetSilencer( true ) end
	
	self:SharedStats(data, true)
	
end

function SWEP:SvClearAttachment(atype)
	
	if self.CurrentAttachments[atype] == nil then return end
	
	local data = all_attachments[self.CurrentAttachments[atype].name]
	local name = self.CurrentAttachments[atype].name
	
	for k, v in pairs(self.CurrentAttachments) do
		if k == atype then
			if self.PossibleAttachments[v.name].second_attachment != nil then
				self:SvClearAttachment(all_attachments[self.PossibleAttachments[v.name].second_attachment].atype)
			end
		end
		if all_attachments[v.name] != nil and all_attachments[v.name].required_att != nil and all_attachments[v.name].required_att == name then
			self:SvClearAttachment(k)
		end
	end
	
	self:SharedStats(data, false)
	
	self.CurrentAttachments[atype] = nil
	self:CallOnClient("ClearAttachment", atype)
	
	if data.atype == "silencer" then self:SetSilencer( false ) end
	
	if data.atype == "mag" then 
		for k, v in pairs(self.PossibleAttachments) do
			if v.default and all_attachments[k].atype == "mag" then
				local data2 = all_attachments[k]		
				self.CurrentAttachments[data2.atype] = {name = k}
				self:SetServerAttachments(k)
				self:CallOnClient("SetClientAttachments", k)
			end
		end
	end
	
end

if SERVER then

	function SWEP:AttUpd(atype, att)
		self:SvClearAttachment(atype)
		self.CurrentAttachments[all_attachments[att].atype] = {name = att}
		self:SetServerAttachments(att)
		self:CallOnClient("SetClientAttachments", att)	
	end

	net.Receive( "SetAttachment", function( len, ply )
	
		local atype = net.ReadString()
		local att = net.ReadString()

		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) then return end
		
		local inv = ply:GetCharacter():GetInventory()
		
		if att != "none" then
				
			if all_attachments[att].required_att != nil then
				if !wep:HasAttInstalled(all_attachments[att].required_att) then
					return
				end
			end

			if ( (inv:GetItemCount(all_attachments[att].item) > 0) or atype == "mag") and !wep.PossibleAttachments[att].verstak then
				if wep.Base == "metro_base" or wep:GetClass() == "metro_base" then

					wep:AttUpd(atype, att)
					
					if wep.PossibleAttachments[att].second_attachment != nil then
						wep:AttUpd(all_attachments[wep.PossibleAttachments[att].second_attachment].atype, wep.PossibleAttachments[att].second_attachment)
					end
					
				end
			end
		else
			
			wep:SvClearAttachment(atype)
			
		end
		
	end)	

end

print("metro base loaded")
