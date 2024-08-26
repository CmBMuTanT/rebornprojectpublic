AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Capture Point"
ENT.Category = "[cmbmtk]"
ENT.Spawnable = true

ENT.AdminSpawnable = true
ENT.ShowPlayerInteraction = true
ENT.bNoPersist = true


function ENT:SetupDataTables()
    self:NetworkVar( "Bool", 0, "Capture" )
    self:NetworkVar( "String", 0, "CaptureFraction")

    self:NetworkVar( "Int", 0, "CaptureTime" )
    self:NetworkVar( "Int", 1, "CaptureIncome" )

    local Income = self:GetCaptureIncome()
    local Time = self:GetCaptureTime()

    self:SetCaptureIncome(Income)
    self:SetCaptureTime(Time)
end