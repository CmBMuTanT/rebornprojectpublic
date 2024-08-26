include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:OnPopulateEntityInfo(container)
	local name = container:AddRow("name")
	name:SetImportant()
	name:SetText("Стационарная радиостанция")
	name:SizeToContents()
end

function ENT:Initialize()

end

function ENT:Think()

end
