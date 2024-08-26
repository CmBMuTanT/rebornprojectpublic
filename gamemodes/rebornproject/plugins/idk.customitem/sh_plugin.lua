local PLUGIN = PLUGIN

PLUGIN.name = "Custom Items"
PLUGIN.author = "Gary Tate"
PLUGIN.description = "Enables staff members to create custom items."

ix.command.Add("CreateCustomItem", {
    description = "@cmdCreateCustomItem",
    adminOnly = true,
    arguments = {
        ix.type.string,
        ix.type.string,
        ix.type.string
    },
    OnRun = function(self, client, name, model, description)
        client:GetCharacter():GetInventory():Add("customitem", 1, {
            name = name,
            model = model,
            description = description
        })
    end
})

ix.command.Add("nameitem", { --команда для овнера
   description = "@cmdCreatenameitem",
   adminOnly = true,
    syntax = "<string name>",
    OnRun = function(client, arguments)
        if (!arguments[1] or !arguments[2]) then client:notify("Введите /nameitem id_предмета новое_имя") return false end
        client:getChar():getInv():add(arguments[1], 1, {
            customname = arguments[2],
        })
        client:notify("Предмет " .. arguments[1] .. " создан")
    end
})