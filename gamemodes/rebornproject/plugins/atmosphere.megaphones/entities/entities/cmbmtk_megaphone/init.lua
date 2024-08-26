local PLUGIN = PLUGIN

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetSoundCategory(1)
	self:SetEnabled(true)
	self.nextcurrtimesnd = 0

    self:SetModel("models/props_wasteland/speakercluster01a.mdl")
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

end

function ENT:Use(activator, caller)
	if !activator:IsAdmin() then return end

	if self:GetEnabled() then
		self:SetEnabled(false)
		activator:ChatPrint("Мегафон выключен.")
	else
		self:SetEnabled(true)
		activator:ChatPrint("Мегафон включен.")
	end
end

function ENT:Think()
	if !self:GetEnabled() then return end

	local curtime = CurTime()
	if curtime >= self.nextcurrtimesnd then
		local soundCategory = self:GetSoundCategory()
        local soundTable = PLUGIN.MGsounds[tostring(soundCategory)]

        if soundTable then
            local randomSound = soundTable[math.random(1, #soundTable)]
            self:EmitSound(randomSound)
        end

		self.nextcurrtimesnd = curtime + 499 -- через сколько повторится звук
	end
end