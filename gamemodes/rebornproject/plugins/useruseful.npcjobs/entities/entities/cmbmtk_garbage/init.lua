local PLUGIN = PLUGIN

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local randommodels = {
	"models/props_junk/garbage128_composite001a.mdl",
	"models/props_junk/garbage128_composite001b.mdl",
	"models/props_junk/garbage128_composite001c.mdl",
	"models/props_junk/garbage128_composite001d.mdl",
	"models/props_junk/garbage256_composite001a.mdl",
	"models/props_junk/garbage256_composite001b.mdl",
}

function ENT:Initialize()
	self:SetNoDrawIcon(false)
	self.respawntime = 0
    
    self:SetModel(randommodels[math.random(#randommodels)])
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

end

function ENT:Use(activator, caller)
	local character = activator:GetCharacter()
	local randomtime = math.random(5, 30)
	local CharID = character:GetID()
	local count = 0
	local AmoutWork = ix.config.Get("Amout of Work", 3)
	local progress = PLUGIN.WorkProgress

	if character:GetData("HasJob", nil) == "garbage" then
		if progress[CharID] == nil then progress[CharID] = 0 end
		if progress and progress[CharID] and progress[CharID] >= AmoutWork then activator:Notify("Ты выполнил свою смену, так что возвращайся и получи свою зарплату.") return end
		if !activator:Crouching() then activator:Notify("Вы должны присесть чтобы начать убирать мусор.") return end -- это приседание
	  --  if activator:GetActiveWeapon():GetClass() ~= "broom" then activator:Notify("Вам нужна швабра для уборки..") return end -- это швабра

		-- что тебе надо то и закоменти а одно из них раскоменти.

		activator:SetAction("Убираю мусор...", randomtime)
		activator:DoStaredAction(self, function() 

			self:SetNoDraw(true)
			self:SetNoDrawIcon(true)
			self.respawntime = math.random(ix.config.Get("Respawn Garbage Minimal", 10), ix.config.Get("Respawn Garbage Max", 60)) + CurTime()
			self:SetSolid(SOLID_NONE)
			self:PhysicsInit(SOLID_NONE)

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
			activator:Notify("Ты успешно собрал мусор!")

		end, randomtime, function()
			activator:SetAction()
			activator:Notify("Вам нужно смотреть на мусор!")
		end)
	end
end

function ENT:Think()
	local curtime = CurTime()
	if self:GetNoDrawIcon() and curtime >= self.respawntime then
		self:SetNoDraw(false)
		self:SetNoDrawIcon(false)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableMotion(false)
		end
	end
end