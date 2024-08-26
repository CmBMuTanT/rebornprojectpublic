local DIR_LIGHT_LEFT_COL = Color(255, 160, 80, 255)
local DIR_LIFT_RIGHT_COL = Color(80, 160, 255, 255)

local PANEL = {}

function PANEL:Init()
    self.Angles = Angle(0, -25, 0)
    self.Pos = Vector(-50, 0, -63)

    self:SetFOV(32)
    self:SetDirectionalLight(BOX_RIGHT, DIR_LIGHT_LEFT_COL)
    self:SetDirectionalLight(BOX_LEFT, DIR_LIFT_RIGHT_COL)
    self:SetAmbientLight(Vector(-64, -64, -64))
    self:SetAnimated(true)

    self:SetCamPos(vector_origin)
    self:SetLookAt(Vector(-100, 0, -22))
end

PANEL.DefaultSequence = -1

function PANEL:SetEntity(ent)
    self.ENT = ent

    self:SetModel(ent:GetModel())
    if ent:IsPlayer() then
        self.Entity.GetPlayerColor = function() return ent:GetPlayerColor() end

       -- local data = ent:GetNetVar("cl_SG_Outfit") or "nil"
       -- ReadSkinOutfit(self.Entity, data)
       
            local InvTable = {
                "bag",
                "unloading",
                "armor",
                "head_balaclava",
                "head_mask",
                "helmet",
                "head_gasmask",
                "head_glasses",
                "legs",
            }
            for k,v in pairs(InvTable) do
                local inv = LocalPlayer():ExtraInventory(v)
                if not inv then return end
                local item = inv:GetEquipedItem()
                if item and item.SGname then
                    self.Entity:SetNWInt(item.SGname, item.skingroupar)
                end
            end
    end

    self.Entity:SetSkin(ent:GetSkin())
    for _, body in ipairs(ent:GetBodyGroups()) do
        self.Entity:SetBodygroup(body.id, ent:GetBodygroup(body.id))
    end

    self.DefaultSequence = self.Entity:GetSequence()
    self:ResetSequence()

end

