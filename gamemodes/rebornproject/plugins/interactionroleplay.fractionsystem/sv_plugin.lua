local PLUGIN = PLUGIN

function PLUGIN:LoadData()
	local capturepoints = ix.data.Get("capturepoints")
	local factiontables = ix.data.Get("factiontables")
	if capturepoints then
		for k,v in pairs(capturepoints) do
			local capture_ent = ents.Create("ix_capturepoint")
			capture_ent:SetPos(v.Capture_Position)
			capture_ent:SetAngles(v.Capture_Angles)
			capture_ent:Spawn()
			capture_ent:SetCaptureFraction(v.Capture_CaptureFraction)
			capture_ent:SetCaptureTime(v.Capture_CaptureTime)
			capture_ent:SetCaptureIncome(v.Capture_CaptureIncome)

			local physObj = capture_ent:GetPhysicsObject()
			if (IsValid(physObj)) then
				physObj:EnableMotion(false)
			end
		end
	end

	if factiontables then
		for k,v in pairs(factiontables) do
			local factiondesk_ent = ents.Create("ix_factiontable")
			factiondesk_ent:SetPos(v.Faction_Position)
			factiondesk_ent:SetAngles(v.Faction_Angles)
			factiondesk_ent:Spawn()
			factiondesk_ent:SetFraction(v.Faction_Fraction)
			factiondesk_ent:SetCurrStorage(v.Faction_CurrStorage)
			factiondesk_ent:SetMaxStorage(v.Faction_MaxStorage)
			factiondesk_ent:SetPassiveIncome(v.Faction_PassiveIncome)
			factiondesk_ent:SetUpgradeCostStorage(v.Faction_UpgradeCostStorage)
			factiondesk_ent:SetUpgradeCostPassive(v.Faction_UpgradeCostPassive)
			for k2,v2 in pairs(v.Faction_Relationships) do
				factiondesk_ent:SetNetVar(k2, v2)
			end

			factiondesk_ent:SetBankID(v.Faction_BankID)
			factiondesk_ent:SetUpgradeCostBank(v.UpgradeCostBank)
			factiondesk_ent:SetBankWH(v.CurrBank)
			

			local physObj = factiondesk_ent:GetPhysicsObject()
			if (IsValid(physObj)) then
				physObj:EnableMotion(false)
			end
		end
	end

	PLUGIN:SaveData()
end


function PLUGIN:SaveData()
	local capturepoints = {}
	for _, capturepoint in pairs( ents.FindByClass( "ix_capturepoint" ) ) do
		capturepoints[#capturepoints + 1] = {
			Capture_Position = capturepoint:GetPos(),
			Capture_Angles = capturepoint:GetAngles(),
			Capture_CaptureFraction = capturepoint:GetCaptureFraction(),
			Capture_CaptureTime = capturepoint:GetCaptureTime(),
			Capture_CaptureIncome = capturepoint:GetCaptureIncome()
		}

	end
	ix.data.Set("capturepoints", capturepoints)

	
	local factiontables = {}
	for _, factiontable in pairs( ents.FindByClass( "ix_factiontable" ) ) do

		local factionrelationship = {}
		for k,v in pairs(ix.faction.indices) do
			factionrelationship[v.name] = factiontable:GetNetVar(v.name) --v.name
		end

		factiontables[#factiontables + 1] = {
			Faction_Position = factiontable:GetPos(),
			Faction_Angles = factiontable:GetAngles(),
			Faction_Fraction = factiontable:GetFraction(),
			Faction_CurrStorage = factiontable:GetCurrStorage(),
			Faction_MaxStorage = factiontable:GetMaxStorage(),
			Faction_PassiveIncome = factiontable:GetPassiveIncome(),
			Faction_UpgradeCostStorage = factiontable:GetUpgradeCostStorage(),
			Faction_UpgradeCostPassive = factiontable:GetUpgradeCostPassive(),
			Faction_Relationships = factionrelationship,

			Faction_BankID = factiontable:GetBankID(),
			UpgradeCostBank = factiontable:GetUpgradeCostBank(),
			CurrBank = factiontable:GetBankWH(),
		}
	end
	ix.data.Set("factiontables", factiontables)
end


local sounds = {
	"buttons/button3.wav",
	"buttons/button9.wav",
	"buttons/button17.wav",
	"buttons/button19.wav",
}

