ENT.Base = "base_ai"
ENT.Type = "ai"

ENT.PrintName = "NPC PASSPORT SYSTEM"
ENT.Category = "[cmbmtk]"

ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
    self:NetworkVar( "String", 0, "RegistrationString" ) -- for fraction, dunno
    self:NetworkVar( "String", 1, "RegistrationImage" )
end