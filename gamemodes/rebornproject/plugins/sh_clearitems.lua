PLUGIN.name = "Clear Items"
PLUGIN.author = "Bilwin"
PLUGIN.description = "Clean your map from garbage"
PLUGIN.schema = "Any"

ix.config.Add("MapClearTime", 45, "Как часто очищаются элементы на карте.", nil, {
	data = {min = 0, max = 1000},
	category = "clearItems"
})

ix.lang.AddTable("english", {
	clearItems = "Очистить Элементы",
	mapCleared = "Мусор карты был очищен.",
	mapClearWarning = "Мусор карты будет очищен через 30 секунд!",
})


if ( SERVER ) then
	util.AddNetworkString("ixClearItems::Notify")
	util.AddNetworkString("ixClearItems::PreNotify")

	local ix = ix or {}
	ix.ClearItems = ix.ClearItems or {
		[ "ix_item" ]       = true,
		[ "ix_money" ]      = true,
		[ "ix_shipment" ]   = true
	}

	local function IsEmptyTable( t )
		return next( t ) == nil or false
	end

	local function clear()
		timer.Create("ixCleanMap", 60 * ix.config.Get("MapClearTime", 45), 0, function()
			net.Start("ixClearItems::PreNotify")
			net.Broadcast()

			timer.Simple( 30, function()
				for _, v in pairs( ents.FindByClass( "*" ) ) do
					if ix.ClearItems[ v:GetClass() ] then
						local itemtbl = ix.item.instances[v.ixItemID]
						if v.uniqueID == "note" then continue end
						
						v:Remove()
					end
				end

				if !IsEmptyTable(ix.ClearItems) then
					net.Start("ixClearItems::Notify")
					net.Broadcast()
				end
			end)
		end)
	end

	function PLUGIN:InitPostEntity()
		clear()
	end
elseif (CLIENT) then
	net.Receive("ixClearItems::Notify", function()
		if ( LocalPlayer() ) then
			LocalPlayer():NotifyLocalized("mapCleared")
		end
	end)

	net.Receive("ixClearItems::PreNotify", function()
		if ( LocalPlayer() ) then
			LocalPlayer():NotifyLocalized("mapClearWarning")
		end
	end)
end
