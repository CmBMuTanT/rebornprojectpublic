local PLUGIN = PLUGIN

local icons = {	
	["[AR]"] = "user_gray",
	["[GLASSES]"] = "contrast",
	["[FACE COVERS]"] = "status_offline",
	["[HELMETS]"] = "emoticon_smile",
	["[BACKPACK]"] = "status_online",
	["[RIG]"] = "status_online",
}

spawnmenu.AddContentType("ixItem", function(container, data)
	if (!data.name) then return end

	local icon = vgui.Create("ixItemContentIcon", container)

	icon:SetName(data.name)
	icon:SetItemTable(data)
	icon:InvalidateLayout(true)
	icon:SetModel(data.model, data.skin or 0)
	icon:InvalidateLayout(true)

	if (IsValid(container)) then
		container:Add(icon)
	end

	return icon
end)

spawnmenu.AddCreationTab("Items", function()
	local base = vgui.Create("SpawnmenuContentPanel")
	local tree = base.ContentNavBar.Tree
	local categories = {}

	vgui.Create("ItemSearchBar", base.ContentNavBar)

	for _, v in SortedPairsByMemberValue(ix.item.list, "category") do
		if (!categories[v.category]) then
			categories[v.category] = true

			local node = tree:AddNode(L(v.category), icons[v.category] and ("icon16/" .. icons[v.category] .. ".png") or "icon16/brick.png")

			node.DoPopulate = function(self)
				if (self.Container) then return end

				self.Container = vgui.Create("ContentContainer", base)
				self.Container:SetVisible(false)
				self.Container:SetTriggerSpawnlistChange(false)

				for _, itemTable in SortedPairsByMemberValue(ix.item.list, "name") do

					if (itemTable.category == v.category) then
						spawnmenu.CreateContentIcon("ixItem", self.Container, itemTable)
					end
				end
			end

			node.DoClick = function(self)
				self:DoPopulate()
				base:SwitchPanel(self.Container)
			end
		end
	end

	local FirstNode = tree:Root():GetChildNode(0)

	if (IsValid(FirstNode)) then
		FirstNode:InternalDoClick()
	end

	PLUGIN:PopulateContent(base, tree, nil)

	return base
end, "icon16/script_key.png")

-- ensures the spawnmenu repopulates
timer.Simple(0, function()
	RunConsoleCommand("spawnmenu_reload")
end)