function PANEL:ResetSequence()
    local m = {
		"lead_1_idle_2",
        "bandit_ohrana_1",
		"ohrana_1_short",
        "bandit_idle_0_idle_4",
		"stoya_0",
		"zombified_idle_0_idle_3",
		"komandir_2"
    }

    local sec_id = self.Entity:LookupSequence(m[math.random(#m)])  
   -- if sec_id <= 0 then sec_id = self.Entity:LookupSequence(m[math.random(#m)]) end

   -- if sec_id <= 0 then sec_id = self.Entity:LookupSequence("LineIdle0".. math.random(1, 4)) end


    if sec_id <= 0 then sec_id = self.Entity:LookupSequence("idle_all_01") end
   if sec_id <= 0 then sec_id = self.Entity:LookupSequence("idle") end

  --[[  if sec_id <= 0 and self.DefaultSequence >= 0 then
        self.Entity:ResetSequence(self.DefaultSequence)
        return
    end]]

    if sec_id <= 0 then sec_id = self.Entity:LookupSequence("walk_all") end
    if sec_id <= 0 then sec_id = self.Entity:LookupSequence("WalkUnarmed_all") end
    if sec_id <= 0 then sec_id = self.Entity:LookupSequence("walk_all_moderate") end

    self.Entity:ResetSequence(sec_id)
    return sec_id
end

function PANEL:SetSequence(name)
    local sec_id = self.Entity:LookupSequence(name)
    if sec_id > 0 then
        self.Entity:ResetSequence(sec_id)
    else
        sec_id = self:ResetSequence()
    end
    self.Entity:SetCycle(0)

    return sec_id
end

function PANEL:DragMousePress(button)
    self.PressX, self.PressY = gui.MousePos()
    self.Pressed = button
end

function PANEL:OnMouseWheeled(delta)
    self.WheelD = delta * -10
    self.Wheeled = true
end

function PANEL:DragMouseRelease()
    self.Pressed = false
end

function PANEL:LayoutEntity(ent)
    if self.bAnimated then
        self:RunAnimation()

        if ent:GetCycle() >= 1 then
    		ent:SetCycle(0)
            if self.OnSequenceEnd then
                self:OnSequenceEnd()
            end
    	end
    end

    if self.Pressed == MOUSE_LEFT then
        local mx = gui.MousePos()
        self.Angles = self.Angles - Angle(0, (self.PressX or mx) - mx, 0)
        if math.abs(self.Angles.y) > 360 then
            self.Angles.y = self.Angles.y % 360
        end
        self.PressX, self.PressY = gui.MousePos()
    elseif self.Pressed == MOUSE_RIGHT then
        local mx, my = gui.MousePos()
        self.Angles = self.Angles - Angle((self.PressY * (0.5) or my * (0.5)) - my * (0.5), 0, (self.PressX * (-0.5) or mx * (-0.5)) - mx * (-0.5))
        self.PressX, self.PressY = gui.MousePos()
    elseif self.Pressed == MOUSE_MIDDLE then
        local mx, my = gui.MousePos()
        self.Pos = self.Pos - Vector(0, (self.PressX * (0.5) or mx * (0.5)) - mx * (0.5), (self.PressY * (-0.5) or my * (-0.5)) - my * (-0.5))
        self.PressX, self.PressY = gui.MousePos()
    end

    if self.Wheeled then
        self.Wheeled = false
        self.Pos = self.Pos - Vector(self.WheelD, 0, 0)
    end

    ent:SetAngles(self.Angles)
    ent:SetPos(self.Pos)
end

function PANEL:PreDrawModel(ent)
    local head = ent:LookupBone("bip01_head")
    if head < 0 then return end

    local mult = self:GetTall() * 0.025
    local x, y = self:LocalCursorPos()
    x = (x - self:GetWide() * 0.5) / self:GetWide() * mult
    y = y / self:GetTall() * mult

    local ang = Angle(1, 1, 1)
    ang:RotateAroundAxis(ang:Up(), -y)
    ang:RotateAroundAxis(ang:Forward(), x)

    ent:ManipulateBoneAngles(head, ang)

    local spine = ent:LookupBone("bip01_spine1")
    if spine < 0 then return end

    ang = ang * 0.3
    ang.y = -ang.y

    local start = ent:GetManipulateBoneAngles(spine)

    local speed = 1 - (1 - FrameTime()) ^ 2
    ent:ManipulateBoneAngles(spine, LerpAngle(speed, start, ang))
end


function PANEL:Paint(w, h)
    local ent = self.Entity
    if IsValid(ent) == false then return end

    local x, y = self:LocalToScreen(0, 0)

    self:LayoutEntity(ent)

    local ang = self.aLookAngle
    if not ang then
        ang = (self.vLookatPos - self.vCamPos):Angle()
    end

    cam.Start3D(self.vCamPos, ang, self.fFOV, x, y, w, h, 5, self.FarZ)
        render.SuppressEngineLighting(true)
        render.SetLightingOrigin(ent:GetPos())
        render.ResetModelLighting(self.colAmbientLight.r / 255, self.colAmbientLight.g / 255, self.colAmbientLight.b / 255)
        render.SetColorModulation(self.colColor.r / 255, self.colColor.g / 255, self.colColor.b / 255)
        render.SetBlend(self:GetAlpha() / 255 * self.colColor.a / 255)

        for i = 0, 6 do
            local col = self.DirectionalLight[i]
            if col then
                render.SetModelLighting(i, col.r / 255, col.g / 255, col.b / 255)
            end
        end

        self:DrawModel()

        render.SuppressEngineLighting(false)
    cam.End3D()

    self.LastPaint = RealTime()
end

function PANEL:SetModelColor(col)
    self.Entity.GetPlayerColor = function() return col end
end

function PANEL:SetLocalPlayer()
    self:SetEntity(LocalPlayer())
end

vgui.Register("IncredibleModel", PANEL, "DModelPanel")