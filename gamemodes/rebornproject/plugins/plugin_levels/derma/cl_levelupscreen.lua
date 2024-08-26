surface.CreateFont("AttributesFont", {
    font = "Roboto",
    size = 18
    ,
    weight = 800
})

surface.CreateFont("TitleFont", {
    font = "Roboto",
    size = 25,
    weight = 800
})

local function paintCattegory(s, w, h)
    surface.SetDrawColor(255, 165, 0, 150)
    surface.SetMaterial(Material("helix/gui/vignette.png"))
    surface.DrawTexturedRect(0, 0, w, h)
end

local gradient = surface.GetTextureID("vgui/gradient-d")
local vaultboy = Material("vgui/icons/group.png")
local animationTime = 1
local PANEL = {}

if (CLIENT) then
	local MainSTPanel = nil
	local mat = Material("helix/gui/vignette.png")
	local attributes = {}
	
	netstream.Hook("LvlUpMenu", function()
		if (IsValid(MainSTPanel)) then
			MainSTPanel:Remove()
		end
		
        local client = LocalPlayer()
		
        MainSTPanel = vgui.Create( "DFrame" )
        MainSTPanel:SetSize(ScrW() * 0.35, ScrH() * 0.5)
        MainSTPanel:ShowCloseButton(false)
        MainSTPanel:SetVisible(true)
		MainSTPanel:SetDraggable(false)
        MainSTPanel:SetSizable(false)
        MainSTPanel:SetTitle("")
        MainSTPanel:MakePopup()
		MainSTPanel:Center()
        MainSTPanel.Paint = function(this, w, h)
			surface.SetDrawColor(255, 165, 0, 150)
			surface.SetMaterial(mat)
			surface.DrawTexturedRect(0, 0, w, h)
		end
		
		surface.PlaySound("forp/music/mus_exitthevault.wav")
		
		MainSTPanelDop = MainSTPanel:Add("DImageButton")
        MainSTPanelDop:SetSize(200, 100)
        MainSTPanelDop:SetPos(ScrW() * 0.125, ScrH() * 0.37)
		MainSTPanelDop:SetText( "Сохранить" )
		MainSTPanelDop:SetFont( "TitleFont" )
        MainSTPanelDop:SetImage("vgui/icons/news.png")
        MainSTPanelDop.DoClick = function()
            net.Start("ShitLVLUP")
			net.WriteTable(attributes)
			net.SendToServer()
            surface.PlaySound("helix/ui/press.wav")
			MainSTPanel:Remove()
        end
        
        local character = client.GetCharacter and client:GetCharacter()
 
        if (character) then
			local attrib_points = client:GetLocalVar("AttribPoints", 0)
			attributes = {}
			
            MainSTPanel.attributes = MainSTPanel:Add("ixCategoryPanel")
            MainSTPanel.attributes:SetText(L("attributes"))
            MainSTPanel.attributes:Dock(TOP)
            MainSTPanel.attributes:DockMargin(0, 0, 0, 8)
			
			local total = 0
			local totalBar = MainSTPanel.attributes:Add("ixAttributeBar")
			totalBar:SetMax(attrib_points)
			totalBar:SetValue(attrib_points)
			totalBar:Dock(BOTTOM)
			totalBar:DockMargin(2, 2, 2, 2)
			totalBar:SetText("У вас " .. attrib_points .. " очков")
			totalBar:SetReadOnly()
			totalBar:SetColor(Color(20, 120, 20, 255))
 
            local boost = character:GetBoosts()
            local bFirst = true
 
            for k, v in SortedPairsByMemberValue(ix.attributes.list, "name") do
                local attributeBoost = 0
 
                if (boost[k]) then
                    for _, bValue in pairs(boost[k]) do
                        attributeBoost = attributeBoost + bValue
                    end
                end
 
                local bar = MainSTPanel.attributes:Add("ixAttributeBar")
                bar:Dock(TOP)
				bar.sub:Remove()
 
                if (!bFirst) then
                    bar:DockMargin(0, 3, 0, 0)
                else
                    bFirst = false
                end
 
                local value = character:GetAttribute(k, 0)
 
                if (attributeBoost) then
                    bar:SetValue(value - attributeBoost or 0)
                else
                    bar:SetValue(value)
                end
				
                local maximum = v.maxValue or ix.config.Get("maxAttributes", 100)
                bar:SetMax(maximum)
                bar:SetText(Format("%s [%.1f/%.1f] (%.1f%%)", L(v.name), value, maximum, value / maximum * 100))
				bar.OnChanged = function(this, difference)
					if (attrib_points == 0) or ((total + difference) > maximum) or ((total + difference) > attrib_points) then
						return false
					end
					
					if difference == -1 and attributes[k] and attributes[k] == 0 then
						return false
					end

					total = total + difference
					attributes[k] = (attributes[k] or 0) + difference

					totalBar:SetValue(totalBar.value - difference)
					totalBar:SetText("У вас " .. math.Clamp(totalBar.value, 0, attrib_points) .. " очков")
					
					local old_value = this.value + difference
					this:SetText(Format("%s [%.1f/%.1f] (%.1f%%)", L(v.name), old_value, maximum, old_value / maximum * 100))
				end
				
				if (attrib_points == 0) then
					bar:SetReadOnly()
				end
 
                if (attributeBoost) then
                    bar:SetBoost(attributeBoost)
                end
            end
 
            MainSTPanel.attributes:SizeToContents()
        end
    end)
end


	