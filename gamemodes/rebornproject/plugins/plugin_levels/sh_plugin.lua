PLUGIN.name = "Level System"
PLUGIN.description = "Система уровней для Метро 2033 | Новая Жизнь"
PLUGIN.author = "Hikka, KriegKaiser"

ix.config.Add("maxLvl", 100, "Максимальный уровень.", nil, {
	data = {min = 1, max = 100},
	category = PLUGIN.name
})

ix.util.Include("sv_plugin.lua")

if (CLIENT) then
	function PLUGIN:PopulateCharacterInfo(client, character, tooltip)
		local recognize = LocalPlayer():GetCharacter():DoesRecognize(character)
		local text = client:GetNetVar("lvl", 1) or nil

		if (text) then
			local panel = tooltip:AddRowAfter("rank", "levelRow")
			panel:SetTextColor(Color(255, 255, 0))
			panel:SetText("Уровень: " .. tostring(text))
			panel:SizeToContents()
		end
	end
end

ix.command.Add("UseScore", {
	OnRun = function(self, client)
		if (client:GetLocalVar("AttribPoints", 0) > 0) then
			netstream.Start(client, "LvlUpMenu")
			client:EmitSound("forp/music/mus_exitthevault.wav")
		else
            client:Notify("У вас нету очков для прокачки...")
        end
	end
})

ix.command.Add("CharGiveExp", {
	adminOnly = true,
	arguments = {
        ix.type.player,
        ix.type.number
    },
	OnRun = function(self, client, target, score)
		target:AddExp(score)
		client:EmitSound("fosounds/fix/ui_levelup.mp3") 
	end
})

ix.command.Add("CharLevelUp", {
	adminOnly = true,
	OnRun = function(self, client)
		local nextLvl = client:GetNetVar("lvl", 1) + 1
		if (nextLvl >= ix.config.Get("maxLvl")) then
			return
		end
		client:SetNetVar("lvl", nextLvl)
		client:SetLocalVar("AttribPoints", client:GetLocalVar("AttribPoints", 0) + 5)
		client:EmitSound("fosounds/fix/ui_levelup.mp3")

		netstream.Start(client, "LvlUpMenu")
	end
})