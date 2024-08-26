PLUGIN.name = "Announcements"
PLUGIN.desc = "Chat Announcements"
PLUGIN.author = "Zeus0x00, Clayworks"
--if (CLIENT) then
	local announcements = {"Не забывайте, что вы можете просмотреть наши правила открыв TAB вкладку информация", "Отсутствуют текстуры? В нашем дискорде есть вся необходимая информация..", "Нужна помощь персонала? Напишите !report и напишите подробно вашу проблему"}
	local n = 1
	timer.Create( "announce", 150, 0, function()
	    if CLIENT then
    		if announcements[n] == nil then
    			n = 1
    		end
    		chat.AddText(Color(255,255,255),"[Объявления] " .. tostring(announcements[n]))
    		n = n + 1
    	end
    	if SERVER then
    	    if announcements[n] == nil then
    			n = 1
    		end
    		print("[Объявления] " .. tostring(announcements[n]))
    		n = n + 1
	    end
	end)
--end