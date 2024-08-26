PLUGIN.name = "Miscellaneous"
PLUGIN.author = "ZeMysticalTaco, Frosty"
PLUGIN.description = "Крутые вещ."
PLUGIN.SaveEnts = PLUGIN.SaveEnts or {}
--skinny bars are disgusting
BAR_HEIGHT = 12


--[[-------------------------------------------------------------------------
	move settings to tab
---------------------------------------------------------------------------]]
if CLIENT then
	hook.Add("CreateMenuButtons", "ixSettings", function(tabs)
		tabs["settings"] = {
			Create = function(info, container)
				container:SetTitle(L("settings"))

				local panel = container:Add("ixSettings")
				panel:SetSearchEnabled(true)

				for category, options in SortedPairs(ix.option.GetAllByCategories(true)) do
					category = L(category)
					panel:AddCategory(category)

					-- sort options by language phrase rather than the key
					table.sort(options, function(a, b)
						return L(a.phrase) < L(b.phrase)
					end)

					for _, data in pairs(options) do
						local key = data.key
						local row = panel:AddRow(data.type, category)
						local value = ix.util.SanitizeType(data.type, ix.option.Get(key))

						row:SetText(L(data.phrase))
						row:Populate(key, data)

						-- type-specific properties
						if (data.type == ix.type.number) then
							row:SetMin(data.min or 0)
							row:SetMax(data.max or 10)
							row:SetDecimals(data.decimals or 0)
						end

						row:SetValue(value, true)
						row:SetShowReset(value != data.default, key, data.default)
						row.OnValueChanged = function()
							local newValue = row:GetValue()

							row:SetShowReset(newValue != data.default, key, data.default)
							ix.option.Set(key, newValue)
						end

						row.OnResetClicked = function()
							row:SetShowReset(false)
							row:SetValue(data.default, true)

							ix.option.Set(key, data.default)
						end

						row:GetLabel():SetHelixTooltip(function(tooltip)
							local title = tooltip:AddRow("name")
							title:SetImportant()
							title:SetText(key)
							title:SizeToContents()
							title:SetMaxWidth(math.max(title:GetMaxWidth(), ScrW() * 0.5))

							local description = tooltip:AddRow("description")
							description:SetText(L(data.description))
							description:SizeToContents()
						end)
					end
				end

				panel:SizeToContents()
				container.panel = panel
			end,

			OnSelected = function(info, container)
				container.panel.searchEntry:RequestFocus()
			end
		}
	end)
end

function PLUGIN:PlayerHurt(client, attacker, health, damage)
	if attacker:IsPlayer() then
		ix.log.AddRaw(client:Name() .. " has taken " .. damage .. " damage from " .. attacker:Name() .. " using " .. attacker:GetActiveWeapon():GetClass() .. " leaving them at " .. health .. " HP!", nil, Color(255, 200, 0))
	else
		ix.log.AddRaw(client:Name() .. " has taken " .. math.floor(damage) .. " damage from " .. attacker:GetClass() .. " leaving them at " .. math.floor(health) .. " HP!", nil, Color(255, 200, 0))
	end
end

local playerMeta = FindMetaTable("Player")

--[[-------------------------------------------------------------------------
	playerMeta:GetItemWeapon()

	Purpose: Checks the player's currently equipped weapon and returns the item and weapon.
	Syntax: player:GetItemWeapon()
	Returns: @weapon, @item
---------------------------------------------------------------------------]]

function playerMeta:GetItemWeapon()
	local char = self:GetCharacter()
	local inv = char:GetInventory()
	local items = inv:GetItems()
	local weapon = self:GetActiveWeapon()

	for k, v in pairs(items) do
		if v.class then
			if v.class == weapon:GetClass() then
				if v:GetData("equip", false) then
					return weapon, v
				else
					return false
				end
			end
		end
	end
end

------------------------------------------------------------Новое

function PLUGIN:CanPlayerUseBusiness()
	return false
end

function PLUGIN:CanProperty(client, property, entity)
	if not entity.isVendor then return end
	if property ~= "vendor_edit" or property ~= "vendor_edit_quest" then return end
	if not entity:GetPhysgunAllow() then return end
	
	return false
end



--[[-------------------------------------------------------------------------
	TAB MENU OPTIONS
---------------------------------------------------------------------------]]

