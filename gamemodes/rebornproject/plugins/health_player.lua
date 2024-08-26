local PLUGIN = PLUGIN
PLUGIN.name = "Health player"
PLUGIN.author = "Hikka"
PLUGIN.desc = "Saves the health of a character." -- Изменяет текущую систему ХП, т.е если игрок вышел с 50HP, то при заходе у него будет 50HP :D

local HealthID = "saveHealth" -- переменная которая хранит ID сохраняемого здоровья.

if (SERVER) then
	local mClamp = math.Clamp
	local HealthID = "saveHealth" -- переменная которая хранит ID сохраняемого здоровья.
	function PLUGIN:CharacterPreSave(character)
		local client = character:GetPlayer()
		local savedHealth = client:Health()
		local maxHealth = client:GetMaxHealth()
		character:SetData(HealthID, mClamp(savedHealth, 0, maxHealth))
	end

	function PLUGIN:PlayerLoadedChar(client, character)
		local hpData = character:GetData(HealthID)
		local hpAmount = client:GetMaxHealth()
		if (hpData) then
			if (hpData <= 0) then
				client:SetHealth(hpAmount)
				return
			end
			
			client:SetHealth(mClamp(hpData, 0, hpAmount))
		end
	end
end
