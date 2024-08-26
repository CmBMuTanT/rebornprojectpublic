local PLUGIN = PLUGIN

include('shared.lua')


ENT.NeedDirt = false
ENT.PopulateEntityInfo = true

function ENT:Initialize()
    if self.NeedDirt then
        self.Dirt=ClientsideModel("models/props_c17/streetsign004e.mdl")
        self.Dirt:SetNoDraw(true)
        self.Dirt:SetParent(self)
    end
end

function ENT:Draw()
    self:DrawModel()

    if self.NeedDirt then
        local Pos=self:GetPos()
        self.Dirt:SetRenderOrigin(Pos)
        self.Dirt:SetRenderAngles(Angle(0, 0, 90))
        self.Dirt:DrawModel()
    end
end

function ENT:OnPopulateEntityInfo(container)
    local name = container:AddRow("name")
    name:SetImportant()
    name:SetText("Трюфель")
    name:SizeToContents()

    if self:GetWatered() then
            if self:GetModelScale() >= 1 then
                local description = container:AddRow("description")
                description:SetText("Созревший трюфель")
                description:SetBackgroundColor(Color(0, 255, 0))
                description:SizeToContents()
            else
                local description = container:AddRow("description")
                description:SetText("Трюфель который растет.")
                description:SetBackgroundColor(Color(255, 255, 0))
                description:SizeToContents()
            end
        else
            local description = container:AddRow("description")
            description:SetText("Трюфелю необходима вода.")
            description:SetBackgroundColor(Color(255, 0, 0))
            description:SizeToContents()
    end
end