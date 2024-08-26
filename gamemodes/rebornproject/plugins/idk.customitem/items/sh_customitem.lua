ITEM.name = "Вещь"
ITEM.description = "Предмет который лучше взять"
ITEM.model = Model("models/akabenko/item_id2.mdl")

function ITEM:GetName()
    return self:GetData("name", "Custom Item")
end

function ITEM:GetDescription()
    return self:GetData("description", "Custom item description.")
end

function ITEM:GetModel()
    return self:GetData("model", "models/Gibs/HGIBS.mdl")
end
