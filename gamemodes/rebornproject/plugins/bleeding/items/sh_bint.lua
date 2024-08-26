ITEM.name = 'Бинт'
ITEM.exRender = true 
ITEM.model = "models/kek1ch/dev_bandage.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(192.28, -241.82, 665.89),
	ang = Angle(65.07, 128.63, 0),
	fov = 0.71
}
ITEM.description = 'Асептический бинт для остановки кровотечения и предотвращения попадания в рану инфекции. При обычном кровотечении позволяет перевязать рану, при артериальном - перетянуть артерию.'
ITEM.category = "Медицина"
ITEM.itemleftamount = 2
ITEM.inventoryType = "hotkey"

ITEM.functions.use = {
	name = 'Использовать',
--	sound = "zwa/heal.mp3",
	OnRun = function(item)
		local player = item.player
		local character = player:GetCharacter()
		
		if (character:GetData("itemblock", true)) then
			return false
		end
		item:getrad()
		player:EmitSound("zwa/heal.mp3", 64)
		character:SetData("itemblock", true)
		
		player:SetAction("Использую...", 3.5, function()
				if player:get_bleeding() != 0 then
					player:set_bleeding(0)
				end
			character:SetData("itemblock", false)
			player:SetHealth(math.min(player:Health() + 10, 100))
		end)
		return false
	end,
	OnCanRun = function(item)
        return !IsValid(item.entity)
    end
}
function ITEM:get_itemleftamount() return self:GetData('itemleftamount', 36) end
function ITEM:set_itemleftamount(value) self:SetData('itemleftamount', value) end

function ITEM:OnInstanced(inv_id, x, y)
	self:set_itemleftamount(self.itemleftamount)
	self:SetData('itemleftamount', self.itemleftamount)
end

function ITEM:PopulateTooltip(tooltip)
	local itemleftamount = self:get_itemleftamount()
	if self:GetData('itemleftamount') == nil then
		return
	end
		local panel = tooltip:AddRowAfter('name', 'instuct')
		panel:SetBackgroundColor(derma.GetColor('Warning', tooltip))
		panel:SetText("Осталось использований: "..self:GetData('itemleftamount', 2)..".")
		panel:SizeToContents()
end

function ITEM:getrad(itemTable)
	local itemleftamount = self:GetData('itemleftamount')
	
	if (itemleftamount <= 1) then
		self:Remove()
	else
		itemleftamount = itemleftamount - 1
		self:SetData('itemleftamount', itemleftamount)	
	end
end