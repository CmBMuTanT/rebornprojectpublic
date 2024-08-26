ENT.Type = "anim"

ENT.PrintName = "MEGAPHONE"
ENT.Category = "[cmbmtk]"

ENT.Spawnable = true
ENT.AdminSpawnable = true


function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "SoundCategory" ) -- for fraction, dunno
    self:NetworkVar( "Bool", 0, "Enabled" )
end