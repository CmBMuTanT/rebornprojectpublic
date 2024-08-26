local PLUGIN = PLUGIN

function PLUGIN:DoUntie(client, entity) -- в падлу делать playerMeta
	if (!client:IsRestricted() and entity:IsPlayer() and entity:IsRestricted() and !entity:GetNetVar("untying")) then
		entity:SetAction("Вас развязывают...", 5)
		entity:SetNetVar("untying", true)

		client:SetAction("Развязываю...", 5)

		client:DoStaredAction(entity, function()
			entity:SetRestricted(false)
			entity:SetNetVar("untying")

			-- local leftForearm = entity:LookupBone("ValveBiped.Bip01_L_Forearm")
			-- local rightUpperArm = entity:LookupBone("ValveBiped.Bip01_R_Forearm")
			-- if leftForearm and rightUpperArm then 
			-- 	entity:ManipulateBoneAngles(leftForearm, Angle(0, 0, 0))
			-- 	entity:ManipulateBoneAngles(rightUpperArm, Angle(0, 0, 0))
			-- end
			entity:LeaveSequence()

		end, 5, function()
			if (IsValid(entity)) then
				entity:SetNetVar("untying")
				entity:SetAction()
			end

			if (IsValid(client)) then
				client:SetAction()
			end
		end)
	end
end


function PLUGIN:OnPlayerOptionSelected(target, client, option)
    if (option == "Завязать/развязать глаза") then
		if target:GetNetVar("ziptie:closeeyes") == true then
			target:SetNetVar("ziptie:closeeyes", false)
		else
			target:SetNetVar("ziptie:closeeyes", true)
		end
	elseif (option == "Завязать/развязать рот") then
		if target:GetNetVar("ziptie:mute") == true then
			target:SetNetVar("ziptie:mute", false)
		else
			target:SetNetVar("ziptie:mute", true)
		end
	elseif (option == "Развязать") then
		self:DoUntie(client, target)
	-- elseif (option == "Тащить/перестать тащить за собой") then
	
    end
end

function PLUGIN:PlayerCanHearPlayersVoice(_, client)
	if not IsValid(client) then return end
	if client:IsRestricted() and client:GetNetVar("ziptie:mute") == true then return false end
end