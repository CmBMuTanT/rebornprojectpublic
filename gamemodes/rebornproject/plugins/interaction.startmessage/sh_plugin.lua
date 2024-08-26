PLUGIN.name = "Start message"
PLUGIN.author = "GeFake"
PLUGIN.description = "Hello message on character loaded"

ix.util.Include("cl_hooks.lua")

ix.lang.AddTable("russian", {
	optShowStartMessage = "Приветственное сообщение",
    optdShowStartMessage = "Включает отображение стартового сообщения при загрузке персонажа",
})

if (CLIENT) then
	ix.option.Add("showStartMessage", ix.type.bool, true, {
		category = "general"
	})
else
    function PLUGIN:PlayerLoadedCharacter(client, character, oldCharacter)
        timer.Simple(1.5, function()
            netstream.Start(client, "ixStartMessage")
        end)
    end
end