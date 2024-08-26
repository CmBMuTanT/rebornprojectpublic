local PLUGIN = PLUGIN

util.AddNetworkString("sendMessage")
util.AddNetworkString("receiveMessage")


require("chttp")

HTTP = CHTTP
function PLUGIN:SendHTTPRequest(params)
    return HTTP({
		method = "POST",
		url = "https://discord.com/api/webhooks/1181731371450900560/STd_pHt6IQfCgpim2YsO4tMcy6qN_4PG_0RH5BPZ3sX4Y5OJ0UWtesVs4E5GaIJ9AM9K",
		body = util.TableToJSON(params),
		type = "application/json"
	})
end

net.Receive("sendMessage", function(len, ply)
    local message = net.ReadString()
    local category = net.ReadString() -- Дополнительный параметр: категория сообщения
    local Timestamp = os.time()
    local TRN = os.date( "[%H:%M:%S] " , Timestamp )
    
    net.Start("receiveMessage")
    net.WriteString(message)
    net.WriteEntity(ply)
    net.WriteString(category)
    net.WriteString(TRN)
    net.Broadcast()

    if category == "Анонимный" then
        PLUGIN:SendHTTPRequest({embeds = {{color = 38400, title = "ВСЕОБЩАЯ ЧАСТОТА РАДИОЛЮБИТЕЛЕЙ УКВ ДИАПОЗОНА"..TRN.."\n[КООРДИНАТЫ НЕИЗВЕСТНЫ]", description = "{НЕИЗВЕСТНЫЙ КАНАЛ}".."\n [ПОЗЫВНОЙ НЕ УКАЗАН]: "..message}}})
    else
        PLUGIN:SendHTTPRequest({embeds = {{color = 38400, title = "ВСЕОБЩАЯ ЧАСТОТА РАДИОЛЮБИТЕЛЕЙ УКВ ДИАПОЗОНА"..TRN.."\n"..GetHostName(), description = "{"..category.."}".."\n ["..ply:Nick().."]: "..message}}})
    end

    for k, v in pairs(ents.FindByClass("ix_radiochat")) do
        if ply:IsSuperAdmin() then
            v:EmitSound("gasmask/watch_timer_set_loop.wav") -- звук, если написал админ
        else
            v:EmitSound("gasmask/watch_timer_set.wav") -- обычный звук, если написал любой пользователь
        end
    end
end)
