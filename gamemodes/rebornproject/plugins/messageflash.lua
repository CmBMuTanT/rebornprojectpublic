
PLUGIN.name = "Message Flash"
PLUGIN.description = "Flashes the client's Garry's Mod application when a message is posted in the chat."
PLUGIN.author = "Aspect™"
PLUGIN.readme = [[
Manyz people have been in this situation: You are playing in a server, and you are waiting for something, so you decide to tab out for just a bit, to do something else. Before you know it, someone has approached you and has been waiting for you to reply to his message for several minutes.
	
This plugin flashes your Garry's Mod application to alert you when you receive a message, allowing you to jump back into the roleplay when needed.]]


if (ix) then
	ix.lang.AddTable("english", {
		optFlashWindow = "Окно Уведомления",
		optdFlashWindow = "Должно ли ваше приложение Garry's Mod мигать при размещении сообщения в чате."
	})

	ix.option.Add("flashWindow", ix.type.bool, true, {
		category = "chat"
	})

	if (CLIENT) then
		function PLUGIN:MessageReceived(client, info)
			if (ix.option.Get("flashWindow", true) and system.IsWindows() and !system.HasFocus()) then
				system.FlashWindow()
			end
		end
	end
elseif (CLIENT) then -- Nutscript support
	function PLUGIN:OnChatReceived(client, chatType, text, anonymous)
		if (system.IsWindows() and !system.HasFocus()) then
			system.FlashWindow()
		end
	end
end
