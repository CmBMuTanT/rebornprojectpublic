AddCSLuaFile()
 
ENT.Type = "anim"
ENT.PrintName = "Mushroom-mohoovik"
ENT.Category = "cmbmtk"
ENT.Spawnable = false
ENT.ShowPlayerInteraction = true
ENT.bNoPersist = true

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "Watered")
end