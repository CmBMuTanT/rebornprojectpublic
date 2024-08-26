ITEM.name = "Шпилька"
ITEM.description = "Отмычка для взлома замков"
ITEM.model = "models/props_lab/box01a.mdl"

ITEM.width = 1
ITEM.height = 1

ITEM.weight = 0.1

ITEM.category = "LOCKPICK"


function ITEM:OnInstanced()
    self:SetData("Health", 100)
end