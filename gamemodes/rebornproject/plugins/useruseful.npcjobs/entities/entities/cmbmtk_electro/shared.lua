ENT.Type = "anim"

ENT.PrintName = "NPC JOB GIVER [Electro Work]"
ENT.Category = "[cmbmtk]"

ENT.Spawnable = true
ENT.AdminSpawnable = true


function ENT:SetupDataTables()
    self:NetworkVar( "Bool", 0, "NoDrawIcon" )
end