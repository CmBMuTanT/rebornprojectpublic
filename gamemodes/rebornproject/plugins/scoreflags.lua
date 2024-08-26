

local PLUGIN = PLUGIN or {}

PLUGIN.name = "Scoreboard Flags"
PLUGIN.author = "Liquidv2"
PLUGIN.description = "Adds a flag button to the player context options. (Scoreboard)"
PLUGIN.readme = [[
Adds a flag button to the player context options.

Adds a 'Performance' config option so that not every change gets directly sent to the server.
]]


ix.lang.AddTable("russian", {
    editFlags = "Редактирование флагов.",
    noFlagsEdited = "Нет флагов для редактирования!",
    flagEdited = "%s Редактировал '%s' флаги.", --For now unused, just left here for logs if someone wants to add them
    flagEditSuccess = "Флаги были успешно редактированны у персонажа: \"%s\".",
})



ix.config.Add("scoreboardflagsPerformance", false, "Добавляет кнопку «Сохранить» в меню флагов, чтобы не каждое изменение напрямую отправлялось на сервер..", nil, {
    category = "Scoreboard Flags"
})



if (CLIENT) then
    
    local function ReverseConcat(table) -- table.concat but for non-numericle table
        local string = ""
        for k,v in pairs(table) do
            string = string .. k
        end
        return string
    end
    
    local function ChangeFlag(charid,flags)
        net.Start("SCOREFLAGS:CHANGEFLAG")
            net.WriteString(tostring(charid)) --The safest way I could think of to support big and small server. (or F them both the same way, howerver you want to see it)
            net.WriteString(ReverseConcat(flags))
            net.SendToServer()
        end
        
    local configCheck = ix.config.Get("scoreboardflagsPerformance")
    local flags = nil
    local char = nil
    function PLUGIN:PopulateScoreboardPlayerMenu(client, menu)
        if ix.command.HasAccess(client, "CharGiveFlag") then
            menu:AddOption( L("editFlags"), function() 

                configCheck = ix.config.Get("scoreboardflagsPerformance")
                flags = {}
                char = client:GetCharacter()

                local DFrame = vgui.Create( "DFrame" )	
                DFrame:SetSize( 700, 350 )
                DFrame:SetTitle( L("editFlags") )
                DFrame:MakePopup()
                DFrame:Center()

                local flagList = vgui.Create( "ixSettings", DFrame)
                flagList:Dock(FILL)

                for k,v in pairs(ix.flag.list) do
                    if ispanel(v) then continue end
                    local row = flagList:AddRow(ix.type.bool)
                    if char:HasFlags(k) then row.setting:SetChecked(true) end
                    row:SetText("[" .. k .. "] " .. v["description"])

                    row.setting:SizeToContents()
                    row:SizeToContents()

                    row.OnValueChanged = function(panel, bEnabled)
                        if configCheck then
                            if flags[k] then flags[k] = nil else flags[k] = true end
                        else
                            ChangeFlag(char:GetID(),{[k] = true})
                        end
                    end
                end
                
                if configCheck then
                    local saveButton = vgui.Create("ixMenuButton", DFrame)
                    saveButton:SetSize(DFrame:GetWide(), 35)
                    saveButton:SetPos(0,DFrame:GetTall() - 35.5)
                    saveButton:SetText(L("save"))

                    function saveButton:DoClick()
                        if table.IsEmpty(flags) then LocalPlayer():Notify(L("noFlagsEdited")) return end

                        ChangeFlag(char:GetID(),flags)
                        flags = {}
                    end

                    flagList:Dock(NODOCK)
                    flagList:SetSize(DFrame:GetWide(), DFrame:GetTall() - (saveButton:GetTall()*2))
                    flagList:SetPos(0,saveButton:GetTall())
                end

                flagList:SizeToContents()
                DFrame:SizeToContents()
            end)
        end
    end
else
    local function ToggleFlag(char, flag)
        if !char then return end
        if char:HasFlags(flag) then
            char:TakeFlags(flag)
        else
            char:GiveFlags(flag)
        end
    end

    util.AddNetworkString("SCOREFLAGS:CHANGEFLAG")
    net.Receive("SCOREFLAGS:CHANGEFLAG", function(len,ply)
        if ix.command.HasAccess(ply, "CharGiveFlag") then
            
            local editchar = tonumber(net.ReadString())
            editchar = ix.char.loaded[editchar]
            if !editchar then ix.util.Notify(L("charNoExist", ply), ply) return end
            
            local flags = net.ReadString()
            for k,v in ipairs(string.ToTable(flags)) do
                ToggleFlag(editchar, v)
            end
            
            ix.util.Notify(L("flagEditSuccess",ply,editchar:GetName()), ply)
            --[Add Logs here if needed]--
        end
    end)
end
