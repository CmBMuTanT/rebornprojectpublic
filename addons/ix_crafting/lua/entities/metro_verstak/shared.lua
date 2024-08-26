ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "verstak"
ENT.Author = ""
ENT.Category = "metro"
ENT.Spawnable = true
ENT.AdminSpawnable = false

function ENT:Initialize()
	
	self.Entity:SetModel( "models/props_structure/worktable.mdl" )
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	
end

ENT.Delay = 0

function ENT:Use( activator, caller )

	local ply = activator
	
	if not ply:IsPlayer() then return end
	
	if self.Delay < CurTime() then
		
		net.Start( "ixCraftMenu" )
		net.Send(ply)
		
		self.Delay = CurTime() + 0.2
	end
	
end
