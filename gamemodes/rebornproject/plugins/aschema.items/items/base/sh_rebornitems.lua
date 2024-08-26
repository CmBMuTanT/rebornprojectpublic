ITEM.name = "Base Item"
ITEM.description = "Base Item."
ITEM.category = "[CATEGORY] TEST.name"
ITEM.model = "models/props_junk/watermelon01.mdl"

ITEM.width = 1
ITEM.height = 1

ITEM.maxStacks = 16
ITEM.quality = "common"
ITEM.qualitycolor = {
	["common"] = Color(75, 119, 190),
	["uncommon"] = Color(75, 75, 255),
	["rare"] = Color(204, 75, 255),
	["legendary"] = Color(255, 0, 0),
	["ultralegendary"] = Color(255, 255, 0),
}

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(
			item:GetData('stacks', 1), 'DermaDefault', w - 5, h - 5,
			color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black
		)
	end

	function ITEM:PopulateTooltip(tooltip)
		for k,v in pairs(self.qualitycolor) do
			if k == self.quality then
				local name = tooltip:GetRow("name")
				name:SetBackgroundColor(v)
			end
		end
	end
end



ITEM.functions.combine = {
	OnRun = function(firstItem, data)
        local firstItemStacks = firstItem:GetData('stacks', 1)
        local secondItem = ix.item.instances[data[1]]
        local secondItemStacks = secondItem:GetData('stacks', 1)
		local totalStacks = secondItemStacks + firstItemStacks

        if (firstItem.uniqueID ~= secondItem.uniqueID) then return false end
        if (totalStacks > firstItem.maxStacks) then return false end

		firstItem:SetData('stacks', totalStacks, ix.inventory.Get(firstItem.invID):GetReceivers())
		secondItem:Remove()

		return false
	end,
	OnCanRun = function(firstItem, data)
		return true
	end
}

ITEM.functions.split = {
	name = "Разделить",
	icon = "icon16/arrow_divide.png",
	OnRun = function(item)
		local client = item.player
		local character = client:GetCharacter()
		local itemUniqueID = item.uniqueID
		
		client:RequestString('Split', 'Введите, сколько элементов вы хотите разделить', function(splitStack)
			if !isnumber(tonumber(splitStack)) then client:Notify('Пожалуйста, введите`Число`') return false end
			local cleanSplitStack = math.Round(math.abs(tonumber(splitStack)))
			local stacks = item:GetData('stacks', 1)
            if (cleanSplitStack >= stacks) then return false end
			if (cleanSplitStack <= 0) then return false end
			local stackedCount = (stacks - cleanSplitStack)

			print(cleanSplitStack, stackedCount, stacks)
			if !character:GetInventory():Add(itemUniqueID, 1, {stacks = cleanSplitStack}) then
				ix.item.Spawn(itemUniqueID, client, nil, angle_zero, {stacks = cleanSplitStack})
			end

			item:SetData("stacks", stackedCount)
		end, '1')
		return false
	end,
	OnCanRun = function(item)
		return (item:GetData('stacks', 1) ~= 1)
	end
}