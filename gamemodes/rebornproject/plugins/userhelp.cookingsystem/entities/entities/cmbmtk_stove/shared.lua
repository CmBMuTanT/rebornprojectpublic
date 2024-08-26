AddCSLuaFile()

ENT.Type = "anim"

ENT.PrintName = "STOVE"
ENT.Category = "[cmbmtk kitchen]"

ENT.Spawnable = true
ENT.AdminSpawnable = true


function ENT:SetupDataTables()
    self:NetworkVar( "Bool", 0, "Ignite" )
    self:NetworkVar( "Int", 0, "Progress" )

    self:SetIgnite(false)
    self:SetProgress(0)
end