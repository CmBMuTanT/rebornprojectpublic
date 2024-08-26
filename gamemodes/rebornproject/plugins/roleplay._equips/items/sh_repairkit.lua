ITEM.name = "Ремонтный набор для брони"
ITEM.description = "Задумайтесь, стоит-ли вам пытаться его использовать не имея навыка?.."
ITEM.category = "[REBORN] WORK"

ITEM.exRender = true 
ITEM.model = "models/kek1ch/dev_instrument_1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-195.39, 0.27, 45.03),
	ang = Angle(12.17, -0.19, 0),
	fov = 6.39
}


ITEM.width = 1
ITEM.height = 1


if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		local name = tooltip:GetRow("name")
		name:SetBackgroundColor(Color(75, 75, 255))
	end
end

ITEM.functions.Apply = {
	name = "Починка",
	tip = "useTip",
	icon = "icon16/arrow_right.png",
	isMulti = true,

	multiOptions = function( item, client )
        local result = {}
		local char = client:GetCharacter()

        for k, v in next, client:GetCharacter():GetInventory():GetItems() do
              if v:GetData("wearcondition") and v:GetData("wearcondition") < 100 then
				table.insert( result, {
					name = v.name,
					data = {datacondition = v:GetID()}
				} )
             end
        end

        return result
    end,

	OnRun = function(item, data)
		local client = item.player
		local char = client:GetCharacter()

		if data.datacondition then
			local repairitem = client:GetCharacter():GetInventory():GetItemByID(data.datacondition)
			repairitem:SetData("wearcondition", math.Clamp(repairitem:GetData("wearcondition") + math.random(5, 30), 0, 100)) -- маф рандом рандомная починка от 1 до 30
			return true
		end

		return false
	end,

	OnCanRun = function(item)
		local client = item.player
		return !IsValid(item.entity) and IsValid(client)
	end
}
