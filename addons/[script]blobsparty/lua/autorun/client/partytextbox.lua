--GUI base created by billy
--https://scriptfodder.com/users/view/76561198040894045/scripts

local PANEL = {}

surface.CreateFont("bgui_placeholdered",{
	size = 16,
	font = "Roboto",
	italic = true,
})
surface.CreateFont("bgui_textnormal",{
	size = 16,
	font = "Roboto",
})

function PANEL:GetValue()
	if (self.PlaceHoldered == true) then
		return ""
	else
		return self:GetText()
	end
end

function PANEL:SetPlaceHolder(text)
	self.PlaceHoldered = true
	self.PlaceHolder = text
	self:SetText(text)
	self:SetFont("bgui_placeholdered")
	self:ApplySchemeSettings()
	self:SetTextColor(Color(64,64,64))
end

function PANEL:Init()
	self:SetFont("bgui_textnormal")
	self:ApplySchemeSettings()
	self:SetTextColor(Color(0,0,0))

	self.OnGetFocus = function()
		if (self.PlaceHoldered == true) then
			self.PlaceHoldered = false
			self:SetFont("bgui_textnormal")
			self:ApplySchemeSettings()
			self:SetTextColor(Color(0,0,0))
			self:SetText("")
		end
	end

	self.OnLoseFocus = function()
		if (self:GetValue() == "" and self.PlaceHolder) then
			self.PlaceHoldered = true
			self:SetText(self.PlaceHolder)
			self:SetFont("bgui_placeholdered")
			self:ApplySchemeSettings()
			self:SetTextColor(Color(64,64,64))
		end
	end
end

function PANEL:OnValueChange(v)
	if (v == "" and self.PlaceHolder) then
		self.PlaceHoldered = true
		self:SetText(self.PlaceHolder)
		self:SetFont("bgui_placeholdered")
		self:ApplySchemeSettings()
		self:SetTextColor(Color(64,64,64))
	end
end

function PANEL:OnKeyCodeTyped(kc)
	if (self.PlaceHoldered == true and kc ~= 66) then
		self.PlaceHoldered = false
		self:SetFont("bgui_textnormal")
		self:ApplySchemeSettings()
		self:SetTextColor(Color(0,0,0))
		self:SetText("")
	end
end

function PANEL:GetUpdateOnType()
	return true
end

function PANEL:Clear()
	self:SetText("")
	if (self.PlaceHolder) then
		self.PlaceHoldered = true
		self:SetText(self.PlaceHolder)
		self:SetFont("bgui_placeholdered")
		self:ApplySchemeSettings()
		self:SetTextColor(Color(64,64,64))
	end
end

derma.DefineControl("PartyTextBox",nil,PANEL,"DTextEntry")