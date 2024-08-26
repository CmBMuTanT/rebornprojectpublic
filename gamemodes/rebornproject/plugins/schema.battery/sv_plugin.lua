local PLUGIN = PLUGIN

function PLUGIN:LoadData()

    if timer.Exists("ixBatteryThink") then
        timer.Remove("ixBatteryThink")
    end

timer.Simple(1, function() 
        timer.Create("ixBatteryThink", 60, 0, function() --  пусть 1% заряда тратится каждые 6 секунд что по итогу делает 100% около 600 сек что делает около 10 минут одна батарейка (можешь увеличить с 6 на 60 секунд то будет уже 6000 сек он же 1.6 часов)
            self:BatteryThink()
        end)
    end)
end

local tableinventorys = {
    "radio",
    "pnv",
    "dynamo",
    "armband",
}

function PLUGIN:BatteryThink()
	for _, client in ipairs(player.GetAll()) do
		local character = client:GetCharacter()

		if (!client:Alive() or !character) then
			continue
		end

        local temptbl = {}

        --same as usual
        for k,v in pairs(tableinventorys) do
            local inv = client:ExtraInventory(v)
            if not inv then return end
            local invequiped = inv:GetEquipedItem()
    
            if (inv and invequiped and invequiped:GetData("BatteryCondition") ~= nil) then
                temptbl[#temptbl+1] = invequiped
            end
        end

        for k,v in ipairs(temptbl) do
            if v:GetData("BatteryCondition") <= 0 then continue end
            if (v.inventoryType == "pnv" and client:GetNW2Bool("vrnvgflipped") or v.inventoryType ~= "pnv") then
                v:SetData("BatteryCondition", math.max(0, v:GetData("BatteryCondition") - 1))
            end
        end
    end
end

netstream.Hook("CMBMTK::ProgressUpdate", function(client, data)
    local character = client:GetCharacter()

    if !client:Alive() and !character then return end

    local inventory = character:GetInventory()
    local item = inventory:HasItem("recharger")

    if item and item:GetData("BatteryCondition") ~= nil then
        item:SetData("BatteryCondition", math.Clamp(data, 0, 100))

        if data > 100 or data < 0 then
            client:Notify("Ты молодец конечно, но ты совсем дурак или че?") -- для тех кто любит поиграть с нетстримами. Да, меньше времени потратит, молодец, но в лимиты он не уйдет.
        end
    end
end)