include("shared.lua")
local PLUGIN = PLUGIN

ENT.NextActivationCheckT = 0
ENT.NextFireLightT = 0
ENT.DoneFireParticles = false

-- в этом коде я насрал конктрено так как с Imgui я особо не дружил.

local upgradetbl = {
    [1] = "",
    [2] = " Улучшенный",
    [3] = " Улучшенный+"
}

function ENT:Draw()
    self:DrawModel()
    if LocalPlayer():GetPos():Distance(self:GetPos()) > 100 then return end

    local imgui = PLUGIN.IMGUI

    if imgui.Entity3D2D(self, Vector(40, 0, 15), Angle(0, 90, 45), 0.1) then

        draw.RoundedBox(3, -264, -176, 520, 330, Color(25, 25, 25, 230))
        draw.DrawText("Костер"..upgradetbl[self:GetUpgrade()], "DermaLarge", 0, -176, Color(255, 255, 255), TEXT_ALIGN_CENTER)

        if self:GetCook() == false then
            local ignitebutton
            local upgradebutton


            local heatbutton = imgui.xButton(100, -60, 100, 100, 5, Color(255, 255, 255), Color(80, 80, 80), Color(80, 80, 80))
            local frying
            local pot
            

            if heatbutton then
                local panel = vgui.Create("CMBMTK:ChoiceButton")
                panel:Status("bake", self)
            elseif imgui.IsHovering( 100, -60, 100, 100) then
                surface.SetDrawColor( 80, 80, 80, 255 )
            else
                surface.SetDrawColor( 255, 255, 255, 255 )
            end
            surface.SetMaterial( Material("mutantsimgs/heat.png") )
            surface.DrawTexturedRect( 100, -60, 100, 100 )


            if imgui.IsHovering( -50, -60, 100, 100 ) then
                surface.SetDrawColor( 80, 80, 80, 255 )
            else
                surface.SetDrawColor( 255, 255, 255, 255 )
            end
            if fryingimg then
                surface.SetMaterial( Material("mutantsimgs/fryingpan.png") )
                surface.DrawTexturedRect( -50, -60, 100, 100 )
            end

            if imgui.IsHovering( -205, -60, 100, 100 ) then
                surface.SetDrawColor( 80, 80, 80, 255 )
            else
                surface.SetDrawColor( 255, 255, 255, 255 )
            end

            if potimg then
                surface.SetMaterial( Material("mutantsimgs/pot.png") )
                surface.DrawTexturedRect( -205, -60, 100, 100 )
            end



            if  self:GetUpgrade() == 3 then
                pot = imgui.xButton(-205, -60, 100, 100, 5, Color(255, 255, 255), Color(80, 80, 80), Color(80, 80, 80))
                frying = imgui.xButton(-50, -60, 100, 100, 5, Color(255, 255, 255), Color(80, 80, 80), Color(80, 80, 80))
                potimg = true
                fryingimg = true
                if frying then
                    local panel = vgui.Create("CMBMTK:ChoiceButton")
                    panel:Status("fry", self)
                end
                
                if pot then
                    local panel = vgui.Create("CMBMTK:ChoiceButton")
                    panel:Status("boil", self)
                end
            elseif self:GetUpgrade() == 2 then
                frying = imgui.xButton(-50, -60, 100, 100, 5, Color(255, 255, 255), Color(80, 80, 80), Color(80, 80, 80))
                fryingimg = true
                if frying then
                    local panel = vgui.Create("CMBMTK:ChoiceButton")
                    panel:Status("fry", self)
                end
            else
                potimg = false
                fryingimg = false
            end


            if self:GetUpgrade() >= 3 then
                upgradebutton = nil
            else
                upgradebutton = imgui.xButton(-264, -176, 50, 50, 5, Color(255, 255, 255), Color(80, 80, 80), Color(80, 80, 80))

                if upgradebutton then
                    netstream.Start("cmbmtk:campfire:upgrade", self)
                    if IsValid(self.tripod) and IsValid(self.tripod2) and IsValid(self.tripod3) then
                        self.tripod:Remove()
                        self.tripod2:Remove()
                        self.tripod3:Remove()
                    end

                    if IsValid(self.chainik) and IsValid(self.grill) then
                        self.chainik:Remove()
                        self.grill:Remove()
                    end
                elseif imgui.IsHovering( -264, -176, 50, 50 ) then
                    
                    if !hovering and self:GetUpgrade() == 1 then 
                        local xOffset = 30
                        local angle = self:GetAngles()
                        angle:RotateAroundAxis(angle:Up(), 90)
                        
                        local offset = angle:Forward() * xOffset
                        local posLeft = self:GetPos() - offset
                        local posRight = self:GetPos() + offset
                        
                        self.tripod = ClientsideModel("models/props_c17/signpole001.mdl")
                        self.tripod:SetPos(posLeft - Vector(0, 0, 60))
                        self.tripod:Spawn()
                        self.tripod:SetMaterial("models/props_combine/stasisshield_sheet")
                        
                        self.tripod2 = ClientsideModel("models/props_c17/signpole001.mdl")
                        self.tripod2:SetPos(posRight - Vector(0, 0, 60))
                        self.tripod2:Spawn()
                        self.tripod2:SetMaterial("models/props_combine/stasisshield_sheet")
                        
                        
                        local midPos = (posLeft + posRight) / 2
                        
                        local correctedPos3 = midPos + angle:Forward() * (xOffset * 1.8) - angle:Up() * 50
                        local pos3 = correctedPos3 + Vector(0, 0, 100)
                        
                        self.tripod3 = ClientsideModel("models/props_c17/signpole001.mdl")
                        self.tripod3:SetPos(pos3)
                        self.tripod3:SetAngles(self:GetAngles() + Angle(0, 0, 90))
                        self.tripod3:Spawn()
                        self.tripod3:SetMaterial("models/props_combine/stasisshield_sheet")
                        
                        
                        
                        hovering = true
                    elseif !hovering and self:GetUpgrade() == 2 then
                        self.chainik = ClientsideModel("models/props_interiors/pot01a.mdl")
                        self.chainik:SetPos(self:GetPos() + Vector(0, 0, 48))
                        self.chainik:SetAngles(self:GetAngles() + Angle(0, 30, 0))
                        self.chainik:Spawn()
                        self.chainik:SetMaterial("models/props_combine/stasisshield_sheet")

                        self.grill = ClientsideModel("models/props_building_details/Storefront_Template001a_Bars.mdl")
                        self.grill:SetPos(self:GetPos() + Vector(0, 0, 30))
                        self.grill:SetAngles(self:GetAngles() + Angle(90, 0, 90))
                        self.grill:SetModelScale(0.6)
                        self.grill:Spawn()
                        self.grill:SetMaterial("models/props_combine/stasisshield_sheet")

                        hovering = true
                    end
        
                    surface.SetDrawColor( 80, 80, 80, 255 )
                else
                    if IsValid(self.tripod) and IsValid(self.tripod2) and IsValid(self.tripod3) then
                        self.tripod:Remove()
                        self.tripod2:Remove()
                        self.tripod3:Remove()
                    end

                    if IsValid(self.chainik) and IsValid(self.grill) then
                        self.chainik:Remove()
                        self.grill:Remove()
                    end

                    hovering = false
                    surface.SetDrawColor( 255, 255, 255, 255 )
                end
        
                surface.SetMaterial( Material("mutantsimgs/upgrade.png") )
                surface.DrawTexturedRect( -264, -176, 50, 50 )
            end

            if self:GetIgnite() == true then
                ignitebutton = nil
            else
                ignitebutton = imgui.xButton(-40, 80, 75, 75, 5, Color(255, 255, 255), Color(80, 80, 80), Color(80, 80, 80))

                if ignitebutton then
                    netstream.Start("cmbmtk:campfire:ignite", self)
                elseif imgui.IsHovering( -40, 80, 75, 75 ) then
                    surface.SetDrawColor( 80, 80, 80, 255 )
                else
                    surface.SetDrawColor( 255, 255, 255, 255 )
                end

                surface.SetMaterial( Material("mutantsimgs/fire.png") )
                surface.DrawTexturedRect( -26, 101, 50, 50 )
            end
        else
            local lerpedColor = LerpColor(self:GetProgress() / 100, Color(255, 0, 0), Color(0, 255, 0))

            surface.SetDrawColor( lerpedColor )
            surface.SetMaterial( Material("mutantsimgs/gear.png") )
            surface.DrawTexturedRectRotated( 0, 0, 200, 200, CurTime() % 360 * 80)
        end
        

        --cursor
        local x,y = -264, -176
        local w, h = 520, 330
        xCursorcustom(x,y,w,h, imgui)

    imgui.End3D2D() end
    
    if imgui.Entity3D2D(self, Vector(65, 0, 0), Angle(0, 90, 0), 0.1) then
        draw.RoundedBox(3, -150, -150, 300, 300, Color(25, 25, 25, 230))

        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.SetMaterial( Material("mutantsimgs/arrows.png") )
        surface.DrawTexturedRectRotated(0, -90, 100, 100, 90)

        surface.SetDrawColor(Color(255, 255, 255))
        surface.DrawOutlinedRect( -55, -30, 110, 110, 4)
        
    imgui.End3D2D() end
end


function ENT:Think()
    if CurTime() > self.NextActivationCheckT then
        if self:GetIgnite() == true then
            if self.DoneFireParticles == false then
                self.DoneFireParticles = true
                ParticleEffectAttach("env_fire_tiny_smoke",PATTACH_ABSORIGIN_FOLLOW,self,0)
                ParticleEffectAttach("env_embers_large",PATTACH_ABSORIGIN_FOLLOW,self,0)
            end
            if CurTime() > self.NextFireLightT then
                local FireLight1 = DynamicLight(self:EntIndex())
                if (FireLight1) then
                    FireLight1.Pos = self:GetPos() +self:GetUp() * 15
                    FireLight1.R = 255
                    FireLight1.G = 100
                    FireLight1.B = 0
                    FireLight1.Brightness = 2
                    FireLight1.Size = 400
                    FireLight1.Decay = 400
                    FireLight1.DieTime = CurTime() + 1
                end
                self.NextFireLightT = CurTime() + 0.2
            end
        else
            self.DoneFireParticles = false
        end
        self.NextActivationCheckT = CurTime() + 0.1
    end
end