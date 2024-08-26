AddCSLuaFile()

ENT.Type = "anim"

ENT.PrintName = "CAMPFIRE"
ENT.Category = "[cmbmtk kitchen]"

ENT.Spawnable = true
ENT.AdminSpawnable = true


function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "Upgrade" )
    self:NetworkVar( "Bool", 0, "Ignite" )
    self:NetworkVar( "Bool", 1, "Cook" )
    self:NetworkVar( "Int", 1, "Progress" )

    self:SetUpgrade(1)
    self:SetIgnite(false)
    self:SetCook(false)
    self:SetProgress(0)
end
