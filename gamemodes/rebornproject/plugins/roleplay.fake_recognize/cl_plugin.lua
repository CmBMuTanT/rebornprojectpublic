local PLUGIN = PLUGIN

CHAT_RECOGNIZED = CHAT_RECOGNIZED or {}
CHAT_RECOGNIZED["ic"] = true
CHAT_RECOGNIZED["y"] = true
CHAT_RECOGNIZED["w"] = true
CHAT_RECOGNIZED["me"] = true

function PLUGIN:IsRecognizedChatType(chatType)
	if (CHAT_RECOGNIZED[chatType]) then
		return true
	end
end

function PLUGIN:GetCharacterDescription(client)
	if (client:GetCharacter() and client != LocalPlayer() and LocalPlayer():GetCharacter() and
		!LocalPlayer():GetCharacter():DoesRecognize(client:GetCharacter()) and !hook.Run("IsPlayerRecognized", client)) then
		return L"noRecog"
	end
end

function PLUGIN:ShouldAllowScoreboardOverride(client)
	if (ix.config.Get("scoreboardRecognition")) then
		return true
	end
end

function PLUGIN:GetCharacterName(client, chatType)
	if (client != LocalPlayer()) then
		local character = client:GetCharacter()
		local ourCharacter = LocalPlayer():GetCharacter()
		if (ourCharacter and character and !ourCharacter:DoesRecognize(character) and !hook.Run("IsPlayerRecognized", client)) then
			if (chatType and hook.Run("IsRecognizedChatType", chatType)) then
				local description = character:GetDescription()
				if (#description > 40) then
					description = description:utf8sub(1, 37).."..."
				end
				return "["..description.."]"
			elseif (!chatType) then
				return L"unknown"
			end
		end
	end
end

local function Recognize(level,name)
	net.Start("ixRecognize")
		net.WriteUInt(level, 2)
		net.WriteString(name)
	net.SendToServer()
end

net.Receive("ixRecognizeMenu", function(length)
	vgui.Create("fkname_recognitionmenu")
end)

net.Receive("ixRecognizeDone", function(length)
	hook.Run("CharacterRecognized")
end)

function PLUGIN:CharacterRecognized(client, recogCharID)
	surface.PlaySound("buttons/button17.wav")
end


local PANEL = {}
local btnHeight = 40
local btnColors = {
	[1] = {
		Color(245, 118, 0),
		Color(189, 135, 43, 255),
		Color(255, 179, 0),
		Color(96, 65, 9),
		Color(255, 145, 0, 225),
		Color(255, 157, 0, 160)
	},
	[2] = {
		Color(248, 56, 56),
		Color(248, 56, 56, 48),
		Color(248, 56, 56),
		Color(96, 10, 10),
		Color(248, 56, 56, 225),
		Color(201, 45, 45, 160)
	},
}

surface.CreateFont("f3.btn", {
	font = "Nagonia",
	extended = true,
	size = 24,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

function PANEL:Init()
	self.BaseClass.SetText(self, "")

	self:SetSize(32, 40)

	self:SetTextColor(btnColors[1][1])
	self:SetFont("f3.btn")
	self:SetTextInset(32 + 13, 0)
	self:SetContentAlignment(4)

	self.text = ""
	self.icon = 0
end
function PANEL:SetText(value)
	self.text = value
end

function PANEL:Paint(w, h)
	local clr = self:IsHovered() and 2 or 1
	local color = btnColors[clr]

	local x = 0

	surface.SetDrawColor(color[2])
	surface.DrawLine(x, 0, w - 1, 0)
    surface.DrawLine(0,0,0,h-1)
	surface.DrawLine(x, h - 1, w - 1, h - 1)
	surface.DrawLine(w - 1, 1, w - 1, h - 1)

	surface.SetDrawColor(color[3])
	surface.DrawLine(w - 1, h - 1, x + w, h - 1)
	surface.DrawLine(w - 1, 0, x + w, 0)


	surface.SetFont("f3.btn")
	local textW, textH = surface.GetTextSize(self.text)
	local x, y = 13, h / 2 - textH / 2

	surface.SetFont("f3.btn")
	surface.SetTextColor(color[1])
	surface.SetTextPos(x, y)
	surface.DrawText(self.text, true)
end
vgui.Register("f3.btn", PANEL, "DButton")



local PANEL = {}
local Buttons = {}
timer.Simple(0.1,function()
	Buttons = 	{
	[0] = L"rgnLookingAt",
	[1] = L"rgnWhisper",
	[2] = L"rgnTalk",
	[3] = L"rgnYell",
	}
end)

local VariantsSetsName = {
	["Новое имя"] = function(panel)
		Derma_StringRequest("Добавление нового имени для представлений","Введите новое имя","Андрей",function(text)
				fkname_RECOGNIZE_SELECTEDNAME = text
				netstream.Start("fkname_ActionName",{text})
				timer.Simple(0.1,function()
					if IsValid(panel) then
						panel:GetParent():LoadNames()
					end
				end)
			end,nil,"Добавить","Отказаться")
	 end,
	["Настоящее имя"] = function() fkname_RECOGNIZE_SELECTEDNAME = LocalPlayer():Name() end,
}


fkname_RECOGNIZE_SELECTEDNAME = nil;
fkname_RECOGNIZE_MENU = nil
function PANEL:Init()
    if IsValid(fkname_RECOGNIZE_MENU) then
        self:Remove()
        return
    end
    fkname_RECOGNIZE_MENU = self
    local data = LocalPlayer():GetCharacter():GetData("fkname_UsedNames",{})
    fkname_RECOGNIZE_SELECTEDNAME = (LocalPlayer():Name() == fkname_RECOGNIZE_SELECTEDNAME or data[fkname_RECOGNIZE_SELECTEDNAME]) and fkname_RECOGNIZE_SELECTEDNAME or nil 

	self:SetSize(600,400)
	self:SetPos(ScrW()/2-300,ScrH()/2-200)
	self:SetAlpha(0)
	self:AlphaTo(255,0.3)
	self:MakePopup()
	ix.util.DrawBlur(self, 10)
	self.Paint = function(this,w,h)
		draw.RoundedBox(0,1,1,w-1,h-1,Color(1,1,1,220))
		surface.SetDrawColor(btnColors[1][2])
		local x = 0
		surface.DrawLine(x, 0, w - 1, 0)
		surface.DrawLine(0,0,0,h-1)
		surface.DrawLine(x, h - 1, w - 1, h - 1)
		surface.DrawLine(w - 1, 1, w - 1, h - 1)
	end


	local CloseButton = self:Add("f3.btn")
	CloseButton:SetPos(572,3)
	CloseButton:SetSize(25,25)
	CloseButton:SetText("")
	CloseButton.DoClick = function()
		self:AlphaTo(0,0.3,0,function()
			self:Remove()
		end)
	end
	CloseButton.PaintOver = function(_,w,h)
		draw.NoTexture()
		local clr = _:IsHovered() and 2 or 1
		local color = btnColors[clr][2]
		surface.SetDrawColor(color)
		surface.DrawLine(1,1,w-1,h-1)
		surface.DrawLine(w-1,1,1,h-1)
	end

	self.list = self:Add("DPanelList")
	self.list:SetPos(5,30)
	self.list:SetSize(345,215)
	self.list:EnableVerticalScrollbar()
    self.list:SetSpacing(5)

	self:LoadNames()
	self.PaintOver = function(this,w,h)
        local color = btnColors[1]
        local text = "Представляетесь как:"
        local pos = {350+122.5,55}
        local textw = select(1,surface.GetTextSize(text))/2

        surface.SetFont("f3.btn")
        surface.SetTextColor(color[1])
        surface.SetTextPos(pos[1]-textw,pos[2])
        surface.DrawText(text, true)

        local text = fkname_RECOGNIZE_SELECTEDNAME or "не выбрано"
        color = btnColors[2]
        textw = select(1,surface.GetTextSize(text))/2

        surface.SetFont("f3.btn")
        surface.SetTextColor(color[1])
        surface.SetTextPos(pos[1]-textw,pos[2]+25)
        surface.DrawText(text, true)

	end

	local xpos = 125

	for k,v in pairs(VariantsSetsName)do
		local SetName = self:Add("f3.btn")
		SetName:SetPos(355,xpos)
		SetName:SetSize(240,25)
		SetName:SetText(k)
		SetName.DoClick = v
		xpos = xpos + 30
	end
	self.buttons = {}
	xpos = 280
	for k,v in pairs(Buttons)do
		self.buttons[k] = self:Add("f3.btn")
		self.buttons[k]:SetSize(590,25)
		self.buttons[k]:SetPos(5,xpos)
		self.buttons[k]:SetText(v)
		self.buttons[k].DoClick = function(this)
			self:Remove()
			Recognize(k,fkname_RECOGNIZE_SELECTEDNAME)
		end
		self.buttons[k]:SetDisabled(!fkname_RECOGNIZE_SELECTEDNAME)
		xpos = xpos + 30
	end
end

function PANEL:LoadNames()
	for k,v in pairs(self.buttons or {})do
		v:SetDisabled(!fkname_RECOGNIZE_SELECTEDNAME)
	end
	for k,v in pairs(self.list:GetItems())do
		v:Remove()
	end
	local Names = LocalPlayer():GetCharacter():GetData("fkname_UsedNames",{})
	for k,v in pairs(Names) do
		local button = self.list:Add("f3.btn")
		button:SetSize(320,30)
		button:SetText(k)
		button.Text = k
		button.DoClick = function(this)
			Derma_Query("Представляться под именем "..k.."?","Выберите операцию","Выбрать",function() fkname_RECOGNIZE_SELECTEDNAME = k end,"Удалить",
            function() 
                netstream.Start("fkname_ActionName",{k,true})
                timer.Simple(0.1,function()
					self:LoadNames()
				end)
            end,"Отменить")
		end
		self.list:AddItem(button)
	end
end


vgui.Register("fkname_recognitionmenu",PANEL,"DPanel")