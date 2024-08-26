
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	
	self.Entity:SetModel( "models/metro_redux/weapons/ognemet/stacionar_ognemet.mdl" )
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	
	--[[	for i = 0, self.Entity:GetBoneCount() do
			print(self.Entity:GetBoneName(i))
		end]]
		
end

ENT.InUse = false
ENT.User = nil

function ENT:Use( activator, caller )

	local ply = activator
	
	if not ply:IsPlayer() then return end
	
	if !self.InUse and (ply.NextMntGunUse == nil or ply.NextMntGunUse < CurTime()) then
		UseMountedGun(ply, self.Entity)
	end
	
end
