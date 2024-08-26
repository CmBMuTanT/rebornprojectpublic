
local ix = ix
local PLUGIN = PLUGIN

ix.languages = ix.languages or {}
ix.languages.stored = ix.languages.stored or {}
local CLASS_TABLE = {__index = CLASS_TABLE}

CLASS_TABLE.name = "LanguageBase"
CLASS_TABLE.uniqueID = "language_base"
CLASS_TABLE.randomwords = {}
CLASS_TABLE.color = Color(100, 255, 255)
CLASS_TABLE.format = "%s говорит \"%s\""

function CLASS_TABLE:__tostring()
	return "LANGUAGE["..self.name.."]"
end

function CLASS_TABLE:Override(varName, value)
	self[varName] = value
end

function CLASS_TABLE:Register()
	return ix.languages:Register(self)
end

function CLASS_TABLE:PlayerCanSpeakLanguage(client)
	return ix.languages:PlayerCanSpeakLanguage(self.uniqueID, client)
end

function ix.languages:GetAll()
	return self.stored
end

function ix.languages:New(language)
	local object = {}
		setmetatable(object, CLASS_TABLE)
		CLASS_TABLE.__index = CLASS_TABLE
	return object
end

local function CanSay(self, speaker, text)
	local language = ix.languages:FindByID(self.langID)
	
	if (language:PlayerCanSpeakLanguage(speaker)) then
		return true
	end

	speaker:NotifyLocalized("Я не знаю этот язык..")
	return false
end

