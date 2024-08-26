ENT.Type = "anim"

ENT.PrintName = "Mouse Runs"
ENT.Category = "[cmbmtk]"

ENT.Spawnable = true
ENT.AdminSpawnable = true


function ENT:SetupDataTables()
    self:NetworkVar( "Bool", 0, "StartRuns" )

    self:SetStartRuns(false)
end
