ITEM.name = "Самогон"
ITEM.description = "Base Item."
ITEM.category = "[MoonShine]"
ITEM.model = "models/props_junk/garbage_glassbottle002a.mdl"

ITEM.width = 1
ITEM.height = 1

function ITEM:GetDescription()
	local data = self:GetData("moonshinepercent", self.moonshinepercent) or 0
	return self.description.."\n\nКачество: "..data.."%"
end

ITEM.functions.consume = {
	name = "Выпить",
	sound = "npc/barnacle/barnacle_gulp1.wav",
	OnRun = function(self)
		local client = self.player

		local data = self:GetData("moonshinepercent", self.moonshinepercent) or 0

		local Boosts = {
			["stm"] = math.Round(math.Clamp(data / 3, 0, 12), 0),
			["str"] = math.Round(math.Clamp(data / 3, 0, 12), 0),
			["end"] = math.Round(math.Clamp(data / 3, 0, 12), 0),
		}

		client:GetCharacter():AddBoost("buff1", "stm", Boosts["stm"])
		client:GetCharacter():AddBoost("buff2", "str", Boosts["str"])
		client:GetCharacter():AddBoost("buff3", "end", Boosts["end"])
		
	end
}
