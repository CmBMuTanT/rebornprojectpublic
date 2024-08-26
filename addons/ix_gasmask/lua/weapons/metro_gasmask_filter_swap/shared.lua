
SWEP.Category				= "Metro Gasmask"
SWEP.Author				= "Hobo_Gus"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "FILTER SWAP"		
SWEP.Slot				= 99				
SWEP.SlotPos				= 23			
SWEP.DrawAmmo				= false		
SWEP.DrawWeaponInfoBox			= false		
SWEP.BounceWeaponIcon   		= 	false	
SWEP.DrawCrosshair			= false			
SWEP.AutoSwitchTo			= true		
SWEP.AutoSwitchFrom			= true		
SWEP.HoldType 				= "normal"		

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/metroll/v_gasmask.mdl"
SWEP.WorldModel				= ""		
SWEP.ShowWorldModel			= false
SWEP.ShowViewModel = false

SWEP.Primary.ClipSize		= 0
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= 0
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Ammo			= "none"

SWEP.UseHands = true

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.HolsterT = false

local punch = false

function SWEP:Deploy()
	punch = false
	self.Owner:SetNWInt("checkfilter", CurTime() + 5)
	
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )--ACT_VM_FIDGET
	self.Owner:EmitSound("gasmask/change_filter.wav")
	self.Owner:ViewPunch( Angle( -2,0,0 ) )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	
	self:SetHoldType( self.HoldType )	

	self.HolsterT = false

	--self.Owner:SetNWInt( "breathholdtime_hg", self.BreathHoldingTime )
	timer.Simple(0.6, function() self.Owner:ViewPunch( Angle( 1,0,0 ) ) end)
	timer.Simple(0.98, function() punch = true if SERVER then self.Owner:SetNWInt("FilterDuration", 240) end end)
	timer.Simple(self:SequenceDuration(), function()
		if self.Weapon == nil then return end
			self.Owner:EmitSound("gasmask/watch_timer_set.wav")
			if SERVER then
				self.HolsterT = true
				if self.Owner.gasmask_lastwepon != nil and self.Owner:HasWeapon(self.Owner.gasmask_lastwepon) then
					self.Owner:SelectWeapon( self.Owner.gasmask_lastwepon )
					self.Owner:StripWeapon( "metro_gasmask_filter_swap" ) 
				end
			end
	end)
	
	local ply = self.Owner
	
	return true
end

function SWEP:Think()
	if punch == true then
		self.Owner:SetViewPunchAngles( Angle(0,0,math.sin(CurTime()*10)) ) 
	end
end

function SWEP:Holster()
return self.HolsterT
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end
