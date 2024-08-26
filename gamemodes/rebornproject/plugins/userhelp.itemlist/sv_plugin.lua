util.AddNetworkString('MenuItemSpawn')
util.AddNetworkString('MenuItemGive')

local Timestamp = os.time()
local TRNDS = os.date( "%H:%M:%S - %d/%m/%Y" , Timestamp )
local function check(client)
	return client:IsSuperAdmin() or client:GetCharacter():HasFlags("c")
end

net.Receive('MenuItemSpawn', function(len, client)
	local uniqueID = net.ReadString()
	
	if not isstring(uniqueID) then return end
	if not check(client) then return end
--	if restrictuniqueids[uniqueID] then return client:SendLua([[chat.AddText( Color( 255, 0, 0), "ERROR!")]]) end
	
	if (ix.item.list[uniqueID]) then
		local vStart = client:GetShootPos()
		local trace = {}

		trace.start = vStart
		trace.endpos = vStart + (client:GetAimVector() * 2048)
		trace.filter = client

		local tr = util.TraceLine(trace)
		local ang = client:EyeAngles()
		ang.yaw = ang.yaw + 180
		ang.roll = 0
		ang.pitch = 0
		
		ix.item.Spawn(uniqueID, tr.HitPos, function(item)
			client:Notify("Вы создали " .. item.name .. ".")
		--	execute_webhook(webhookz, {embeds = {{color = 16711680, title = "OFFLINE LOGS\n".. "ВРЕМЯ ЛОГА: " ..TRNDS.. "\n" .. GetHostName(), description = client:SteamID().." Создал "..item.name}}})
		end, ang)
	end
end)

net.Receive('MenuItemGive', function(len, client)
	local uniqueID = net.ReadString()
	
	if not isstring(uniqueID) then return end
	if not check(client) then return end
	--if restrictuniqueids[uniqueID] then return client:SendLua([[chat.AddText( Color( 255, 0, 0), "ERROR!")]]) end
	
	local item_object = ix.item.list[uniqueID]
	if (item_object) then
		local result, message = client:GetCharacter():GetInventory():Add(uniqueID)
		if (!result) then
			client:NotifyLocalized(message)
		else
			client:Notify("Вы выдали "..client:Name().." следующий предмет: " .. item_object.name .. ".")
		--	execute_webhook(webhookz, {embeds = {{color = 16711680, title = "OFFLINE LOGS\n".. "ВРЕМЯ ЛОГА: " ..TRNDS.. "\n" .. GetHostName(), description = client:SteamID().." Выдал предмет "..item_object.name}}})
		end
	end
	
	item_object = nil
end)