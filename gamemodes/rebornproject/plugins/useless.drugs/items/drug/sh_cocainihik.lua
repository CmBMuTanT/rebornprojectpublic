ITEM.name = "Кокаин"
ITEM.description = "Белый порошок с горьким вкусом, видимо его надо принимать интраназально."
ITEM.model = Model("models/fallout 3/gum.mdl")
ITEM.category = "[REBORN] FUNNY"
ITEM.width = 1
ITEM.height = 1
ITEM.bDropOnDeath = true
ITEM.functions.sniff = {
	name = "Использовать",
	sound = "npc/barnacle/barnacle_gulp1.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		netstream.Start(client, "cocaine")

		client:GetCharacter():AddBoost("buff1", "agi", 2)
		client:GetCharacter():AddBoost("buff2", "stm", 10)
		client:GetCharacter():AddBoost("buff3", "con", 10)
		client:GetCharacter():AddBoost("debuff1", "medical", -10)
		client:GetCharacter():AddBoost("debuff2", "entretien", -10)
		

		hook.Run("SetupDrugTimer", client, client:GetCharacter(), itemTable.uniqueID, 35)


	end
}
