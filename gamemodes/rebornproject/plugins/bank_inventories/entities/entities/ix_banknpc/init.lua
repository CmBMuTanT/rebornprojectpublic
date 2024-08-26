AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.Sequence = "idle01"
ENT.Model = "models/z-o-m-b-i-e/metro_ll/mebel_outdoor/m_ll_tumba_03.mdl"

function ENT:Initialize()
    self:SetModel(self.Model)
	self:SetUseType(SIMPLE_USE)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_BBOX)
    self:DropToFloor()
    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

    self.DefaultSequence = (self:GetSequence() or -1) > -1 and self:GetSequence()

    self:RunAnimation(self.Sequence)
    self:OpenEyes()

    self:SetDisplayName("Default")

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(false)
	end
end

function ENT:SetDefaultAnimation()
    if self.DefaultSequence then
        self:ResetSequence(self.DefaultSequence)
        return
    end

    local sec_id = self:LookupSequence("idle_all_01")

    if sec_id <= 0 then sec_id = self:LookupSequence("idle") end
    if sec_id <= 0 then sec_id = self:LookupSequence("walk_all") end
    if sec_id <= 0 then sec_id = self:LookupSequence("WalkUnarmed_all") end
    if sec_id <= 0 then sec_id = self:LookupSequence("walk_all_moderate") end

    self:ResetSequence(sec_id)
end

function ENT:RunAnimation(anim)
    local sec_id = self:LookupSequence(anim)
    if sec_id < 0 then self:SetDefaultAnimation() return false end

    self:ResetSequence(sec_id)
    self:SetCycle(0)
    self:SetPlaybackRate(1)
    return true
end

function ENT:RunAnimationPiece(anim, pos) -- str sequence, 0-1 position
    local sec_id = self:LookupSequence(anim)
    if sec_id < 0 then self:SetDefaultAnimation() return false end

    self:ResetSequence(sec_id)
    self:SetCycle(pos)
    self:SetPlaybackRate(0)
    return true
end

function ENT:OpenEyes()
    local FlexNum = self:GetFlexNum()
    if FlexNum <= 0 then return end

    for i = 0, FlexNum do
        local Name = self:GetFlexName(i)
        self:SetFlexWeight(i, 0)
    end
end

function ENT:CreateBank(ply, char)
    local bank = ix.inventory.Create(3, 3, os.time())
    bank:SetOwner(char:GetID())
    bank:Sync(ply)
    return bank
end

function ENT:GetBank(ply, cback)
    local char = ply:GetCharacter()

    local name = self:GetDisplayName()
    local banks = char:GetData("bankStorages")

    local bank
    if banks then
        banks = util.JSONToTable(banks)

        local bank_id = banks[name]
        if bank_id then
            bank = ix.item.inventories[bank_id]

            if bank then
                cback(bank)
            else
                ix.inventory.Restore(bank_id, 3, 3, function(inventory)
                    inventory:SetOwner(char:GetID())
                    cback(bank)
                end)
            end

            return
        end

        bank = self:CreateBank(ply, char)
        banks[name] = bank:GetID()
        char:SetData("bankStorages", util.TableToJSON(banks), true)
        cback(bank)
    else
        bank = self:CreateBank(ply, char)
        char:SetData("bankStorages", util.TableToJSON({
            [name] = bank:GetID()
        }), true)
        cback(bank)
    end
end

ENT.UseCooldown = 5
function ENT:Use(ply)
    if ply:IsPlayer() == false then return end

    if self.UseCooldown > CurTime() then return end
    self.UseCooldown = CurTime() + 3

    self:GetBank(ply, function(bank)
        ix.storage.Open(ply, bank, {
            entity = self,
            name = "Семён «Банкомат»",
            searchText = "Доступ к вашему хранилищу..",
            searchTime = 15
        })
    end)
end