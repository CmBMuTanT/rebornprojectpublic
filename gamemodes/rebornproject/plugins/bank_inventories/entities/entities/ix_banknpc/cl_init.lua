include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

--ENT.PopulateEntityInfo = true
--
--function ENT:OnPopulateEntityInfo(container)
--	local name = container:AddRow("name")
--	name:SetImportant()
--	name:SetText(self:GetDisplayName())
--	name:SizeToContents()
--end

local Ang90 = Angle(0, 0, 90)
local maxDist = 512 ^ 2
local background = Color(0, 0, 25, 175)
local text = Color(179, 210, 7)

surface.CreateFont("incredible-gmod.ru/helix/bank", {
	font = "Roboto Bold",
	size = 32
})

hook.Add("PreDrawEffects", "incredible-gmod.ru/helix/bank", function()
	local ply = LocalPlayer()

	for i, npc in ipairs(ents.FindByClass("ix_banknpc")) do		
	    local pos = npc:LookupBone("ValveBiped.Bip01_Head1")
	    if pos and pos > -1 then
	    	pos = npc:GetBonePosition(pos) + npc:GetAngles():Up() * 12
	    else
	    	pos = npc:GetPos() + npc:GetAngles():Up() * (npc:OBBMaxs().z + 3)
	    end
		
	    local dist = ply:GetPos():DistToSqr(pos)

	    if dist > maxDist then continue end
		local alpha = 1 - dist / maxDist

	    local ang = ply:EyeAngles()
	    ang:RotateAroundAxis(ang:Forward(), 90)
	    ang:RotateAroundAxis(ang:Right(), 90)

	    Ang90.y = ang.y

	    cam.Start3D2D(pos, Ang90, 0.05)
	    surface.SetAlphaMultiplier(alpha)
	    	surface.SetFont("incredible-gmod.ru/helix/bank")
	    	surface.SetDrawColor(background)

	    	local npcname = npc:GetDisplayName()

	    	local w, h = surface.GetTextSize(npcname)
	    	w, h = w + 24, h + 8
	    	surface.DrawRect(-w*0.5, -h * 0.5, w, h)

			draw.SimpleText(npcname, "incredible-gmod.ru/helix/bank", 0, 0, text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		surface.SetAlphaMultiplier(1)
	    cam.End3D2D()		
	end
end)