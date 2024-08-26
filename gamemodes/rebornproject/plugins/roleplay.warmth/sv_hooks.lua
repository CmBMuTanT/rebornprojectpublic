
function PLUGIN:SetupTimer(client, character)
	local steamID = client:SteamID64()

	timer.Create("ixWarmth" .. steamID, ix.config.Get("warmthTickTime", 5), 0, function()
		if (IsValid(client) and character) then
			self:WarmthTick(client, character, ix.config.Get("warmthTickTime", 5))
		else
			timer.Remove("ixWarmth" .. steamID)
		end
	end)
end

function PLUGIN:SetupAllTimers()
	for _, v in ipairs(player.GetAll()) do
		local character = v:GetCharacter()

		if (character) then
			self:SetupTimer(v, character)
		end
	end
end

function PLUGIN:RemoveAllTimers()
	for _, v in ipairs(player.GetAll()) do
		timer.Remove("ixWarmth" .. v:SteamID64())
	end
end

function PLUGIN:WarmthEnabled()
	self:SetupAllTimers()
end

function PLUGIN:WarmthDisabled()
	self:RemoveAllTimers()
end

function PLUGIN:PlayerLoadedCharacter(client, character, lastCharacter)
	if (ix.config.Get("warmthEnabled", false)) then
		self:SetupTimer(client, character)
	end
end

function PLUGIN:PlayerDeath(client)
	local character = client:GetCharacter()

	if (character) then
		character:SetWarmth(100)
	end
end

local clothtbl = {
	"armor",
	"head_balaclava",
	"helmet",
	"legs",
	"armor",
}

function PLUGIN:WarmthTick(client, character, delta)
	if (!client:Alive() or
		client:GetMoveType() == MOVETYPE_NOCLIP or
		hook.Run("ShouldTickWarmth", client) == false or
		self:GetTemperature() > ix.config.Get("warmthMinTemp", 5)) then
		return
	end

	local scale = 1

	if (self:PlayerIsInside(client)) then
		scale = -ix.config.Get("warmthRecoverScale", 0.5)
	end

	-- check to see if the player is near any warmth-generating entities
	local entities = ents.FindInSphere(client:GetPos(), self.warmthEntityDistance)

	for _, v in ipairs(entities) do
		if (self.warmthEntities[v:GetClass()]) then
			scale = -ix.config.Get("warmthFireScale", 2)
		end
	end

	local ClothWarmTbl = {}
	for _, v in pairs(clothtbl) do
		local inv = client:ExtraInventory(v)
		local invequiped = inv:GetEquipedItem()

		if (inv and invequiped ) then -- проверять будем ТОЛЬКО сугубо на улице
			ClothWarmTbl[#ClothWarmTbl+1] = invequiped
		end
	end

	for k,v in ipairs(ClothWarmTbl) do

		if v:GetData("wearcondition") < 25 then continue end -- если одежда <25% то защищать от холода уже не будет вообще.

		scale = scale - v.Warm * .001
	end


	-- update character warmth
	local health = client:Health()
	local warmth = character:GetWarmth()
	local newWarmth = math.Clamp(warmth - scale * (delta / ix.config.Get("warmthLossTime", 5)), 0, 100)

	character:SetWarmth(newWarmth)

	if (newWarmth == 0) then
		local damage = ix.config.Get("warmthDamage", 2)

		if (damage > 0 and health > 5) then
			-- damage the player if we've ran out of warmth
			client:SetHealth(math.max(5, client:Health() - damage))
		elseif (newWarmth == 0 and ix.config.Get("warmthKill", false)) then
			-- kill the player if necessary
			client:Notify("Вы замерзли до смерти...")
			client:Kill()
		end
	end
end
