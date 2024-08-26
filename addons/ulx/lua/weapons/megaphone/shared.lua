-- from incredible-gmod.ru with <3

SWEP.IsMegaphone = true
SWEP.voiceDistanceMultiplayer = 2

SWEP.ViewModel = Model("models/weapons/c_arms_animations.mdl")
SWEP.WorldModel = Model("models/polaroid/camera.mdl")

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ScopeZoom = 0.76

SWEP.Category  	= "Incredible GMod"
SWEP.PrintName	= "Megaphone"
SWEP.Author 	= "Beelzebub"
SWEP.Instructions = "from incredible-gmod.ru with <3"

SWEP.Slot		= 5
SWEP.SlotPos	= 1

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = Model("models/weapons/c_pistol.mdl")
SWEP.WorldModel = Model("models/weapons/w_pistol.mdl")
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.HoldType = "pistol"

SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.Spawnable		= true

SWEP.ShootSound = nil

SWEP.IronSightsPos = Vector(-5.32, -9, 1.1)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector(-5.32, -9, 1.1)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(-5.32, -9, 1.1)
SWEP.RunSightsAng = Vector(0, 0, 0)

local IRONSIGHT_TIME = 0.1

SWEP.VElements = {
	["v_element"] = { type = "Model", model = "models/props_wasteland/coolingtank02.mdl", bone = "ValveBiped.clip", rel = "", pos = Vector(0, -3.017, 1.567), angle = Angle(0, 0, 180), size = Vector(0.03, 0.03, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/xqm/polex1_diffuse", skin = 0, bodygroup = {} },
	["v_element2"] = { type = "Model", model = "models/props_c17/lampShade001a.mdl", bone = "ValveBiped.clip", rel = "", pos = Vector(0, -3.017, 5.774), angle = Angle(0, 0, 180), size = Vector(0.36, 0.36, 0.36), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/xqm/polex1_diffuse", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["w_element2"] = { type = "Model", model = "models/props_c17/lampShade001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(13.072, 2.249, -4.284), angle = Angle(86, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/xqm/polex1_diffuse", skin = 0, bodygroup = {} },
	["w_element"] = { type = "Model", model = "models/props_junk/propane_tank001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.021, 2.249, -3.885), angle = Angle(-94.028, 0, 0), size = Vector(0.5, 0.5, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/xqm/polex1_diffuse", skin = 0, bodygroup = {} },
	["w_element3"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.021, 1.249, -1.885), angle = Angle(-20, 90, 70), size = Vector(0.7, 0.7, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/xqm/polex1_diffuse", skin = 0, bodygroup = {} }
}

function SWEP:PrimaryAttack()
	self.MicEnabled = true
	if CLIENT then
		permissions.EnableVoiceChat(true)
	else
		self.Owner:SetDSP(59)
	end
end

SWEP.SecondaryAttack = SWEP.PrimaryAttack

function SWEP:Initialize()

	self:SetHoldType(self.HoldType)
	self:SetWeaponHoldType(self.HoldType)

	self.ArmYaw = 0
	self.ArmPitch = 0
	self.SmoothYaw = 0
	self.SmoothPitch = 0
	self.Idle = 0
	self.IdleTimer = CurTime() + 1
	self.SpawnedMic = false
	self.TargList={}
	self.MicList={}

	if CLIENT then

		-- Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) -- create viewmodels
		self:CreateModels(self.WElements) -- create worldmodels

		-- init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)

				-- Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					-- we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					-- ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					-- however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")
				end
			end
		end
	end
end

function SWEP:PostReloadScopeCheck()
	if self.Weapon != nil then
	if (self.Owner:KeyDown(IN_ATTACK) or self.Owner:KeyDown(IN_ATTACK2)) and self.Weapon:GetClass() == self.Gun then
		if CLIENT then return end
		self.Owner:SetFOV( 75/self.Secondary.ScopeZoom, 0.15 )
		self.IronSightsPos = self.SightsPos					-- Bring it up
		self.IronSightsAng = self.SightsAng					-- Bring it up
		self.DrawCrosshair = false
		self:SetIronsights(true, self.Owner)
		--self.Owner:DrawViewModel(false)
	elseif self.Owner:KeyDown(IN_SPEED) and self.Weapon:GetClass() == self.Gun then
		if self.Weapon:GetNextPrimaryFire() <= (CurTime()+0.3) then
			self.Weapon:SetNextPrimaryFire(CurTime()+0.3)				-- Make it so you can't shoot for another quarter second
		end
		self.IronSightsPos = self.RunSightsPos					-- Hold it down
		self.IronSightsAng = self.RunSightsAng					-- Hold it down
		self:SetIronsights(true, self.Owner)					-- Set the ironsight true
		self.Owner:SetFOV( 0, 0.2 )
	else return end
	end
end

function SWEP:IronSight()

	if not IsValid(self) then return end
	if not IsValid(self.Owner) then return end

	--if self.Owner:KeyPressed(IN_ATTACK2) then return end

	if (self.Owner:KeyPressed(IN_ATTACK) or self.Owner:KeyPressed(IN_ATTACK2)) then
		self.Owner:SetFOV( 75/self.Secondary.ScopeZoom, 0.15 )
		self.IronSightsPos = self.SightsPos					-- Bring it up
		self.IronSightsAng = self.SightsAng					-- Bring it up
		self.DrawCrosshair = false
		self:SetIronsights(true, self.Owner)
		if CLIENT then return end
		--self.Owner:DrawViewModel(false)
	elseif (self.Owner:KeyPressed(IN_ATTACK) or self.Owner:KeyPressed(IN_ATTACK2)) then
		if self.Weapon:GetNextPrimaryFire() <= (CurTime()+0.3) then
			self.Weapon:SetNextPrimaryFire(CurTime()+0.3)				-- Make it so you can't shoot for another quarter second
		end
		self.IronSightsPos = self.RunSightsPos					-- Hold it down
		self.IronSightsAng = self.RunSightsAng					-- Hold it down
		self:SetIronsights(true, self.Owner)					-- Set the ironsight true
		self.Owner:SetFOV( 0, 0.2 )
	end

	if (self.Owner:KeyReleased(IN_ATTACK) or self.Owner:KeyReleased(IN_ATTACK2)) then
		self.Owner:SetFOV( 0, 0.2 )
		self:SetIronsights(false, self.Owner)
		self.DrawCrosshair = self.XHair
		-- Set the ironsight false
		if CLIENT then return end
		self.Owner:DrawViewModel(true)
	end

	if (self.Owner:KeyDown(IN_ATTACK) or self.Owner:KeyDown(IN_ATTACK2)) then
		self.SwayScale 	= 0.05
		self.BobScale 	= 0.05
	else
		self.SwayScale 	= 0.75
		self.BobScale 	= 1.0
	end
end

function SWEP:GetViewModelPosition(pos, ang)

	if (not self.IronSightsPos) then return pos, ang end

	local bIron = self.Weapon:GetNWBool("Ironsights")

	if (bIron != self.bLastIron) then
		self.bLastIron = bIron
		self.fIronTime = CurTime()
	end

	local fIronTime = self.fIronTime or 0

	if (not bIron and fIronTime < CurTime() - IRONSIGHT_TIME) then
		return pos, ang
	end

	local Mul = 1.0

	if (fIronTime > CurTime() - IRONSIGHT_TIME) then
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)

		if not bIron then Mul = 1 - Mul end
	end

	local Offset    = self.IronSightsPos

	if (self.IronSightsAng) then
		ang = ang * 1
		ang:RotateAroundAxis(ang:Right(),               self.IronSightsAng.x * Mul)
		ang:RotateAroundAxis(ang:Up(),          self.IronSightsAng.y * Mul)
		ang:RotateAroundAxis(ang:Forward(),     self.IronSightsAng.z * Mul)
	end

	local Right     = ang:Right()
	local Up                = ang:Up()
	local Forward   = ang:Forward()

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
end

function SWEP:SetIronsights(b)
	self.Weapon:SetNWBool("Ironsights", b)
end

function SWEP:GetIronsights()
	return self.Weapon:GetNWBool("Ironsights")
end

function SWEP:AdjustMouseSensitivity()
	if (self.Owner:KeyDown(IN_ATTACK) or self.Owner:KeyDown(IN_ATTACK2)) then
		return (1/(self.Secondary.ScopeZoom/1.5))
	else
		return 1
	end
end

function SWEP:Think()
	if SERVER then
		self.SmoothYaw = math.Round(self.SmoothYaw,1) or 0
		self.SmoothYaw = math.Clamp(self.SmoothYaw + (self.ArmYaw - self.SmoothYaw) * 0.12,0,100)

		self.SmoothPitch = math.Round(self.SmoothPitch,1) or 0
		self.SmoothPitch = math.Clamp(self.SmoothPitch + (self.ArmPitch - self.SmoothPitch) * 0.07,0,100)
		if self.MicEnabled == true then
			self.ArmYaw = 10
			self.ArmPitch = 25
		else
			self.ArmYaw = 0
			self.ArmPitch = 0
		end

		self.Owner:ManipulateBoneAngles( self.Owner:LookupBone( "ValveBiped.Bip01_R_Forearm" ), Angle( 0, -self.SmoothYaw*7, -self.SmoothYaw*2 ) )
		self.Owner:ManipulateBoneAngles( self.Owner:LookupBone( "ValveBiped.Bip01_R_UpperArm" ), Angle( -self.SmoothPitch, self.SmoothYaw*2, -self.SmoothYaw*3 ) )
		self.Owner:ManipulateBoneAngles( self.Owner:LookupBone( "ValveBiped.Bip01_R_Hand" ), Angle( -self.SmoothYaw*4, self.SmoothYaw*3, -self.SmoothYaw*1 ) )

		if (self.Owner:KeyReleased(IN_ATTACK) or self.Owner:KeyReleased(IN_ATTACK2)) then
			self:RemoveMic()
		end
	end

	if self.Idle == 0 and self.IdleTimer <= CurTime() then
		if SERVER then
			self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
		end
		self.Idle = 1
	end
	self:IronSight()
end

function SWEP:Holster()
	self.Idle = 0
	self.IdleTimer = CurTime()
	self:RemoveMic()
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	return true
end

function SWEP:Deploy()
	self.TargList={}
	self.MicList={}

	self:SetIronsights(false, self.Owner)
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	self.SpawnedMic = false
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)

	return true
end

function SWEP:RemoveMic()
	self.MicEnabled = false

	if SERVER then
		self.Owner:ManipulateBoneAngles( self.Owner:LookupBone( "ValveBiped.Bip01_R_Forearm" ), Angle( 0, 0, 0 ) )
		self.Owner:ManipulateBoneAngles( self.Owner:LookupBone( "ValveBiped.Bip01_R_UpperArm" ), Angle( 0, 0, 0 ) )
		self.Owner:ManipulateBoneAngles( self.Owner:LookupBone( "ValveBiped.Bip01_R_Hand" ), Angle( 0, 0, 0 ) )

		self.SpawnedMic = false
		for k, v in pairs(self.TargList) do
			if IsValid(v) then
				v:Remove()
			end
		end
		for k, v in pairs(self.MicList) do
			if IsValid(v) then
				v:Remove()
			end
		end
		self.TargList={}
		self.MicList={}

		self.Owner:SendLua("permissions.EnableVoiceChat(false)")
		self.Owner:SetDSP(0)
	end
end

function SWEP:OnDrop()
	self:Holster()
end

function SWEP:OnRemove()
	self:Holster()
end