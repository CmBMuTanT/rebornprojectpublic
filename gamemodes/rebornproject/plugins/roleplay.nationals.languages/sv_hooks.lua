local PLUGIN = PLUGIN

netstream.Hook("DLLS", function(client)
	local character = client:GetCharacter()

	if !character then
		return
	end

	local learningLanguages = character:GetLearningLanguages() or {}

	table.Empty(learningLanguages)
	character:SetLearningLanguages(learningLanguages)
	character:SetData("LearnProgress", nil)
end)

function PLUGIN:GetSecondLanguage(client)
	local plg = ix.plugin.Get("idk.nationals")

	for k,v in pairs(plg.nationals) do
		if v.name == client:GetData("CharNational") then
			return v.secondlanguage
		end
	end
end

function PLUGIN:CharacterLoaded(character) -- TODO: Сделать чтоб не нужен был перезаход за персонажа
	local client = character:GetPlayer()
	local knownLanguages = character:GetLanguages() or {}

		
	character:SetData(self:GetSecondLanguage(character) or "", true)
	

	character:SetLearningLanguages(character:GetData("LearnProgress"))

	for k,v in pairs(ix.languages:GetAll()) do
		if character:GetData(k) then
			table.insert(knownLanguages, k)
			character:SetLanguages(knownLanguages)
		end
	end
end