netstream.Hook("fractionsystem::Buttons", function(client, entity, index, opts)
	if !entity then return end
	if !PLUGIN.Buttons[index] then return end
	local factionTable = ix.faction.Get(client:Team())
	local rankTable = factionTable.Ranks
	if !rankTable[client:GetCharacter():GetRank()][4] then return client:NotifyLocalized("cannotAllow") end

	local price = PLUGIN.Buttons[index].price
	local callback = PLUGIN.Buttons[index].callback

	if !callback then client:Notify("CALLBACK ERROR, DOESN'T HAVE ONE!") return end
	if entity:GetCurrStorage() < price then client:Notify("У вас не хватает очков для данного действия!") return end

	entity:SetCurrStorage(math.max(0, entity:GetCurrStorage() - price))
	entity:EmitSound(sounds[math.random(#sounds)], 75, 75)
	callback(client, entity, opts)
end)

netstream.Hook("fractionsystem::Relationship", function(client, entity, fraction, index)
	if !entity then return end
	if !PLUGIN.RelationshipOpts[index] then return end
	local factionTable = ix.faction.Get(client:Team())
	local rankTable = factionTable.Ranks
	if !rankTable[client:GetCharacter():GetRank()][4] then return client:NotifyLocalized("cannotAllow") end

	PLUGIN.RelationshipOpts[index](client, entity, fraction)
end)

netstream.Hook("fractionsystem::ChangeFraction", function(client, target, entity, rank)
	if !entity then return end

	local factionTable = ix.faction.Get(target:Team())
	local rankTable = factionTable.Ranks
	local character = target:GetCharacter()

	if (client:SteamID() == target:SteamID()) then return client:NotifyLocalized("cannotAllowRaiseYourself") end
	if not rankTable or not rankTable[rank] or not isnumber(rank) or (rank > #rankTable) then return client:NotifyLocalized("undefinedRank") end
	if (client:Team() ~= target:Team()) or !rankTable[client:GetCharacter():GetRank()][4] or (rank >= client:GetCharacter():GetRank()) then return client:NotifyLocalized("cannotAllowRaise") end

	if rankTable[rank][3] then
		local class = ix.class.list[rankTable[rank][3]]
		character:SetClass(class.index)
	end

	character:SetRank(rank)
	client:NotifyLocalized("characterRaisePlayer", target:Name(), rankTable[rank][1])
	target:NotifyLocalized("characterRaiseNotify", rankTable[rank][1])
end)

netstream.Hook("fractionsystem::Disqualify", function(client, target, entity)
	if !entity then return end
	local factionTable = ix.faction.Get(client:Team())
	local rankTable = factionTable.Ranks
	if target:Team() == client:Team() and rankTable[client:GetCharacter():GetRank()][4] then
		target:SetTeam(1)
		target:GetCharacter():SetRank(1)
		client:Notify("Вы исключили "..target:GetName().." из своего подразделения...")
	else
		return client:Notify("Ваше звание не позволяет это сделать")
	end
end)

netstream.Hook("fractionsystem::ChangeName", function(client, target, entity)
	if !entity then return end
	local factionTable = ix.faction.Get(client:Team())
	local rankTable = factionTable.Ranks
	if target:Team() == client:Team() and rankTable[client:GetCharacter():GetRank()][4] then
		local oldName = target:GetName()

		return client:RequestString("@chgName", "@chgNameDesc", function(text)
			target:GetCharacter():SetName(tostring(text))
			client:Notify("Вы изменили имя "..oldName.." на "..client:GetName())
		end, target:GetName())

	else
		return client:Notify("Ваше звание не позволяет это сделать")
	end
end)


----------------------------------------------------
local function ToNiceTime( seconds )

	if ( seconds == nil ) then return "ПАРУ СЕКУНД" end

	if ( seconds < 60 ) then
		local t = math.floor( seconds )
		return t .. " СЕК"
	end

	if ( seconds < 60 * 60 ) then
		local t = math.floor( seconds / 60 )
		return t .. " МИН"
	end
end

local function GetAreaShipment(client, bool)
    if !bool then return "НЕИЗВЕСТНО" end

    if client:GetArea() == "" then
        return "НЕИЗВЕСТНО"
    end

    return string.utf8upper(client:GetArea())
end

local RandomVectors = {
	Vector(12506, -5364, 1669),
	Vector(5020, -1993, 2437),
	Vector(5654, 76, 5357),
	Vector(-878, -7468, 470),
}

function PLUGIN:SpawnShipment(client, entity, shipment_name)
	local Shipments = {}
	local faction = ix.faction.Get(client:Team())
	local items = {}

	if (!faction) then
		for _, v in pairs(ix.faction.indices) do
			if (ix.util.StringMatches(L(v.name, client), client:Team())) then
				faction = v
				break
			end
		end
	end

	Shipments = PLUGIN.Shipments[shipment_name]

	for i=1, math.random(8) do
		Shipments[Shipments[math.random(#Shipments)]] = math.random(1, 10)
	end

	for k,v in pairs(Shipments) do
		if isnumber(k) then continue end

		items[k] = v
	end

	if (faction) then
		local entity = ents.Create("ix_newshipment")
		entity:Spawn()
		entity:SetPos(RandomVectors[math.random(#RandomVectors)]) --client:GetItemDropPos(entity))
		--entity:SetPos(Vector(817, -1621, -79))
		entity:SetItems(items)
		entity:SetNetVar("faction", faction.index)
		client:Notify("Вся информация о поставке была написана в чат!")
		client:ChatPrint("О вашей доставке узнают через ~4 минуты, успейте найти ее и забрать ее!")

		timer.Simple(4 * 60, function() -- 4 минуты
			ix.chat.Send(client, "event", "[ВНИМАНИЕ] БЫЛА ЗАКАЗАНА ПОСТАВКА ОТ ФРАКЦИИ: "..string.utf8upper(faction.name).." ОНА СТАНЕТ ОБЩЕДОСТУПНОЙ ЧЕРЕЗ "..ToNiceTime(ix.config.Get("ShipTimeout", 600)).." ВЫИСКИВАЙТЕ ГРУППУ ФРАКЦИИ ДЛЯ ПЕРЕХВАТА ПОСТАВКИ!")
		end)
	else
		return "@invalidFaction"
	end
end
----------------------------------------------------