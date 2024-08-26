
SWEP.Category				= "Metro"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "eda"	
	
SWEP.Slot				= 99
SWEP.DrawAmmo				= false		
SWEP.DrawWeaponInfoBox			= false		
SWEP.BounceWeaponIcon   		= 	false	
SWEP.DrawCrosshair			= false			
SWEP.AutoSwitchTo			= true		
SWEP.AutoSwitchFrom			= true		
SWEP.HoldType 				= "slam"		

SWEP.ViewModelFOV			= 75
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/food/vodka/v_vodka.mdl"
SWEP.WorldModel				= ""		
SWEP.ShowWorldModel			= false
SWEP.ShowViewModel = false

SWEP.Primary.ClipSize		= 0
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= 0
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Ammo			= "none"

SWEP.UseHands = false

SWEP.Primary.Automatic		= false
SWEP.Secondary.Automatic	= false

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.CanHolster = false

function SWEP:Deploy()
	if SERVER then
		local ply = self.Owner
		local vm = self.Owner:GetViewModel()
		if ply.foodmodel then
			vm:SetModel(ply.foodmodel)
		end

		local anim = vm:SelectWeightedSequence( ACT_VM_DRAW )

		vm:SendViewModelMatchingSequence( anim )

		self.Weapon:SetNextPrimaryFire(CurTime() + self.Weapon:SequenceDuration())
		self.Weapon:SetNextSecondaryFire(CurTime() + self.Weapon:SequenceDuration())
		
		self:SetHoldType("slam")
		
		self.CanHolster = false
		
		timer.Simple(vm:SequenceDuration(), function()
			if self.Weapon == nil then return end
				self.CanHolster = true
				if self.Owner.last_weapon != nil and self.Owner:HasWeapon(self.Owner.last_weapon) then
					self.Owner:SelectWeapon( self.Owner.last_weapon )
					self.Owner:StripWeapon( "metro_food" ) 
				end
		end)
		
	end

	return true

end

function SWEP:PrimaryAttack()

end

function SWEP:SecondaryAttack()

end

function SWEP:Think()

	if CLIENT then return end

end

function SWEP:Holster()
return self.CanHolster
end
