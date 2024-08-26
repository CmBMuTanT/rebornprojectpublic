return {
	{name = "Рюкзак", icon = "https://i.imgur.com/16YvS0l.png", build = function(parent, menu)
		parent:Add("StalkerInventory")
	end},
	{name = "Помощь", icon = "https://i.imgur.com/1XjZsfW.png", build = function(parent)
		parent:Add("ixHelpMenu")
	end},
	{name = "Настройки", icon = "https://i.imgur.com/uAKGPiJ.png", build = function(parent)
		local panel = parent:Add("ixSettings")
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
		panel:Dock(FILL)
	end},
	{name = "Герой", icon = "https://i.imgur.com/VjuL23S.png", build = function(parent)
		parent.infoPanel = parent:Add("ixCharacterInfo")

		parent.OnMouseReleased = function(this, key)
			if (key == MOUSE_RIGHT) then
				this.infoPanel:OnSubpanelRightClick()
			end
		end

		parent.infoPanel:Update(LocalPlayer():GetCharacter())


		local person = parent:Add("IncredibleModel")
		person:Dock(FILL)
		person:SetLocalPlayer()
	end},
	{spacer = 36},

	{name = "Крафт", icon = "https://i.imgur.com/1XjZsfW.png", build = function(parent)
		parent:Add("ixCrafting")
	end},

	--{name = "Права-CMD", icon = "https://i.imgur.com/9qLKvme.png"},
    {
        name = "Игроки",
        icon = "https://i.imgur.com/9qLKvme.png",
        build = function(parent)
            parent:Add("ixScoreboard")
        end
    },

	{name = "Персонажи", icon = "https://i.imgur.com/kiq1R3I.png", build = function(_, menu)
		vgui.Create("ixCharMenu")
		menu:Remove()
	end},
	{name = "Конфигурация", icon = "https://i.imgur.com/uAKGPiJ.png", customCheck = function(ply)
		return ply:IsSuperAdmin()
	end, build = function(parent)
		parent:Add("ixConfigManager")
	end}
}