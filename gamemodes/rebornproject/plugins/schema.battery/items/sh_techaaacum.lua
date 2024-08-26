local PLUGIN = PLUGIN

ITEM.name = "АА-Аккумулятор"
ITEM.description = "Обычный АА-Аккумулятор, отличается от батарейки тем что его можно зарядить, нужен для подпитки чего то."
ITEM.category = "[REBORN] ELECTRONIC"
ITEM.width = 1
ITEM.height = 1

ITEM.exRender = true
ITEM.model = "models/cmbmtk/eft/aabattery.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-109.06, 724.75, 40.72),
	ang = Angle(3.18, 278.56, 0),
	fov = 0.38
}


function ITEM:OnInstanced()
    self:SetData("BatteryCondition", self:GetData("BatteryCondition") or 100)
end

function ITEM:PopulateTooltip(tooltip)
    if (self.entity) then
        return L(self.description)
    else
        local condition = tooltip:AddRowAfter("description", "condition")
        condition:SetText("Заряд: ".. math.floor(self:GetData("BatteryCondition", 100)).."%")
        condition:SetBackgroundColor(Color(0, 170, 255))
        condition:SizeToContents()
    end
end

ITEM.functions.use = {
    name = "Вставить",
    tip = "useTip",
    icon = "icon16/wrench.png",
    isMulti = true,
    multiOptions = function( item, client )
        local targets = {}
        -- local itemstocharge = {
        --     ["dosimetr"] = true,
        --     ["geiger"] = true,
        --     ["chatter"] = true,
        --   }

        for k, v in next, client:GetCharacter():GetInventory():GetItems() do
            if PLUGIN.itemstocharge[v.uniqueID] then
                table.insert( targets, {
                    name = v.name,
                    data = { v.id, item:GetData("BatteryCondition", 100) },
                } )
            end
        end

        return targets
    end,
    OnCanRun = function( item )
        local client = item.player
        return !IsValid(item.entity) and IsValid(client) and item.invID == client:GetCharacter():GetInventory():GetID()
    end,
    OnRun = function( item, data )
        if data and data[1] and data[2] then
            local client = item.player
            local item = client:GetCharacter():GetInventory():GetItemByID( data[1], true )
            if not item then return false end

            if item:GetData("BatteryCondition", nil) then
                if item:GetData("IsBattery", nil) then
                    client:GetCharacter():GetInventory():Add("techaabatt", 1, {BatteryCondition = item:GetData("BatteryCondition")})
                else
                    client:GetCharacter():GetInventory():Add("techaaacum", 1, {BatteryCondition = item:GetData("BatteryCondition")})
                end
            end
            
            item:SetData("BatteryCondition", data[2])
            item:SetData("IsBattery", false) -- XD
            client:EmitSound("eftsounds/gear_helmet_use.wav")

            return true
            
        end

        return false
    end,
}