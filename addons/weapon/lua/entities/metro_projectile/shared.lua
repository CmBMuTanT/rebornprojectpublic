ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "metro projectile"
ENT.Author = ""
ENT.Category = "METRO"
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.DrawModel = false

function ENT:SetupDataTables()

	self:NetworkVar( "Entity", 0, "PlyEnt" )

	self:SetPlyEnt(nil)
	
end
