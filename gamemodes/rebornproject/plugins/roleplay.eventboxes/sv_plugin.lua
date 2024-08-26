local PLUGIN = PLUGIN


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

ix.command.Add("StartShipmentEvent", {
    description = "Создать ивент с дропом",
    superAdminOnly = true,
    arguments = {
        ix.type.string,
        ix.type.string
    },
    OnRun = function(self, client, faction_team, shipment_name)
        if !istable(PLUGIN.shipment_category[shipment_name]) then return "такова нету" end

        local Shipments = {}
        local faction = ix.faction.teams[faction_team]
        local items = {}

        if (!faction) then
            for _, v in pairs(ix.faction.indices) do
                if (ix.util.StringMatches(L(v.name, client), faction_team)) then
                    faction = v
                    break
                end
            end
        end

        Shipments = PLUGIN.shipment_category[shipment_name]

        for i=1, math.random(ix.config.Get("ItemsDropCount")) do
            Shipments[Shipments[math.random(#Shipments)]] = math.random(1, ix.config.Get("ItemDropCount"))
        end

        for k,v in pairs(Shipments) do
            if isnumber(k) then continue end

            items[k] = v
        end

        if (faction) then
            local entity = ents.Create("ix_newshipment")
            entity:Spawn()
            entity:SetPos(client:GetItemDropPos(entity))
            entity:SetItems(items)
            entity:SetNetVar("faction", faction.index)
            ix.chat.Send(client, "event", "[ВНИМАНИЕ] БЫЛА ЗАКАЗАНА ПОСТАВКА ОТ ФРАКЦИИ: "..string.utf8upper(faction.name).." ОНА СТАНЕТ ОБЩЕДОСТУПНОЙ ЧЕРЕЗ "..ToNiceTime(ix.config.Get("ShipTimeout", 600)).." ПРИБЛИЗИТЕЛЬНОЕ МЕСТО ПОСТАВКИ: "..GetAreaShipment(client, true))
        else
            return "@invalidFaction"
        end
    end
})
  