local PLUGIN = PLUGIN

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetNoDrawIcon(false)
	self.NoDraw = false
	self.respawntime = 0
    self.sparkeffect = 10 + CurTime()

    self:SetModel("models/z-o-m-b-i-e/metro_ll/electro/m_ll_electro_box_10.mdl")
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

end

local buttonColors = {Color(255, 0, 0), Color(0, 255, 0), Color(0, 0, 255), Color(255, 255, 0)}
local buttonTexts = {"Красную", "Зеленую", "Синюю", "Желтую"}

function PLUGIN:GetRandomTargetButton()
	local targetColorIndex = math.random(1, #buttonColors)
	local targetColor = buttonColors[targetColorIndex]
	local targetButtonText = buttonTexts[targetColorIndex]
	local targetTextColor = buttonColors[math.random(1, #buttonColors)]
	return targetColor, targetButtonText, targetTextColor
end

function ENT:Use(activator, caller)
	local character = activator:GetCharacter()
	local randomtime = math.random(1, 2)
	local CharID = character:GetID()
	local count = 0
	local AmoutWork = ix.config.Get("Amout of Work", 3)
	local progress = PLUGIN.WorkProgress

	if character:GetData("HasJob", nil) == "electro" and !self:GetNoDrawIcon(false) then
		if progress[CharID] == nil then progress[CharID] = 0 end
		if progress and progress[CharID] and progress[CharID] >= AmoutWork then activator:Notify("Ты выполнил свою смену, так что возвращайся и получи свою зарплату.") return end

        local targetColor, targetButtonText, targetTextColor = PLUGIN:GetRandomTargetButton()
        net.Start("MiniGameElectro_Start")
        net.WriteColor(targetColor)
        net.WriteString(targetButtonText)
        net.WriteColor(targetTextColor)
		net.WriteEntity(self)
        net.Send(activator)

		net.Receive("MiniGameElectro_ButtonClicked", function(_, ply)
			local bool = net.ReadBool()
			local entity = net.ReadEntity()
			if self:GetPos():Distance(ply:GetPos()) > 140 then ply:Notify("Error#2 Invalid Pos Transmition") return end

			if bool then
				self.NoDraw = true
				self:SetNoDrawIcon(true)
				self.respawntime = math.random(ix.config.Get("Respawn Electro Minimal", 10), ix.config.Get("Respawn Electro Max", 60)) + CurTime()
		
				if progress then
					if progress[CharID] ~= 0 then 
						count = progress[CharID] 
					end
				end
		
				if progress[CharID] == nil then
					progress[CharID] = 1
				else
					progress[CharID] = count + 1
				end
		
				activator:SetNetVar("WorkTempProgress", progress[CharID])
				activator:Notify("Ты успешно починил счетчик!")
			else
				self.NoDraw = true
				self:SetNoDrawIcon(true)
				self.respawntime = math.random(ix.config.Get("Respawn Electro Minimal", 10), ix.config.Get("Respawn Electro Max", 60)) + CurTime()

				local electrodata = EffectData()
				electrodata:SetOrigin(self:GetPos())
				util.Effect("ElectricSpark", electrodata)
				electrodata:SetMagnitude(8)
				self:EmitSound("ambient/levels/labs/electric_explosion"..math.random(4, 5)..".wav")
				activator:SendLua([[util.ScreenShake( LocalPlayer():GetPos(), 50, 50, 1, 5000 )]])
				activator:SetHealth(activator:Health() * .5)
				activator:Notify("Вас шандарахнуло током...")
			end
		end)
	end
end

function ENT:Think()
	local curtime = CurTime()
	if curtime >= self.respawntime and self.NoDraw then
		self.NoDraw = false
		self:SetNoDrawIcon(false)
	end

	if curtime >= self.sparkeffect and !self.NoDraw then
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() + Vector(0, 0, 0))
		util.Effect("ElectricSpark", effectdata)
		effectdata:SetMagnitude(math.random(2, 6))
		self:EmitSound("ambient/energy/spark"..math.random(1, 6)..".wav")
		self.sparkeffect = curtime + 10
	end
end