local PLUGIN = PLUGIN
PLUGIN.name = "Radio"
PLUGIN.author = "БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"

if SERVER then
    ix.util.Include("sv_plugin.lua")
end

--[[
——————————————————————————————————————no cmbmutant.xyz?———————————————————————————
          .                                                      .
        .n                   .                 .                  n.
  .   .dP                  dP                   9b                 9b.    .
 4    qXb         .       dX                     Xb       .        dXp     t
dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb
9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP
 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP
  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'
    `9XXXXXXXXXXXP' `9XX'   DIE    `98v8P'  HUMAN   `XXP' `9XXXXXXXXXXXP'
        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~
                        )b.  .dbo.dP'`v'`9b.odb.  .dX(
                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.
                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb
                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb
                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP
                     `'      9XXXXXX(   )XXXXXXP      `'
                              XXXX X.`v'.X XXXX
                              XP^X'`b   d'`X^XX
                              X. 9  `   '  P )X
                              `b  `       '  d'
                               `             '
—————————————————————————————————————————————————————————————————————————————————
]]
local PV = nil;
local LD = false;
local chatMessages = {
    Общий = {},
    Торговый = {},
    Анонимный = {}
}

local currentCategory = "Общий"

net.Receive("receiveMessage", function(len, ply)
    local message = net.ReadString()
    local sender = net.ReadEntity()
    local category = net.ReadString()
    local time = net.ReadString()

    local categoryMessages = chatMessages[category]
    if #categoryMessages > 50 then
        table.remove(categoryMessages, 1)
    end

    local newMessage = time..sender:Name().." : ".."("..category..") "..message
    table.insert(categoryMessages, newMessage)

    if LD then
        PLUGIN:RefreshChatMessages()
    end
end)

function PLUGIN:RefreshChatMessages()
    SDWB:SetText("")

    local categoryMessages = chatMessages[currentCategory]
    for _, message in ipairs(categoryMessages) do
        local sender, category, messageText = message:match("^(.-) : %((.-)%) (.-)$")

        SDWB:InsertColorChange(255, 255, 255, 255)
        SDWB:AppendText(sender)

        if category == "Общий" then
            SDWB:InsertColorChange(0, 255, 255, 255)
        else
            SDWB:InsertColorChange(0, 255, 0, 255)
        end
        SDWB:AppendText(" (" .. category .. ")")

        SDWB:InsertColorChange(255, 255, 255, 255)
        SDWB:AppendText(": " .. messageText .. "\n")
    end
end

function PLUGIN:OpenChatter()
    LD = true;

    local frame = vgui.Create("DFrame")
    frame:SetSize(ScrW() / 2, ScrH() / 2)
    frame:Center()
    frame:MakePopup()
    frame:SetTitle("")
    frame.OnClose = function(self)
        LD = false
        self:Remove()
    end

    frame.Paint = function(this, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30))
    end

    local panel = vgui.Create("DPanel", frame)
    panel:Dock(FILL)
    panel.Paint = function(this, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50))
    end

    SDWB = vgui.Create("RichText", panel)
    SDWB:Dock(FILL)
    SDWB:SetVerticalScrollbarEnabled(true)

    local enter = vgui.Create("DTextEntry", frame)
    enter:Dock(BOTTOM)
    enter.OnEnter = function(self)
        net.Start("sendMessage")
        net.WriteString(self:GetText())
        net.WriteString(currentCategory) -- Добавляем текущую выбранную категорию к сообщению
        net.SendToServer()
        self:SetText("")
        self:RequestFocus()
    end

    local categoryButton = vgui.Create("DButton", frame)
    categoryButton:SetText(currentCategory)
    categoryButton:Dock(TOP)
    categoryButton.DoClick = function()
        if currentCategory == "Общий" then
            currentCategory = "Торговый"
       -- elseif currentCategory == "Торговый" then
        --    currentCategory = "Анонимный"
        else
            currentCategory = "Общий"
        end
        categoryButton:SetText(currentCategory)
        self:RefreshChatMessages()
    end

    self:RefreshChatMessages()
end

net.Receive("Openchatter", function(len, ply)
    local ent = net.ReadEntity()
    if IsValid(ent) then
        PLUGIN:OpenChatter()
    end
end)
