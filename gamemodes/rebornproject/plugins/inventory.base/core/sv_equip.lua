hook.Add("OnItemTransferred", "EquipExtraInvItems", function(item, oldInv, newInv)

    if oldInv.vars and oldInv.vars.inventoryType and (oldInv.vars.inventoryType == item.inventoryType or (oldInv.vars.inventoryType == "weapon_primary" and item.inventoryType == "weapon_secondary") or (oldInv.vars.inventoryType == "weapon_secondary" and item.inventoryType == "weapon_primary")) then
        oldInv:UnequipItem(item)
    end

    if newInv.vars and newInv.vars.inventoryType and (newInv.vars.inventoryType == item.inventoryType or (newInv.vars.inventoryType == "weapon_primary" and item.inventoryType == "weapon_secondary") or (newInv.vars.inventoryType == "weapon_secondary" and item.inventoryType == "weapon_primary")) then
        newInv:EquipItem(item)
    end
end)

local function EquipAll(ply)
	timer.Simple(0, function()
		ply:ExtraInventories(function(inv)

			for _, item in pairs(inv:GetItems()) do
				if inv.vars and (inv.vars.inventoryType == "bag" or inv.vars.inventoryType == "unloading") then return end

				inv:EquipItem(item)
			end
		end)
	end)
end

hook.Add("PlayerLoadout", "EquipExtraInvItems", EquipAll)