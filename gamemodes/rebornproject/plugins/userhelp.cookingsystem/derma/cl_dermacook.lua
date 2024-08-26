local PANEL = {}

function PANEL:Init()
    self:SetSize(ScrW() * 0.1, ScrH() * 0.4)
    self:MakePopup()
    self:Center()
    self:SetTitle("")
    self.Choice = nil
    self.Entity = nil

    local scrollPanel = vgui.Create("DScrollPanel", self)
    scrollPanel:Dock(FILL)

    local buttonContainer = vgui.Create("DListLayout", scrollPanel)
    buttonContainer:Dock(FILL)

    local sir = {
        ["dirty"] = true,
        ["rotten"] = true,
        ["raw"] = true,
        ["clean"] = true,
    }

    for _, item in pairs(LocalPlayer():GetCharacter():GetInventory():GetItems()) do
        if item.base == "base_newfood" and item:GetData("quantity", 0) ~= 0 and not item.IsFluid and sir[item:GetData("type", "raw")] then
            local button = vgui.Create("DButton")
            button:SetText(item.name)
            button:Dock(TOP)
            buttonContainer:Add(button)

            local ingredients = item:GetData("ingredients")
			local ingredients_str = ""

			if #ingredients ~= 0 then
				ingredients_str = "Ингридиенты: ".. table.concat(ingredients, "; ")
			end

            button:SetTooltip(ingredients_str)

            button.DoClick = function()
                netstream.Start("cmbmtk:"..self.Choice, item, self.Entity)
                self:Close() 
            end
        end
    end
end

function PANEL:Status(value, ent)
    self.Choice = value
    self.Entity = ent
end

vgui.Register("CMBMTK:ChoiceButton", PANEL, "DFrame")
