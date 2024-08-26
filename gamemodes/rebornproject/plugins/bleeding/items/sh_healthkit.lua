ITEM.name = 'Гражданская аптечка'
ITEM.exRender = true 
ITEM.model = "models/kek1ch/dev_aptechka_low.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-57.25, -0.51, 731.85),
	ang = Angle(85.52, 360.44, 0),
	fov = 0.61
}
ITEM.bDropOnDeath = true
ITEM.description = 'Универсальный медицинский набор разового применения. Позволяет справляться с травмами различного типа и степени сложности: ранениями, ушибами мягких тканей, термическими и химическими ожогами, разного рода отравлениями.'
ITEM.category = "Медицина"
ITEM.itemleftamount = 3
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
		
		player:SetAction("Использую...", 5.5, function()
				if player:get_bleeding() != 0 then
					player:set_bleeding(player:get_bleeding() - 1)
				end
			character:SetData("itemblock", false)
			player:SetHealth(math.min(player:Health() + 25, 100))
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