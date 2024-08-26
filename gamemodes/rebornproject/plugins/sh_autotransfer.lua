local PLUGIN = PLUGIN

PLUGIN.name = "Auto-Whitelist on Transfer"
PLUGIN.author = "salt"
PLUGIN.description = "Alters /PlyTransfer to grant a whitelist if the character doesn't have it already."


ix.command.Add("PlyTransfer", {
	description = "@cmdPlyTransfer",
	adminOnly = true,
	arguments = {
		ix.type.character,
		ix.type.text
	},
	OnRun = function(self, client, target, name)
		local faction = ix.faction.teams[name]

		if (!faction) then
			for _, v in pairs(ix.faction.indices) do
				if (ix.util.StringMatches(L(v.name, client), name)) then
					faction = v

					break
				end
			end
		end

		if (faction) then
			local bHasWhitelist = target:GetPlayer():HasWhitelist(faction.index)

		if (!bHasWhitelist) then
			if (!faction) then
				for _, v in ipairs(ix.faction.indices) do
					if (ix.util.StringMatches(L(v.name, client), name) or ix.util.StringMatches(v.uniqueID, name)) then
						faction = v
						break
					end
				end
			end

			if (faction) then
				if (target:GetPlayer():SetWhitelisted(faction.index, true)) then
					for _, v in ipairs(player.GetAll()) do
						if (self:OnCheckAccess(v) or v == target:GetPlayer()) then
							v:NotifyLocalized("whitelist", client:GetName(), target:GetPlayer():GetName(), L(faction.name, v))
						end
					end
				end
			else
				return "@invalidFaction"
				end
		end
				target.vars.faction = faction.uniqueID
				target:SetFaction(faction.index)

			if (faction.OnTransferred) then
						faction:OnTransferred(target)
			end

			for _, v in ipairs(player.GetAll()) do
						v:NotifyLocalized("cChangeFaction", client:GetName(), target:GetName(), L(faction.name, v))
			end
		else
			return "@invalidFaction"
		end
	end
})