--SWEP.Base				= "tfa_gun_base"
SWEP.Category				= "Warfare Role-Play - Еда нет блять азраельская ебала"
SWEP.Author				= "Akabenko LOH"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.DrawCrosshair			= false
SWEP.DrawCrosshairIS = false
SWEP.PrintName				= "Радиостанция"
SWEP.Slot				= 1
SWEP.SlotPos				= 73
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Weight				= 30
SWEP.Skin = 0

SWEP.DrawAmmo = false
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false

SWEP.UseSound = Sound("weapons/akabenko/broken_radio.ogg")
SWEP.ViewModel	= "models/weapons/akabenko/stcopwep/radio_model.mdl"
SWEP.WorldModel = "models/weapons/akabenko/stcopwep/w_radio_model.mdl"

SWEP.ViewModelFOV			= 50		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = false --Use gmod c_arms system.
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.CenteredPos = nil --The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng = nil --The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.Bodygroups_V = nil	

SWEP.HoldType = "slam"

SWEP.Offset = {
	Pos = {
		Up = -2,
		Right = 3,
		Forward = 4
	},
	Ang = {
		Up = -30,
		Right = 20,
		Forward = 200
	},
	Scale = 1.2
}

SWEP.IsWRBSTALKERWEAPON = true

SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Ammo = nil

SWEP.VMPos = Vector(1, -10, -17)
SWEP.VMAng = Vector(25, 0, 0)

SWEP.CrouchPos = Vector(1, -10, -17)
SWEP.CrouchAng = Vector(25, 0, 0)

--[[SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI
SWEP.Walk_Mode = TFA.Enum.LOCOMOTION_ANI

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "idle_sprint",
		["is_idle"] = true
	}
}

SWEP.WalkAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "idle_moving", 
		["is_idle"] = true
	}
}

SWEP.BaseAnimations = {
	["draw"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "draw"
	},
	["idle"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "idle"
	},
	["holster"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "holster"
	},
}

SWEP.EventTable = {
	["draw"] = {
		{time = 0, type = "sound", value = Sound("weapons/akabenko/generic_draw.wav")},
	},
	["holster"] = {
		{time = 0, type = "sound", value = Sound("weapons/akabenko/generic_holster.wav")},
	},
}
]]
DEFINE_BASECLASS(SWEP.Base)

SWEP.InvItem = nil

function SWEP:GetItem()
	if !self.InvItem or self.InvItem == nil or !IsValid(self.InvItem) then
		local ply = self.Owner
		local inv = ply:GetCharacter():GetInventory()
		local item = inv:HasItem("radio")
		if item then
			self.InvItem = item
		end
	end
	return self.InvItem
end

SWEP.NxtReload = 0

function SWEP:Reload()
	if SERVER then
		if self.NxtReload < CurTime() and !self.Owner:KeyDown(IN_RELOAD) then
			local item = self:GetItem()
			local ply = self.Owner
			if item then
				item:SetData("power", !item:GetData("power", false), nil, nil)
				if item:GetData("power") then
					ply:EmitSound("fosounds/fix/obj/obj_radioknobturn_on.mp3", 30)
				else
					ply:EmitSound("fosounds/fix/obj/obj_radioknobturn_off.mp3", 30)
				end
			end
			self.NxtReload = CurTime() + 0.5
		end
	end
end

function SWEP:PrimaryAttack()
	--if math.random(1,500) == 1 then
		self:EmitSound(self.UseSound)
	--end
	if SERVER then
		local item = self:GetItem()
		if item then
			item:OpenMenu(self.Owner)
		end
	end
end

function SWEP:SecondaryAttack()
end

if CLIENT then

	surface.CreateFont("NumbersDisplayFont", {
		font = "Digital-7",
		extended = true,
		size = 180,
		weight = 1000
	})
	
	--ix3D2DFont
	function SWEP:DrawHUD()
	end

	local matScreen = Material("models/weapons/wick/stcopwep/dirt")
	local RTTexture = GetRenderTarget("55343", 512, 512)

	local bg = surface.GetTextureID("models/weapons/wick/stcopwep/dosimeter_matpose_copy")

	function SWEP:RenderScreen()
		matScreen:SetTexture( "$basetexture", RTTexture )
		render.PushRenderTarget( RTTexture )
		
		cam.Start2D()
			--surface.SetDrawColor( 255, 255, 255, 255 )
			--surface.SetTexture( bg )
			--surface.DrawTexturedRectRotated( -174, -200, 3500, 2800, 90)
				
			--nut.util.drawText("1", 5, 250, Color( 0, 0, 0, 40 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, "wrb_lcd_font")
			--nut.util.drawText("13.357", 15, 280, Color( 0, 0, 0 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, "wrb_lcd_font")
			local item = self:GetItem()
			if item and item:GetData("power", false) == true then
				draw.RoundedBox( 0, 0, 0, 500, 500, Color( 90, 100, 0, 255 ) )
				draw.SimpleText( item:GetData("freq", "000.0"), "NumbersDisplayFont", 256, 145, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
				draw.RoundedBox( 0, 0, 0, 500, 500, Color( 0, 0, 0, 255 ) )
			end
			
		cam.End2D()
		render.PopRenderTarget()
	end
end

function SWEP:GetViewModelPosition(pos, ang)

	ang:RotateAroundAxis( ang:Right(), self.VMAng.x )
	ang:RotateAroundAxis( ang:Up(), self.VMAng.y )
	ang:RotateAroundAxis( ang:Forward(), self.VMAng.z )

	pos = pos+(ang:Right()*self.VMPos.x)+(ang:Forward()*self.VMPos.y)+(ang:Up()*self.VMPos.z)

	return pos, ang

end

function SWEP:PostDrawViewModel(vm, ply, wep)
    if (!IsValid(vm) or !IsValid(wep)) then return end

	--if wep.IsWRBSTALKERWEAPON then

	if not IsValid(self.WRB_STALKER_HANDS) then
		self.WRB_STALKER_HANDS = ClientsideModel("models/weapons/akabenko/stcopwep/wpn_hand_novice.mdl", RENDERGROUP_VIEWMODEL_TRANSLUCENT)
	end

	local WRBSTRP_HANDRIG = self.WRB_STALKER_HANDS

	if vm:LookupBone("r_hand") then
		WRBSTRP_HANDRIG:SetParent(vm)
		WRBSTRP_HANDRIG:AddEffects(EF_BONEMERGE)
		WRBSTRP_HANDRIG:DrawModel()
		WRBSTRP_HANDRIG:SetNoDraw(true)
		return WRBSTRP_HANDRIG
	end
	--end
end
