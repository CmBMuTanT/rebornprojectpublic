AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
local PLUGIN = PLUGIN;

local Week = {
    ["Monday"] = true, 
    ["Wednesday"] = true, 
    ["Friday"] = true, 
    ["Saturday"] = true, 
    ["Sunday"] = true,
}

local dayOfWeek = os.date("%A") -- крайне чувствительная вещь если тебе нужно захват по определенным дням недели

local CoolDown = 0

function ENT:Initialize()
 
	self:SetModel( "models/stalkers/racya.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
 
    local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
	end
end
 
function ENT:Use(activator)
	activator:PerformInteraction(ix.config.Get("itemPickupTime", 0.5), self, function(client)
		if self.playerCount < 5 then
			client:Notify("Недостаточно игроков для захвата точки!")
		elseif table.Count(self.playerTeams) > 1 then
			client:Notify("Невозможно захватить точку когда разные фракции в ней находятся!")
		elseif client:Team() == tonumber(self:GetCaptureFraction()) then
			client:Notify("Каким образом ты будешь захватывать точку если она уже ваша?")
		else
			--if !Week[dayOfWeek] then client:Notify("Сегодня невозможно захватить точку из-за правил [захват по дням]") return false end
			if CurTime() < CoolDown then client:Notify("Невозможно захватить точку так как на ней висит К/Д") return false end
			if self:GetCaptureFraction() != "" and team.NumPlayers(tonumber(self:GetCaptureFraction())) < self.playerCount then client:Notify("Вы не можете захватить точку так как представителей данной фракции не равняется вашим. [система баланса]") return false end
			if self:GetCapture() then client:Notify("Захват точки уже производится!") return false end
			client:Notify("Производим захват точки... защищайте ее!")
			self:SetCapture(true)
			self.GetDefaultTime = self:GetCaptureTime()
			self:EmitSound("ambient/levels/citadel/zapper_warmup4.wav", 75, 85)
			return false
		end
		return false
	end)
end
 
local Incomedelay, Capturedelay = 1, 1
local nextSetCurrStorageTime, nextCaptureTime = 0, 0
function ENT:Think()
	local count = 0
	local teams = {}
	for k,v in pairs(ents.FindInSphere(self:GetPos(), 256)) do
		if v:IsPlayer() then 
			count = count + 1
			teams[v:Team()] = true
		end
	end

	if self.playerCount ~= count then
		self.playerCount = count
		self.playerTeams = teams
    end

	if self.playerCount > 0 and table.Count(teams) == 1 then
		if self:GetCapture() then
			if self.playerCount < 5 then
				self:EmitSound("ambient/levels/citadel/pod_open1.wav", 75, 80)
				self:SetCapture(false)
				self:SetCaptureTime(self.GetDefaultTime)
			end

			if CurTime() > nextCaptureTime then
				if self.playerCount > 5 then
					Capturedelay = math.Clamp(1 - (self.playerCount - 5) * 0.3, 0.1, 1)
				else
					Capturedelay = 1
				end
				self:SetCaptureTime(self:GetCaptureTime() - 1)
				nextCaptureTime = CurTime() + Capturedelay
			end

			if self:GetCaptureTime() == 0 then
				self:SetCapture(false)
				self:EmitSound("ambient/machines/thumper_hit.wav", 75, 100)

				local teamsString = nil
				for teamIndex, _ in pairs(self.playerTeams) do
					teamsString = teamIndex
				end

				self:SetCaptureFraction(ix.faction.indices[teamsString].index)
				CoolDown = CurTime() + 3600 -- 1 час
			end
		end
	end

	if CurTime() > nextSetCurrStorageTime then
		if self:GetCaptureFraction() != "" then
			for _,ent in ipairs(ents.FindByClass("ix_factiontable")) do
				if self:GetCaptureFraction() == tostring(ent:GetFraction()) then
					ent:SetCurrStorage(math.Clamp(ent:GetCurrStorage() + self:GetCaptureIncome(), 0, ent:GetMaxStorage()))
				end
			end
		end
		nextSetCurrStorageTime = CurTime() + Incomedelay
	end

		self:NextThink( CurTime() )
	return true
end

 