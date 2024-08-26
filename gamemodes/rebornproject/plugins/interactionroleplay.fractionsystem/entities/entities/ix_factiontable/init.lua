AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
local PLUGIN = PLUGIN

function ENT:Initialize()
	self:SetModel( "models/hunter/plates/plate2x3.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
    local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
	end

	for k, v in pairs(ix.faction.indices) do
        self:SetNetVar(v.name, 'NEUTRAL')
    end

	self.inv = nil
end
 
function ENT:Use(client)
	if client:Team() != self:GetFraction() then client:Notify("Вы не можете использовать данную доску так как ваша фракция различается.") return end
	netstream.Start(client, "fractionsystem::OpenUI", self)
end
 

local PassiveIncomedelay = 30
local nextSetCurrStorageTime = 0
function ENT:Think()
	if CurTime() > nextSetCurrStorageTime then
		self:SetCurrStorage(math.min(self:GetCurrStorage() + self:GetPassiveIncome(), self:GetMaxStorage()))
		nextSetCurrStorageTime = CurTime() + PassiveIncomedelay
	end

	self:NextThink( CurTime() )
	return true
end


function ENT:OnRemove()
	if (!ix.shuttingDown) then
		PLUGIN:SaveData()
	end
end

function ENT:CreateBank(client)
	self:SetBankID(os.time())
    local bank = ix.inventory.Create(self:GetBankWH(), self:GetBankWH(), self:GetBankID())
    bank:SetOwner(self)
    bank:Sync(client)
    return bank
end


function ENT:GetBank(client, cback)
	local bank
	local bank_id = self:GetBankID()


	if bank_id ~= 0 then
		if ix.inventory.Get(bank_id) then
			
			bank = ix.item.inventories[bank_id]
			if bank then
				ix.inventory.Restore(bank_id, self:GetBankWH(), self:GetBankWH(), function(inventory)
					inventory:SetOwner(self)
					cback(inventory)
				end)
			end
		else
			ix.inventory.Restore(bank_id, self:GetBankWH(), self:GetBankWH(), function(inventory)
				inventory:SetOwner(self)
				cback(inventory)
			end)
		end
		return
	end


	bank = self:CreateBank(client)
	cback(bank)
end
