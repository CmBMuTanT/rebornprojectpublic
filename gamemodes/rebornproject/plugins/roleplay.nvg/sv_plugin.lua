local PLUGIN = PLUGIN

util.AddNetworkString("vrnvgnetflip")
util.AddNetworkString("vrnvgnetflashlight")

local nv = {
    goglightblue = true,
    goggreen = true,
    gogblue = true,
    gogred = true,
}

netstream.Hook("enable_nvgoogles", function(client)
	local inv = client:ExtraInventory("pnv")

	if inv:GetEquipedItem() and nv[inv:GetEquipedItem().uniqueID] then
        PLUGIN.nvg_toggle = !PLUGIN.nvg_toggle
        net.Start("vrnvgnetflip")
        net.WriteBool(PLUGIN.nvg_toggle)
        net.Send(client)
	end
end)


function PLUGIN:Think()
	for k, v in pairs(player.GetAll()) do
		if !v.nvgbattery then 
			v.nvgbattery = 80
		end
    
        if PLUGIN.nvg_toggle then 
            v:SetNW2Bool("vrnvgflipped", true)
            v.nvgbattery = math.Approach(v.nvgbattery, 0, FrameTime())
        else 
            v:SetNW2Bool("vrnvgflipped", false)
            v.nvgbattery = math.Approach(v.nvgbattery, 80, FrameTime()*4)
        end
        
        v:SetNW2Int("vrnvgbattery", v.nvgbattery)

	end
end
