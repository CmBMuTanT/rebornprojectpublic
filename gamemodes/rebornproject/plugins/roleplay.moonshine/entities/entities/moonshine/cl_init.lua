include("shared.lua")
local PLUGIN = PLUGIN


function ENT:DrawTranslucent()
    self:DrawModel()

    DoDraw(self)
end

local state = nil
local itemtable2 = nil
local time = math.random(65, 130)

function DoDraw(self)
    local imgui = PLUGIN.IMGUI
    local dist = LocalPlayer():GetPos():DistToSqr(self:GetPos())
    local alpha = 300 - dist * 0.05
    if alpha >= 0 then
        if imgui.Entity3D2D(self, Vector(8, 0, 65), Angle(0, 90, 90), 0.1) then
            
                local yy = 0
                local yyy = 15
                draw.RoundedBox(0, 0, 0, 180, 180, Color(10, 10, 10, alpha))

            if !state then
                for k,v in pairs(PLUGIN.MoonShines) do
                    local itemtable = ix.item.Get(k)
                    if imgui.xTextButton(itemtable.name, "!Roboto@24", 0, yy, 180, 25, 1, Color(255, 255, 255, alpha), Color(150, 50, 0, alpha), Color(255,100, 0, alpha)) then
                        LocalPlayer():EmitSound("buttons/combine_button3.wav",100,200)
                        state = itemtable.uniqueID

                        itemtable2 = v
                    end
                    yy = yy + 27
                end
            elseif state == "craft" then
                draw.SimpleText("В процессе...", imgui.xFont("!Roboto@24"), 38, 155, Color(255, 255, 255, alpha))
                PLUGIN.DownloadIcon("https://i.imgur.com/0YyjEhU.png", function(person)
                    surface.SetDrawColor(Color(20, 150, 200, alpha))
                    surface.SetMaterial( person )
                    surface.DrawTexturedRectRotated(90, 50, 90, 90, CurTime() % 360 * 100)
                end)
            else
                draw.SimpleText("Необходимо для приготовления", imgui.xFont("!Roboto@13"), 8, 0, Color(255, 255, 255, alpha))
                for k,v in pairs(itemtable2) do
                    local itemreq = ix.item.Get(v)
                    draw.SimpleText("-"..itemreq.name, imgui.xFont("!Roboto@20"), 8, yyy, Color(255, 255, 255, alpha))
                    yyy = yyy + 15
                end
                if imgui.xTextButton("<Назад", "!Roboto@24", 0, 155, 90, 25, 1, Color(255, 255, 255, alpha), Color(150, 50, 0, alpha), Color(255,100, 0, alpha)) then LocalPlayer():EmitSound("buttons/combine_button3.wav",100,200) state = nil itemtable2 = nil end
                
                if imgui.xTextButton("Вперед>", "!Roboto@24", 90, 155, 90, 25, 1, Color(255, 255, 255, alpha), Color(150, 50, 0, alpha), Color(255,100, 0, alpha)) then 

                if LocalPlayer():GetCharacter():GetInventory():HasItems(itemtable2) then
                        LocalPlayer():EmitSound("buttons/combine_button3.wav",100,200) 
                        self:EmitSound("ambient/fire/mtov_flame2.wav",100,150)
                        self:EmitSound("ambient/atmosphere/laundry_amb.wav", 100, 60)
                        self:SetSkin(0)
                        local choicecraft = state

                        if timer.Exists("DoCraftMoonShine") then
                            timer.Remove("DoCraftMoonShine")
                        end
                        timer.Create("DoCraftMoonShine", time, 1, function()
                            netstream.Start("DoCraftMoonShine", choicecraft) -- XDDDD ONLY IN YOUR MIND TODO: TIME SYNC VIA NET
                            state = nil
                            self:StopSound("ambient/atmosphere/laundry_amb.wav")
                            self:EmitSound("buttons/button5.wav", 100, 75)
                            self:SetSkin(1)
                        end)
                        state = "craft" 
                        itemtable2 = nil 
                    else
                        LocalPlayer():EmitSound("buttons/combine_button_locked.wav",100,150) 
                        state = nil
                        itemtable2 = nil 
                    end
                end
            end
        imgui.End3D2D() end
    else
        self:StopSound("ambient/atmosphere/laundry_amb.wav")
        state = nil
        self:SetSkin(1)
        if timer.Exists("DoCraftMoonShine") then
            timer.Remove("DoCraftMoonShine")
        end
    end
end