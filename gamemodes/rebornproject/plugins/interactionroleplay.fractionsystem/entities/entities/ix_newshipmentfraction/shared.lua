AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "New_Shipment"
ENT.Category = "cmbmtk"
ENT.Spawnable = false
ENT.ShowPlayerInteraction = true
ENT.bNoPersist = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "DeliveryTime")
end
