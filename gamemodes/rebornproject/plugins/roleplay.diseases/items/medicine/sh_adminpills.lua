ITEM.name = "Панацея"
ITEM.model = "models/props_lab/jar01b.mdl"
ITEM.description = "Мифическое универсальное средство от всех болезней, способное также продлевать жизнь, вплоть до бесконечности."
ITEM.width = 1
ITEM.height = 1
ITEM.adminPills = true
ITEM.useSound = "npc/barnacle/barnacle_gulp1.wav"
ITEM.quantity = 99

if CLIENT then
    function ITEM:PopulateTooltip(tooltip)
        local name = tooltip:GetRow("name")
        timer.Create("SBCHSVpan", 0.01, 0, function()
            if !IsValid(name) then return end
            name:SetBackgroundColor(HSVToColor( CurTime() * 75 % 360, 1, 1 ))
        end)
    end
end