require("chttp")
ZHTTP = CHTTP
webhookzpoligon = "https://discord.com/api/webhooks/1135174447012270130/_vcaIKmqSNhGeBdzsZpStkv8zQ-PY6blhjQZ8_I87KqMGt4ZtECYjckI4YY5QJGLrKG_"

    function execute_poligon(webhookzpoligon, params)
	return ZHTTP({
		method = "POST",
		url = webhookzpoligon,
		body = util.TableToJSON(params),
		type = "application/json"
	})
    end


local Timestamp = os.time()
local TRNDS = os.date( "[%d/%m/%Y - %H:%M:%S]" , Timestamp )


netstream.Hook("POLIGON_EXECUTE", function(client, btn) -- да элзифы, потому что мне лень.
    if btn == 72 then
    execute_poligon(webhookzpoligon, {embeds = {{color = 38400, title = "OFFLINE LOGS\n".. "ВРЕМЯ ЛОГА: " ..TRNDS.. "\n" .. GetHostName(), description = client:Nick() .. " (" .. client:SteamID() .. ") нажал на кнопку INSERT..."}}})
    
    elseif btn == 73 then
    execute_poligon(webhookzpoligon, {embeds = {{color = 38400, title = "OFFLINE LOGS\n".. "ВРЕМЯ ЛОГА: " ..TRNDS.. "\n" .. GetHostName(), description = client:Nick() .. " (" .. client:SteamID() .. ") нажал на кнопку DELETE..."}}})
            
    elseif btn == 74 then
    execute_poligon(webhookzpoligon, {embeds = {{color = 38400, title = "OFFLINE LOGS\n".. "ВРЕМЯ ЛОГА: " ..TRNDS.. "\n" .. GetHostName(), description = client:Nick() .. " (" .. client:SteamID() .. ") ннажал на кнопку HOME..."}}})
                
    elseif btn == 75 then
    execute_poligon(webhookzpoligon, {embeds = {{color = 38400, title = "OFFLINE LOGS\n".. "ВРЕМЯ ЛОГА: " ..TRNDS.. "\n" .. GetHostName(), description = client:Nick() .. " (" .. client:SteamID() .. ") ннажал на кнопку END..."}}})
    
    end 

end)
