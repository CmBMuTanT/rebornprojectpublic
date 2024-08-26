local PLUGIN = PLUGIN
PLUGIN.name = "Чаттер"
PLUGIN.author = "БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"

--[[

———————————No cmbmutant.xyz?———————————
⠀⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝
⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇
⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀
⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀
⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀
⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
—————————————————————————————————————
]]

ix.util.Include("sv_plugin.lua")

if (CLIENT) then
	local PANEL = {}
	function PANEL:Init()
		self.number = 0
		self:SetWide(70)

		local up = self:Add("DButton")
		up:SetFont("Marlett")
		up:SetText("t")
		up:Dock(TOP)
		up:DockMargin(2, 2, 2, 2)
		up.DoClick = function(this)
			self.number = (self.number + 1)% 10
			surface.PlaySound("others/shelk_1.mp3")
		end

		local down = self:Add("DButton")
		down:SetFont("Marlett")
		down:SetText("u")
		down:Dock(BOTTOM)
		down:DockMargin(2, 2, 2, 2)
		down.DoClick = function(this)
			self.number = (self.number - 1)% 10
			surface.PlaySound("others/shelk_2.mp3")
		end

		local number = self:Add("Panel")
		number:Dock(FILL)
		number.Paint = function(this, w, h)
			draw.SimpleText(self.number, "ixDialFont", w/2, h/2, color_white, 1, 1)
		end
	end

	vgui.Register("ixRadioDial", PANEL, "DPanel")

	PANEL = {}

	function PANEL:Init()
		self:SetTitle(L("Переключатель частоты"))
		self:SetSize(330, 220)
		self:Center()
		self:MakePopup()

		self.submit = self:Add("DButton")
		self.submit:Dock(BOTTOM)
		self.submit:DockMargin(0, 5, 0, 0)
		self.submit:SetTall(25)
		self.submit:SetText(L("Переключить частоту"))
		self.submit.DoClick = function()
			local str = ""
			for i = 1, 5 do
				if (i != 4) then
					str = str .. tostring(self.dial[i].number or 0)
				else
					str = str .. "."
				end
			end
			netstream.Start("radioAdjust", str, self.itemID)

			self:Close()
		end

		self.dial = {}
		for i = 1, 5 do
			if (i != 4) then
				self.dial[i] = self:Add("ixRadioDial")
				self.dial[i]:Dock(LEFT)
				if (i != 3) then
					self.dial[i]:DockMargin(0, 0, 5, 0)
				end
			else
				local dot = self:Add("Panel")
				dot:Dock(LEFT)
				dot:SetWide(30)
				dot.Paint = function(this, w, h)
					draw.SimpleText(".", "ixDialFont", w/2, h - 10, color_white, 1, 4)
				end
			end
		end
	end

	function PANEL:Think()
		self:MoveToFront()
	end

	vgui.Register("ixRadioMenu", PANEL, "DFrame")

	surface.CreateFont("ixDialFont", {
		font = "Agency FB",
		extended = true,
		size = 100,
		weight = 1000
	})

	netstream.Hook("radioAdjust", function(freq, id)
		local adjust = vgui.Create("ixRadioMenu")

		if (id) then
			adjust.itemID = id
		end

		if (freq) then
			for i = 1, 5 do
				if (i != 4) then
					adjust.dial[i].number = tonumber(freq[i])
				end
			end
		end
	end)
end

local freq
local cfgrange = ix.config.Get("chatRange", 280)

ix.chat.Register("radio", {
	format = "%s передает по рации: \"%s\"",
	GetColor = function(speaker, text)
		return Color(0, 120, 0)
	end,
	CanHear = function(self, speaker, listener)

		local distance = speaker:GetPos():Distance(listener:GetPos())

		local listenerCharacter = listener:ExtraInventory("radio"):GetEquipedItem("chatter")

		if (!CURFREQ or CURFREQ == "") then
			return false
		end

		if (distance <= cfgrange) then
			return true
		end

		if (listenerCharacter) then
			if listenerCharacter:GetData("equip") == true and listenerCharacter:GetData("BatteryCondition") ~= nil and listenerCharacter:GetData("BatteryCondition") > 1 then
				if CURFREQ == listenerCharacter:GetData("freq") then
					listener:EmitSound("npc/metropolice/vo/off"..math.random(1, 3)..".wav", math.random(60, 70), math.random(80, 120))
					return true
				else
					return false
				end
			end
		else
			return false
		end

	end,
	CanSay = function(self, speaker, text)
		local speakerInv = speaker:ExtraInventory("radio"):GetEquipedItem("chatter")

		if (speakerInv) then
			if speakerInv:GetData("equip") == true and speakerInv:GetData("BatteryCondition") ~= nil and speakerInv:GetData("BatteryCondition") > 1 then
				freq = speakerInv:GetData("freq") 
			end
		else
			return false
		end

		if (freq) and speakerInv:GetData("BatteryCondition", nil) ~= nil and speakerInv:GetData("BatteryCondition", nil) > 1 then
			CURFREQ = freq
			speaker:EmitSound("npc/metropolice/vo/on"..math.random(1, 2)..".wav", math.random(50, 60), math.random(80, 120))

		else

			if speakerInv:GetData("equip") == true and speakerInv:GetData("BatteryCondition") ~= nil and speakerInv:GetData("BatteryCondition") > 1  then
				freq = speakerInv:GetData("freq", "000.0")
			else
				return false
			end
		end

	end,
	prefix = {"/r", "/radio"},
})


ix.chat.Register("radio:ooc", {
	format = "%s передает по рации [OOC]: \"%s\"",
	GetColor = function(speaker, text)
		return Color(120, 0, 0)
	end,
	CanHear = function(self, speaker, listener)

		local distance = speaker:GetPos():Distance(listener:GetPos())

		local listenerCharacter = listener:ExtraInventory("radio"):GetEquipedItem("chatter")

		if (!CURFREQ or CURFREQ == "") then
			return false
		end

		if (distance <= cfgrange) then
			return true
		end

		if (listenerCharacter) then
			if listenerCharacter:GetData("equip") == true and listenerCharacter:GetData("BatteryCondition") ~= nil and listenerCharacter:GetData("BatteryCondition") > 1 then
				if CURFREQ == listenerCharacter:GetData("freq") then
					listener:EmitSound("npc/metropolice/vo/off"..math.random(1, 3)..".wav", math.random(60, 70), math.random(80, 120))
					return true
				else
					return false
				end
			end
		else
			return false
		end

	end,
	CanSay = function(self, speaker, text)
		local speakerInv = speaker:ExtraInventory("radio"):GetEquipedItem("chatter")

		if (speakerInv) then
			if speakerInv:GetData("equip") == true then
				freq = speakerInv:GetData("freq") 
			end
		else
			return false
		end

		if (freq) and speakerInv:GetData("BatteryCondition", nil) ~= nil and speakerInv:GetData("BatteryCondition", nil) > 1 then
			CURFREQ = freq
			speaker:EmitSound("npc/metropolice/vo/on"..math.random(1, 2)..".wav", math.random(50, 60), math.random(80, 120))

		else

			if speakerInv:GetData("equip") == true and speakerInv:GetData("BatteryCondition") ~= nil and speakerInv:GetData("BatteryCondition") > 1  then
				freq = speakerInv:GetData("freq", "000.0")
			else
				return false
			end
		end

	end,
	prefix = {"/rooc", "/radioooc"},
})