hook.Add("PopulateScoreboardPlayerMenu", "ixAdmin", function(client, menu)
	if not LocalPlayer():IsAdmin() then return end
	if not client:IsValid() then return end

	local charopts = {}

	charopts["Изменить имя"] = {
		function()
			Derma_StringRequest("Изменить имя персонажа", "Какое имя ты хочешь установить?", client:Name(), function(text)
				ix.command.Send("CharSetName", client:Name(), text)
			end, nil, "Изменить", "Отмена")
		end
	}


	charopts["Изменить модель"] = {
		function()
			Derma_StringRequest("Изменить модель персонажа", "Введи путь к новой модели для этого персонажа", client:GetModel(), function(text)
				ix.command.Send("CharSetModel", client:Name(), text)
			end, nil, "Изменить", "Отмена")
		end
	}


	charopts["Сменить фракцию"] = {
		function()
			local menu = vgui.Create("DFrame")
			menu:SetSize(ScrW() / 3.5, ScrH() / 1.3)
			menu:MakePopup()
			menu:Center()
			menu:SetTitle("Изменить фракцию игрока")

			for k, v in pairs(ix.faction.indices) do
				local button = vgui.Create("DButton", menu)
				button:Dock(TOP)
				button:SetText(L(v.name))
				button:SetTall(30)
				button.DoClick = function()
					if v.uniqueID == "garda" then menu:Remove() return end
					ix.command.Send("PlyTransfer", client:Name(), v.uniqueID)
					menu:Remove()
				end
			end
		end
	}
	
	charopts["Изменить ранг"] = {
        function()
        --local ply = IsPlayer()
            Derma_StringRequest("Изменить ранг: " ..client:Name(), "Введите цифру: 1-7", "1", function(text)
                ix.command.Send("CharRank", client:Name(), text)
            end, nil, "Изменить", "Отмена")
        end
    }

	charopts["Респавн игрока"] = {
			function()
			ix.command.Send("CharRespawn", client:Name())
			end
		}
		local negr = client:Name()
		local pos1 = {
		Vector(-2508.085938, -5010.915039, -278.178864),
		Vector(-3211.601318, -4928.612305, -277.274414),
		Vector(-1961.492920, -4648.347656, -275.407043)
	}


	charopts["Сменить класс"] = {
		function()
			local menu = vgui.Create("DFrame")
			menu:SetSize(ScrW() / 3.5, ScrH() / 2)
			menu:MakePopup()
			menu:Center()
			menu:SetTitle("Изменить класс игрока")

			for k, v in pairs(ix.class.list) do
				if (v.faction == client:Team()) then
					local button = vgui.Create("DButton", menu)
					button:Dock(TOP)
					button:SetText(L(v.name))
					button:SetTall(65)
					button.DoClick = function()
						ix.command.Send("CharSetClass", client:Name(), v.uniqueID)
						menu:Remove()
					end
				end
			end
		end
	}
end)

ix.command.Add("CharRespawn", {
	description = "Возрождает мертвого персонажа.",
	adminOnly = true,
	arguments = {ix.type.character},
	OnRun = function(self, client, character)
		local target = character.player
		if IsValid(target) and target:IsPlayer() and target:Alive() then return client:Notify("Этого персонажа невозможно возродить!") end

		client:Notify("Ты возродил персонажа " .. target:Name())
		target:SetNetVar("deathTime", 0)

		if client ~= target then
			target:Notify("Твой персонаж был возраждён администратором " .. client:SteamName())
		end
	end
})

local pos = {
	Vector( -4042.235840, 738.582336, 139.031250),
	Vector(-2766.495850, 675.026062, 139.031250),
	Vector(-3394.383545, 962.291565, 139.031250)
}

ix.command.Add("GotoAdminZone", {
	description = "Телепортирует тебя в админ-зону.",
	adminOnly = true,
	OnRun = function(self, client)
		client:SetPos(table.Random(pos) + Vector(0, 0, 10))
	end,
})

ix.command.Add("BringAdminZone", {
    description = "Телепортирует игрока в админ-зону.",
    adminOnly = true,
    arguments = ix.type.character,
    OnRun = function(self, client, character)
    --if IsValid(target) and target:IsPlayer() and target:Alive() then return client:Notify("Этого игрока невозможно переместить в админ-зону!") end
    local target = character.player
    client:Notify("Вы переместили игрока в админ зону!")
    target:SetPos(table.Random(pos) + Vector(0, 0, 10))
    target:Notify("Вы перемещены в админ комнату администратором: "..client:SteamName())
    end,
})

ix.command.Add("CheckInventory", {
	description = "@cmdCheckInventory",
	adminOnly = true,
	arguments = ix.type.character,
	OnRun = function(self, client, target)
		if client:GetCharacter() == target then return end

		local clientInv = client:GetCharacter():GetInventory()
		local targetInv = target:GetInventory()

		if (clientInv and targetInv) then
			ix.storage.Open(client, targetInv, {
				name = target:GetName().."'Инвентарь",
				entity = target:GetPlayer(),
				searchTime = 0,
				data = {money = target:GetMoney()}
			})
		end
	end,
})