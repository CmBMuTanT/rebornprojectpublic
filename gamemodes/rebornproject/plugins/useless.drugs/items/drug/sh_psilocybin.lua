ITEM.name = "Псилоцибин"
ITEM.description = "Белый порошок имеет горький неприятный вкус, видимо его нужно принимать преорально."
ITEM.model = Model("models/fallout 3/gum.mdl")
ITEM.category = "[REBORN] FUNNY"
ITEM.width = 1
ITEM.height = 1
ITEM.bDropOnDeath = true
ITEM.functions.Sojrat = {
	name = "Использовать",
	sound = "npc/barnacle/barnacle_gulp1.wav",
	OnRun = function(itemTable)
		
		local client = itemTable.player
		netstream.Start(client, "lsdblyatz")

		client:GetCharacter():AddBoost("buff1", "con", 50)
		client:GetCharacter():AddBoost("debuff1", "medical", -50)
		client:GetCharacter():AddBoost("debuff2", "entretien", -50)
		

		hook.Run("SetupDrugTimer", client, client:GetCharacter(), itemTable.uniqueID, 35)
	end
}