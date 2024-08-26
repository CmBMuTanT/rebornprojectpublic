include("shared.lua")
local PLUGIN = PLUGIN

surface.CreateFont("FactionFontMain", {font = "roboto", extended = true, size = 150, weight = 500})
surface.CreateFont("FactionFontSubMain", {font = "roboto", extended = true, size = 50, weight = 500})
surface.CreateFont("FactionFontSubMain2", {font = "roboto", extended = true, size = 25, weight = 500})
surface.CreateFont("FactionFontSubSubMain", {font = "roboto", extended = true, size = 35, weight = 500})

local function createbox(x, y, w, h, col)
    surface.SetDrawColor(col)
    surface.DrawRect(x,y,w,h)
end

local function createtext(font, x, y, data, col)
    surface.SetFont(font) 
    surface.SetTextColor(col)  
    surface.SetTextPos(x, y)  
    surface.DrawText(data) 
end

local relationshipmaterials = {
    ["WAR"] = {
        icon = "cmbmtk_fractiondesk/war.png",
        color = Color(200, 0, 0),
    },
    ["ALLIANCE"] = {
        icon = "cmbmtk_fractiondesk/alliance.png",
        color = Color(0, 200, 0),
    },
    ["NEUTRAL"] = {
        icon = "cmbmtk_fractiondesk/equal.png",
        color = Color(255, 255, 255),
    },
}

local function createrelationship(x, y, faction, relationship, factiontwo)
    draw.SimpleText(faction, "FactionFontSubMain2", x, y + 10, Color(255, 255, 255), 0, 1)
    local asd = surface.GetTextSize(faction)
    local dsa = asd + x + 30

    surface.SetDrawColor(relationshipmaterials[relationship].color)
    surface.SetMaterial( Material(relationshipmaterials[relationship].icon) )
	surface.DrawTexturedRect( dsa, y - 15, 64, 64 )

    draw.SimpleText(factiontwo, "FactionFontSubMain2", x + dsa - 100, y + 10, Color(255, 255, 255), 0, 1)
end

local y = 0

function ENT:Draw()
    self:DrawModel()
    local pos = self:LocalToWorld(Vector(0, 0, 1.6))
    local ang = self:LocalToWorldAngles(Angle(0, 90, 0))

    cam.Start3D2D(pos, ang, .1)


    createbox(-711, -474, 1422, 948, Color(0,0,0,150)) -- main panel
    createbox(-711, -474, 1422, 10, Color(255,255,255))
    createbox(-711, 464, 1422, 10, Color(255,255,255))
    createbox(-711, -320, 1422, 10, Color(255,255,255))

    createbox(-711, -474, 10, 948, Color(255,255,255))
    createbox(701, -474, 10, 948, Color(255,255,255))
    createbox(150, -300, 10, 750, Color(255,255,255))

    createtext("FactionFontMain", -600, -470, "Фракционная доска", Color(255, 255, 255))
    createtext("FactionFontSubMain", -600, -300, "Принадлежит: "..team.GetName(self:GetFraction()), Color(255, 255, 255))
    createtext("FactionFontSubSubMain", -600, -220, "Сейчас на службе: "..team.NumPlayers(self:GetFraction()), Color(255, 255, 255))
    --createtext("FactionFontSubSubMain", -600, -180, "Склад: "..self:GetCurrStorage().."/"..self:GetMaxStorage().." (Пассивный доход: "..self:GetPassiveIncome().." Пуль/30c.)", Color(255, 255, 255))
    createtext("FactionFontSubSubMain", -600, -180, "Склад: "..self:GetCurrStorage().."/"..self:GetMaxStorage().."", Color(255, 255, 255))
    createtext("FactionFontSubSubMain", -600, -100, "Хранилище (ЕД): "..self:GetBankWH().." x "..self:GetBankWH(), Color(255, 255, 255))

    local countcapturedpoints = 0
    for _,ent in ipairs(ents.FindByClass("ix_capturepoint")) do
        if ent:GetCaptureFraction() == tostring(self:GetFraction()) then
            countcapturedpoints = countcapturedpoints + 1
        end
    end
    if self.countcapturedpoints ~= countcapturedpoints then
        self.countcapturedpoints = countcapturedpoints or 0
    end
    createtext("FactionFontSubSubMain", -600, -140, "Количество захваченных точек: "..self.countcapturedpoints, Color(255, 255, 255))

    ------------------------------------
    createtext("FactionFontSubMain2", 190, -300, "Отношение между фракциями", Color(255, 255, 255))
    local factions = ix.faction.indices
    y = 0
    for i = 1, #factions do
        if factions[self:GetFraction()].name == factions[i].name then continue end
        createrelationship(190, -200 + y, factions[self:GetFraction()].name, self:GetNetVar(factions[i].name), factions[i].name)
        y = y + 63
    end
    cam.End3D2D()
end