local OnChatAdd
if (CLIENT) then
	OnChatAdd = function(self, speaker, text, anonymous)
		local language = ix.languages:FindByID(self.langID)
		local icon = language.icon or nil
		if icon then
			icon = ix.util.GetMaterial(icon)
		end
		
		local name = anonymous and L"someone" or
		hook.Run("GetCharacterName", speaker, "ic") or
		(IsValid(speaker) and speaker:Name() or "Console")

		if language:PlayerCanSpeakLanguage(LocalPlayer()) then
			self.format = "%s "..self.sayType.." \"%s\" ("..language.name..")"
			chat.AddText(icon, self.color, string.format(self.format, name, text))
		else
			if language.randomwords then
				if istable(language.randomwords) then
					if !table.IsEmpty(language.randomwords) then
						local randomwords = language.randomwords
						local recreateLast = false
						local endText = string.utf8sub(text, -1)
						if (endText == "." or endText == "!" or endText == "?") then
							recreateLast = true
						end

						local splitWords = string.Split(text, " ")
						text = ""

						for _, _ in pairs(splitWords) do
							if math.random(0,5) == 3 then
								text = text..randomwords[math.random( #randomwords )].."'"
							else
								text = text..randomwords[math.random( #randomwords )].." "
							end
						end

						text = string.TrimRight(text)
						if (recreateLast) then
							text = (text..endText)
						end

						endText = string.utf8sub(text, -1)
						if (endText != "." and endText != "!" and endText != "?") then
							text = (text..".")
						end

						local editCapital = string.utf8sub(text, 1, 1)
						text = (string.utf8upper(editCapital)..string.utf8sub(text, 2, string.utf8len(text)))

						self.format = "%s "..self.sayType.." \"%s\" ("..language.name..")"
							chat.AddText(icon, self.color, string.format(self.format, name, text))
						return
					end
				end
			end
			chat.AddText(icon, self.color, string.format(self.format, name))
		end
	end
end

function ix.languages:Register(language)
	language.uniqueID = string.utf8lower(string.gsub(language.uniqueID or string.gsub(language.name, "%s", "_"), "['%.]", ""))
	self.stored[language.uniqueID] = language

	local languageClass = {}
	languageClass.color = language.color or Color(102, 204, 255)
	languageClass.sayType = "говорит"
	languageClass.format = "%s "..languageClass.sayType
	languageClass.CanHear = ix.config.Get("chatRange", 280)
	languageClass.description = "Позволяет вам сказать что-нибудь на "..language.name..", если вы знаете язык."
	languageClass.indicator = "chatTalking"
	languageClass.prefix = {"/"..language.uniqueID, "/"..string.utf8lower(language.name)}
	languageClass.langID = language.uniqueID
	languageClass.CanSay = CanSay

	if (CLIENT) then
		languageClass.OnChatAdd = OnChatAdd
	end

	ix.chat.Register(language.uniqueID, languageClass)

	if (CLIENT) then
		ix.command.list[language.uniqueID].OnCheckAccess = function(_, client) return language:PlayerCanSpeakLanguage(client) end
		ix.command.list[string.utf8lower(language.name)].OnCheckAccess = function(_, client) return language:PlayerCanSpeakLanguage(client) end
	end

	local languageClassWhisper = {}
	languageClassWhisper.sayType = "шепчет"
	languageClassWhisper.CanHear = ix.config.Get("chatRange", 280) * 0.25
	languageClassWhisper.format = languageClass.format
	languageClassWhisper.indicator = "chatWhispering"
	languageClassWhisper.prefix = {"/w"..language.uniqueID, "/w"..string.utf8lower(language.name)}
	languageClassWhisper.description = "Позволяет вам прошептать что-нибудь на "..language.name..", если вы знаете язык."
	languageClassWhisper.langID = language.uniqueID
	languageClassWhisper.CanSay = CanSay
	languageClassWhisper.color = Color(102 - 35, 204 - 35, 255 - 35)

	if (CLIENT) then
		languageClassWhisper.OnChatAdd = OnChatAdd
	end

	ix.chat.Register("w"..language.uniqueID, languageClassWhisper)

	if (CLIENT) then
		ix.command.list["w"..language.uniqueID].OnCheckAccess = function(_, client) return language:PlayerCanSpeakLanguage(client) end
		ix.command.list["w"..string.utf8lower(language.name)].OnCheckAccess = function(_, client) return language:PlayerCanSpeakLanguage(client) end
	end

	local languageClassYell = {}
	languageClassYell.sayType = "кричит"
	languageClassYell.format = languageClass.format
	languageClassYell.CanHear = ix.config.Get("chatRange", 280) * 2
	languageClassYell.indicator = "chatYelling"
	languageClassYell.prefix = {"/y"..language.uniqueID, "/y"..string.utf8lower(language.name)}
	languageClassYell.description = "Позволяет вам крикнуть что-нибудь на "..language.name..", если вы знаете язык."
	languageClassYell.langID = language.uniqueID
	languageClassYell.CanSay = CanSay
	languageClassYell.color = Color(102 + 35, 204 + 35, 255 + 35)

	if (CLIENT) then
		languageClassYell.OnChatAdd = OnChatAdd
	end

	ix.chat.Register("y"..language.uniqueID, languageClassYell)

	if (CLIENT) then
		ix.command.list["y"..language.uniqueID].OnCheckAccess = function(_, client) return language:PlayerCanSpeakLanguage(client) end
		ix.command.list["y"..string.utf8lower(language.name)].OnCheckAccess = function(_, client) return language:PlayerCanSpeakLanguage(client) end
	end
	
end

function ix.languages:FindByID(identifier)
	if (identifier and identifier != 0 and type(identifier) != "boolean") then
		if (self.stored[identifier]) then
			return self.stored[identifier]
		end

		local lowerName = string.utf8lower(identifier)
		local language = nil

		for _, v in pairs(self.stored) do
			local languageName = v.name

			if (string.find(string.utf8lower(languageName), lowerName)
			and (!language or string.utf8len(languageName) < string.utf8len(language.name))) then
				language = v
			end
		end

		return language
	end
end

function ix.languages:Initialize()
	local languages = self:GetAll()

	for _, v in pairs(languages) do
		if (v.OnSetup) then
			v:OnSetup()
		end
	end
end

function ix.languages:PlayerCanSpeakLanguage(language, client)

	local languages = client:GetCharacter():GetLanguages()
	if (languages) then
		if (!table.IsEmpty(languages) and table.HasValue(languages, language)) then
			return true
		end
	end

	return false
end

ix.command.Add("CharGiveLanguage", {
	description = "Добавить знание языка персонажу.",
	adminOnly = true,
	arguments = {ix.type.character, ix.type.text},
	alias = "CharSetBilingual",
	OnRun = function(self, client, character, lang)
		if (character) then
			local language = ix.languages:FindByID(lang)
			if (language) then
				local knownLanguages = character:GetLanguages()
				if (table.HasValue(knownLanguages, language.uniqueID)) then
					client:NotifyLocalized("Этот персонаж уже знает "..language.name.."!")
					return false
				else
					table.insert(knownLanguages, language.uniqueID)
					character:SetLanguages(knownLanguages)
					character:SetData(language.uniqueID, true)
					client:NotifyLocalized("Вы добавили персонажу "..character:GetName().." знание языка "..language.name)
				end
			else
				client:NotifyLocalized("Такого языка не существует!")
				return false
			end
		else
			client:NotifyLocalized("Невозможно найти этого персонажа!")
			return false
		end
	end
})

ix.command.Add("CharTakeLanguage", {
	description = "Забрать знание языка у персонажа.",
	adminOnly = true,
	arguments = {ix.type.character, ix.type.text},
	OnRun = function(self, client, character, lang)
		if (character) then
			local language = ix.languages:FindByID(lang)
			if (language) then
				local knownLanguages = character:GetLanguages()
				if (!table.HasValue(knownLanguages, language.uniqueID)) then
					client:NotifyLocalized("Этот персонаж не знает "..language.name.."!")
					return false
				else
					table.RemoveByValue(knownLanguages, language.uniqueID)
					character:SetLanguages(knownLanguages)
					character:SetData(language.uniqueID, false)
					client:NotifyLocalized("Вы забрали у персонажа "..character:GetName().." знание языка "..language.name)
				end
			else
				client:NotifyLocalized("Такого языка не существует!")
				return false
			end
		else
			client:NotifyLocalized("Невозможно найти этого персонажа!")
			return false
		end
	end
})