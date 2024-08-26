ITEM.name = "Спички"
ITEM.model = "models/props_junk/cardboard_box004a.mdl"
ITEM.description = "Обычные спички"

ITEM.width = 1
ITEM.height = 1

if (CLIENT) then
    function ITEM:GetDescription()
        local quantityr = self:GetData("quantityr")

        if (quantityr <= 0) then
            return self.description
        end
        
        local str = self.description .. "\n\nКоличество "..quantityr
        

        return str
    end
end


function ITEM:OnInstanced(invID, x, y, item)
    item:SetData("quantityr", math.random(5, 100))
end