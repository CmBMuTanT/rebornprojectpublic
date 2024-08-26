local PLUGIN = PLUGIN

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/cmbmtk/mouzruns.mdl")
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self.mouses = {}
    self.nextrun = 0
    self.sentLuaToClient = {}

    local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

    x = 0

    for k, v in SortedPairs(PLUGIN.Mouses) do
        local ang = self:GetAngles() + Angle(0, 180, 0)
        local startoffset = Vector(-165, 17 + x, 39)
        local endoffset = Vector(20, 17 + x, 39)

        local startglobalOffset = ang:Forward() * startoffset.x + ang:Right() * startoffset.y + ang:Up() * startoffset.z
        local endglobalOffset = ang:Forward() * endoffset.x + ang:Right() * endoffset.y + ang:Up() * endoffset.z

        local startpos = self:GetPos() + startglobalOffset
        local endpos = self:GetPos() + endglobalOffset

        self.mouse = ents.Create("prop_dynamic")
        self.mouse:SetModel("models/alieneer/rat.mdl")
        self.mouse:SetAngles(ang)
        self.mouse:SetPos(startpos)
        self.mouse:Spawn()
        self.mouse:SetModelScale(0.5)
        self.mouse:SetSkin(v.skinnum)
        self.mouse:SetNWVector("SpawnPosition", startpos)
        self.mouse:SetNWVector("FinishPosition", endpos)
        x = x - 17

        self.mouses[#self.mouses + 1] = self.mouse
        
    end
end

local winningMouse = nil

function ENT:Think()
    if not self:GetStartRuns() and CurTime() > self.nextrun then
        self:SetStartRuns(true)
        self.nextrun = CurTime() + 60

        for _, mouse in pairs(self.mouses) do
            local initialSpeed = math.random(40, 60)
            mouse:ResetSequence("run")
            mouse:SetNWInt("RaceSpeed", initialSpeed)
        end
    end

    if self:GetStartRuns() then
        for _, mouse in pairs(self.mouses) do
            local mousePos = mouse:GetPos()
            local startpos = mouse:GetNWVector("SpawnPosition")
            local endpos = mouse:GetNWVector("FinishPosition")

            local direction = (endpos - startpos):GetNormalized()

            local currentPos = mousePos
            local targetPos = currentPos + direction * mouse:GetNWInt("RaceSpeed")

            local lerpFactor = 0.1
            local newPos = LerpVector(lerpFactor, currentPos, targetPos)

            mouse:SetPos(newPos)

            if (direction.x > 0 and newPos.x >= endpos.x) or (direction.x < 0 and newPos.x <= endpos.x) then
                self:SetStartRuns(false)

                winningMouse = mouse

                for _, otherMouse in pairs(self.mouses) do
                    otherMouse:ResetSequence("idle")
                    if otherMouse ~= winningMouse then
                        otherMouse:SetNWInt("RaceSpeed", 0)
                    end
                end

                break
            end

            local currentSpeed = mouse:GetNWInt("RaceSpeed")
            local newSpeed = math.random(50, 80)
            mouse:SetNWInt("RaceSpeed", newSpeed)
        end
    end

    if not self:GetStartRuns() and winningMouse then
        local winningMouseIndex = nil
        for i, mouse in pairs(self.mouses) do
            if mouse == winningMouse then
                winningMouseIndex = i
                PLUGIN.Mouses[i].wins = PLUGIN.Mouses[i].wins + 1
                break
            end
        end

        for k, client in pairs(player.GetAll()) do
            if self.mouses[winningMouseIndex] == client:GetNetVar("MOUSEBET") then
                local character = client:GetCharacter()
                local inv = character:GetInventory()
                local item = inv:HasItem("casinocoin")
                
                if item then
                    item:SetData("stacks", item:GetData("stacks", 1) + (client:GetNetVar("MOUSEBETAMOUNT", 1) * 2) )
                else
                    inv:Add("casinocoin", 1, {stacks = client:GetNetVar("MOUSEBETAMOUNT", 1) * 2})
                end

                if !self.sentLuaToClient[client] then
                    client:SendLua([[surface.PlaySound("vo/npc/barney/ba_laugh03.wav")]])
                    self.sentLuaToClient[client] = true
                end
            end

            client:SetNetVar("MOUSEBETAMOUNT", 0)
            client:SetNetVar("MOUSEBET", nil)
        end

        self:SetStartRuns(false)
        winningMouse = nil
        self.sentLuaToClient = {}
        timer.Simple(5, function()
            if self.mouses and #self.mouses > 0 then
                for _, mouse in pairs(self.mouses) do
                    mouse:SetPos(mouse:GetNWVector("SpawnPosition"))
                end
            end
        end)
    end
end


function ENT:OnRemove()
    if self.mouses and #self.mouses > 0 then
        for _, mouse in pairs(self.mouses) do
            if IsValid(mouse) then
                mouse:Remove()
            end
        end
    end
end


function ENT:Use(client, caller)
    if self:GetStartRuns() then client:Notify("Подождите конца гонки.") return end
    if client:GetNetVar("MOUSEBET") != nil then client:Notify("Вы не можете ставить на двух или более крыс!") return end

    netstream.Start(client, "MouseRun:OpenMenu", self.mouses, PLUGIN.Mouses)
end 
