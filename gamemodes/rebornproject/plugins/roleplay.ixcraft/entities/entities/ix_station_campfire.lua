
local PLUGIN = PLUGIN

ENT.Type = "anim"
ENT.PrintName = "Обогревочная станция"
ENT.Category = "[Helix] Stations"
ENT.uniqueID = "ix_station_campfire"
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "StationID")

	if (SERVER) then
		self:NetworkVarNotify("StationID", self.OnVarChanged)
	end
end

if (SERVER) then
	function ENT:Initialize()
		if (!self.uniqueID) then
			self:Remove()

			return
		end

		self:SetModel("models/props_c17/FurnitureFireplace001a.mdl")
		self:SetStationID(self.uniqueID)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end

	function ENT:OnVarChanged(name, oldID, newID)
		local stationTable = PLUGIN.craft.stations[newID]

		if (stationTable) then
			self:SetModel(stationTable:GetModel())
		end
	end

	function ENT:UpdateTransmitState()
		return TRANSMIT_PVS
	end
else
	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(tooltip)
		-- local stationTable = self:GetStationTable()

		-- if (stationTable) then
		-- 	PLUGIN:PopulateStationTooltip(tooltip, stationTable)
		-- end

		local name = tooltip:AddRow("name")
        name:SetImportant()
        name:SetText(self.PrintName)
        name:SizeToContents()
	end

	function ENT:Draw()
		self:DrawModel()
	end
end

function ENT:GetStationTable()
	return PLUGIN.craft.stations[self:GetStationID()]
end
