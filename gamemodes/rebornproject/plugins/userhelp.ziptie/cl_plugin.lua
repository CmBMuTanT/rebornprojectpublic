local PLUGIN = PLUGIN

function PLUGIN:PopulateCharacterInfo(client, character, tooltip)
	if (client:IsRestricted()) then
		local panel = tooltip:AddRowAfter("name", "ziptie")
		panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
		panel:SetText(L("Связан"))
		panel:SizeToContents()
	elseif (client:GetNetVar("tying")) then
		local panel = tooltip:AddRowAfter("name", "ziptie")
		panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
		panel:SetText(L("Связывают"))
		panel:SizeToContents()
	elseif (client:GetNetVar("untying")) then
		local panel = tooltip:AddRowAfter("name", "ziptie")
		panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
		panel:SetText(L("Развязывают"))
		panel:SizeToContents()
	end
end


function PLUGIN:GetPlayerEntityMenu(client, options)
	if (client:IsRestricted()) then
		options["Завязать глаза"] = true
		options["Завязать рот"] = true
		options["Развязать"] = true
	end
end


function PLUGIN:HUDPaint()
	if LocalPlayer():GetNetVar("ziptie:closeeyes") == true then
		surface.SetDrawColor( 0, 0, 0 )
		surface.DrawRect(0, 0, ScrW(), ScrH())
	end
end
