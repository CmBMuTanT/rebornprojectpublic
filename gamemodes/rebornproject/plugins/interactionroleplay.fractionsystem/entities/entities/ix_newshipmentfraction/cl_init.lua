local PLUGIN = PLUGIN

include('shared.lua')

ENT.PopulateEntityInfo = true

local size = 150
local tempMat = Material("particle/warp1_warp", "alphatest")

function ENT:Draw()
    local pos, ang = self:GetPos(), self:GetAngles()

    self:DrawModel()

    pos = pos + self:GetUp() * 25
    pos = pos + self:GetForward() * 1
    pos = pos + self:GetRight() * 3

    local delTime = math.max(math.ceil(self:GetDeliveryTime() - CurTime()), 0)

    local func = function()
        surface.SetMaterial(tempMat)
        surface.SetDrawColor(0, 0, 0, 200)
        surface.DrawTexturedRect(-size / 2, -size / 2 - 10, size, size)

        if delTime != 0 then
            ix.util.DrawText("k", 0, 0, color_white, 1, 4, "ixIconsBig")
            ix.util.DrawText(delTime, 0, -10, color_white, 1, 5, "ixBigFont")
        else
            ix.util.DrawText("3", 0, 0, color_white, 1, 4, "ixIconsBig")
            ix.util.DrawText("PUBLIC", 0, -10, color_white, 1, 5, "ixBigFont")
        end
    end

    cam.Start3D2D(pos, ang, .15)
        func()
    cam.End3D2D()

    ang:RotateAroundAxis(ang:Right(), 180)
    pos = pos - self:GetUp() * 26

    cam.Start3D2D(pos, ang, .15)
        func()
    cam.End3D2D()
end

function ENT:OnPopulateEntityInfo(container)
    local owner = ix.char.loaded[self:GetNetVar("owner", 0)] or ix.faction.indices[self:GetNetVar("faction", nil)]

    
    local ownername = owner.name or owner:GetName()

    local name = container:AddRow("name")
    name:SetImportant()
    name:SetText(L("shipment"))
    name:SizeToContents()

    if (owner) then
        if !self:GetNetVar("Public") then
            local description = container:AddRow("description")
            description:SetText(L("shipmentDesc", ownername))
            description:SizeToContents()
        else
            local description = container:AddRow("description")
            description:SetText("Этот товар стал общедоступным!")
            description:SizeToContents()
        end
    end
end