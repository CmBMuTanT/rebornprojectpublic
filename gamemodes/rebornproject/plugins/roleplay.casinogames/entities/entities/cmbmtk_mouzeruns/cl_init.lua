include("shared.lua")
local PLUGIN = PLUGIN

local mousesinfo = mousesinfo or {}

function ENT:Draw()
    self:DrawModel()
    self.mouses = mousesinfo

    if LocalPlayer():GetPos():Distance(self:GetPos()) < 300 then
        local pos = self:LocalToWorld(Vector(179, -27, 44))
        local ang = self:LocalToWorldAngles(Angle(0, 90, 90))
    
        cam.Start3D2D(pos, ang, .1)
            draw.RoundedBox(0, 10, 0, 520, 75, Color(0, 0, 0, 150))

            draw.SimpleText("3", "DermaLarge", 90, 25, Color(255, 255, 255), TEXT_ALIGN_LEFT)
            draw.SimpleText("2", "DermaLarge", 258, 25, Color(255, 255, 255), TEXT_ALIGN_LEFT)
            draw.SimpleText("1", "DermaLarge", 430, 25, Color(255, 255, 255), TEXT_ALIGN_LEFT)
        cam.End3D2D()

        if !table.IsEmpty(self.mouses) then 
            for k,ent in pairs(self.mouses) do
                if !IsValid(ent) then return end
                local _,max = ent:GetRotatedAABB(ent:OBBMins(), ent:OBBMaxs() )   
                local rot = (ent:GetPos() - EyePos()):Angle().yaw - 90   
                local sin = math.sin(CurTime() + ent:EntIndex()) / 3 + .5
                local center = ent:LocalToWorld(ent:OBBCenter())

                cam.Start3D2D(center + Vector(0, 0, math.abs(max.z / 2) + 12 + sin), Angle(0, rot, 90), 0.13)
                    draw.RoundedBox(0, -40, 0, 90, 40, Color(0, 0, 0, 150))
                    draw.SimpleText(PLUGIN.Mouses[k].name, "Default", -15, 0, Color(255, 255, 255), TEXT_ALIGN_LEFT)

                    if LocalPlayer():GetNetVar("MOUSEBET") == ent then
                        draw.SimpleText("(Ваша ставка)", "Default", -30, 15, Color(255, 255, 255), TEXT_ALIGN_LEFT)
                    end
                cam.End3D2D() 
            end
        end
    end
end


netstream.Hook("MouseRuns:Info", function(mouses)
    mousesinfo = mouses
end)