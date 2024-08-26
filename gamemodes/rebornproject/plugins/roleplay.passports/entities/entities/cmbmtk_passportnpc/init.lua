local PLUGIN = PLUGIN

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    
    self:SetModel("models/devcon/mrp/act/redline_co.mdl")
	self:SetRegistrationString("Частилище Мутьева")
	self:SetRegistrationImage("mutantsimgs/vdnh.png")

    self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal()
	self:SetSolid( SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:CapabilitiesAdd( CAP_TURN_HEAD )
	self:DropToFloor()
	self:SetMoveType( MOVETYPE_NONE )
	self:SetCollisionGroup( COLLISION_GROUP_PLAYER )
	self:SetUseType( SIMPLE_USE )

    local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end
end

function ENT:Use(activator, caller)
	local item =  activator:GetCharacter():GetInventory():HasItem("passport")
	if item then --activator:Notify("У вас уже имеется паспорт!") return end
		local Stamps = item:GetData("PassportStamps", {})
		local img = self:GetRegistrationImage()
		
		if table.IsEmpty(Stamps) then return end


		local hasStamp = false
        for k, v in pairs(Stamps) do
            if img == v then
                hasStamp = true
                break
            end
        end

        if hasStamp then
            activator:Notify("У вас уже есть печать данной станции!")
        else
			activator:SendLua([[
				Derma_Query(
				"Вы хотите купить штамп данной станции? (Цена 100 пуль)",
				" ",
				"Да",
				function() netstream.Start("cmbmtk.passportbuystamp", "]]..img..[[") end,
				"Нет")
			]])
		end
	else

		activator:SetNetVar("RegStr", self:GetRegistrationString()) -- keks
		activator:SetNetVar("RegImg", self:GetRegistrationImage())

		activator:SendLua([[vgui.Create("cmbmtk.passportvendor")]])
	end
end
