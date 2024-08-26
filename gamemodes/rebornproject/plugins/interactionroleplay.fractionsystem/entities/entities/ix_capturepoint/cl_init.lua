include("shared.lua")
local PLUGIN = PLUGIN


--local circle = PLUGIN.Circles.New(CIRCLE_OUTLINED, 256, 0, 0, 6)

local alpha = 0
local speed = 5

surface.CreateFont("CaptureFont", {font = "roboto", extended = true, size = 40, weight = 500})
local function textPlate(text,data, datatw,y)  
    surface.SetFont("CaptureFont")  
    local tw,th = surface.GetTextSize(text)  
    local bx,by = -tw / 2 - 10, y - 5  
    local bw,bh = tw + 10 + 10, th + 10 + 10
    surface.SetDrawColor(Color(0,0,0,150))  
    surface.DrawRect(bx,by, bw,bh * 2.3)  
    surface.SetDrawColor(Color(255,255,255) )  
    surface.DrawRect(bx, by + bh + 28, bw, 4)  

    surface.SetTextColor(Color(255,255,255) )  
    surface.SetTextPos(-tw / 2,y)  
    surface.DrawText(text) 

    surface.SetTextColor(Color(255,255,255) )  
    surface.SetTextPos(-tw / 2,by * .7)  
    surface.DrawText(data) 

    surface.SetTextColor(Color(255,255,255) )  
    surface.SetTextPos((bx - bx) - 48,by * .38)  
    surface.DrawText(datatw) 
end  

function ENT:Draw()
    local circle = PLUGIN.Circles.New(CIRCLE_OUTLINED, 256, 0, 0, 6)
    self:DrawModel()
    local pos = self:GetPos()
    --local ang = self:LocalToWorldAngles(Angle(0, 0, 0))
   -- render.DrawWireframeSphere(pos, 256, 128, 128, Color(255, 255, 255), 1)

    if (halo.RenderedEntity() ~= self) then
        circle:SetMaterial(true)

        if self:GetCapture() then
            alpha = 127 + 127 * math.sin(CurTime() * speed)
            circle:SetColor(Color(255, 255, 0, alpha))
        elseif self.playerCount >= 5 then
            circle:SetColor(Color(0, 255, 0))
        else
            circle:SetColor(Color(255, 0, 0))
        end

        cam.Start3D2D(pos + Vector(0, 0, -20), Angle(0, 0, 0), 1)
            circle()
        cam.End3D2D()

        local _,max = self:GetRotatedAABB(self:OBBMins(), self:OBBMaxs() )   
        local rot = (self:GetPos() - EyePos()):Angle().yaw - 90   
        local sin = math.sin(CurTime() + self:EntIndex()) / 3 + .5
        local center = self:LocalToWorld(self:OBBCenter())    
        local TeamName = self:GetCaptureFraction()

        if TeamName != "" then
            Fraction = ix.faction.indices[tonumber(TeamName)].name
        else
            Fraction = "N/A"
        end

        cam.Start3D2D(center + Vector(0, 0, math.abs(max.z) + 12 + sin), Angle(0, rot, 90), 0.13)
            textPlate("Точка захвачена: "..Fraction, "Доход: "..self:GetCaptureIncome(), string.FormattedTime(self:GetCaptureTime(), "%02i:%02i"), -150)   
        cam.End3D2D()   
    end
end

function ENT:Think()
    local count = 0

    for k,v in pairs(ents.FindInSphere(self:GetPos(), 256)) do
		if v:IsPlayer() then 
			count = count + 1
		end
	end

    if self.playerCount ~= count then
		self.playerCount = count
    end
end

function ENT:OnPopulateEntityInfo(container)
    local name = container:AddRow("name")
    name:SetImportant()
    name:SetText("Точка захвата")
    name:SizeToContents()

    local description = container:AddRow("description")

    if self.playerCount < 5 then
        name:SetBackgroundColor(Color(255, 0, 0))
        description:SetText("Недостаточно игроков для захвата точки!")
        description:SetBackgroundColor(Color(255, 0, 0))
        description:SizeToContents()
    elseif self:GetCapture() then
        name:SetBackgroundColor(Color(255, 255, 0))
        description:SetText("Точка захватывается...")
        description:SetBackgroundColor(Color(255, 255, 0))
        description:SizeToContents()
    else
        name:SetBackgroundColor(Color(0, 255, 0))
        description:SetText("Для захвата точки нажмите клавишу ["..string.upper(input.LookupBinding("+use")).."]")
        description:SetBackgroundColor(Color(0, 255, 0))
        description:SizeToContents()
    end
end