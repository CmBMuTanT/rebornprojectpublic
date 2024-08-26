local PLUGIN = PLUGIN

ITEM.name = "Ручная зарядка"
ITEM.description = "Довоенная ручная зарядка! Позволит зарядить батарейки и аккумуляторы так, чтобы они не портились - как от динамо-машины."
ITEM.category = "[REBORN] ELECTRONIC"
ITEM.weight = 0.8
ITEM.exRender = true
ITEM.model = "models/cmbmtk/eft/thermometer.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-10.63, 0.03, 199.71),
	ang = Angle(87.7, 360.5, 0),
	fov = 3.34
}



ITEM.functions.use = {
    name = "Зарядить",
    tip = "useTip",
    icon = "icon16/wrench.png",
   
    OnRun = function( item, data )
        local client = item.player
        local character = client:GetCharacter()

        if item:GetData("BatteryCondition") ~= nil then
            netstream.Start(client, "CMBMTK::StartRecharge", item:GetData("BatteryCondition", 0))
        end

        return false
    end,

    OnCanRun = function( item )
        local client = item.player
        return !IsValid(item.entity)
    end,
}