ITEM.name = "Адреналин"
ITEM.description = "Используется для стимуляции сердечного ритма у раненых."
ITEM.model = "models/kek1ch/glucose.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.inventoryType = "unload"
ITEM.category = "[REBORN] MEDICINE"
ITEM.weight = 0.3
ITEM.width = 1
ITEM.height = 1

ITEM.bDropOnDeath = true

ITEM.functions.Use = {
    name = "Вколоть раненому..",
	icon = "icon16/heart_add.png",
	OnRun = function(item)
        local client = item.player
        if (IsValid(client) and client:IsPlayer() and client:Alive()) then
			local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client
			
			local target = util.TraceLine(data).Entity
			data = nil

			if (IsValid(target) and target:GetClass() == "prop_ragdoll" and IsValid(target.ragdoll)) then
				local ragdoll = target.ragdoll

				if ragdoll:IsPlayer() and !ragdoll:Alive() then
					client.beingUsed = item

					ragdoll:SetAction("Вас воскрешают...", 10)

					client:SetAction("Вы пытаетесь оказать первую помощь.." .. ragdoll:GetName(), 10)
					client:EmitSound("adrenaline/medkit_1.wav")
					client:DoStaredAction(target, function()
						if IsValid(ragdoll) and !ragdoll:Alive() then
							client.beingUsed = nil
							item:Remove()

                            ragdoll:SetNetVar("deathTime", nil)
                            ragdoll:Spawn()
                            ragdoll:SetPos(target:GetPos())

                            local positions = ix.util.FindEmptySpace(ragdoll, {client, ragdoll})

                            for _, v in ipairs(positions) do
                                ragdoll:SetPos(v)

                                if (!ragdoll:IsStuck()) then
                                    break
                                end
                            end

                            ragdoll:SetHealth(ragdoll:GetMaxHealth())

                            if IsValid(target) then
                                target:Remove()
                            end
						end
					end, 10, function()
						client:SetAction()
						if IsValid(ragdoll) then ragdoll:SetAction() end
						
						client.beingUsed = nil
					end)
				end
			end
        end
        return false
    end,

    OnCanRun = function(item)
		if IsValid(item.entity) then return false end
		
		local client = item.player

		local data = {}
		data.start = client:GetShootPos()
		data.endpos = data.start + client:GetAimVector() * 96
		data.filter = client
		
		local target = util.TraceLine(data).Entity
		data = nil
		
		return IsValid(target) and target:GetClass() == "prop_ragdoll"
	end
}
