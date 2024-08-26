ITEM.name = "Сувенирная монета 'BIT COCO IN'"
ITEM.description = "Обычная довоенная монетка, которая продавалась буквально в каждом киоске.. Примерно в 2019-2020-х годах на станциях «ССКЛ» объявили программу на скупку этих монеток, и как ни странно - сталкеры стали с большим ажиотажем сдавать их как основополагающий расходный мусор. Прошло два года - и эта монетка стала ведуще-курсовой валютой в мире послевоенного казино.. Хотя, может и врут.."
ITEM.category = "[CASINO]"
ITEM.exRender = true
ITEM.model = "models/cmbmtk/eft/bitcoin.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(25.32, 0.34, 733.63),
	ang = Angle(88.02, 180.76, 0),
	fov = 0.14
}


ITEM.width = 1
ITEM.height = 1

ITEM.weight = 0.1

ITEM.maxStacks = 250 -- лучше 250 оставить и все (хотя путем обмена и дрочи можно это обойти, но это не страшно)

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(
			item:GetData('stacks', 1), 'DermaDefault', w - 5, h - 5,
			color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black
		)
	end

	function ITEM:PopulateTooltip(tooltip)
		local name = tooltip:GetRow("name")
		name:SetBackgroundColor(Color(255, 255, 0))
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
		local stacks = item:GetData('stacks', 1)
		client:RequestString('Split', 'Введите, сколько элементов вы хотите разделить', function(splitStack)
			if !isnumber(tonumber(splitStack)) then client:Notify('Пожалуйста, введите`Число`') return false end
			local cleanSplitStack = math.Round(math.abs(tonumber(splitStack)))
			if (cleanSplitStack >= stacks) then return false end
			if (cleanSplitStack <= 0) then return false end
			local stackedCount = (stacks - cleanSplitStack)

			--print(cleanSplitStack, stackedCount, stacks)
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