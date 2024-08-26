local PLUGIN = PLUGIN

PLUGIN.name = "Stalker Inventory"
PLUGIN.description = "stalker style menu"
PLUGIN.author = "from incredible-gmod.ru with <3"

file.CreateDir("stalker_inventory")

if CLIENT then
	function PLUGIN.DownloadIcon(url, cback)
		local fname = url:match("([^/]+)$")
		if fname:match("^.+(%..+)$") == nil then
			fname = fname ..".png"
		end
		local path = "stalker_inventory/".. util.CRC(url) .."_".. fname

		if file.Exists(path, "DATA") then
			cback(Material("data/".. path, "mips"))
		else
			http.Fetch(url, function(img)
				file.Write(path, img)
				cback(Material("data/".. path, "mips"))
			end)
		end
	end
end

PLUGIN.Tabs = ix.util.Include("cl_tabs.lua")
PLUGIN.Config = ix.util.Include("cl_config.lua")
ix.util.Include("core/sh_extra_inventories.lua")
ix.util.Include("core/sv_extra_inventories.lua")
ix.util.Include("core/sh_equip.lua")
ix.util.Include("core/sv_equip.lua")
ix.util.Include("ui/cl_model.lua")
ix.util.Include("ui/cl_inventoryor.lua")
ix.util.Include("ui/cl_inventory.lua")
ix.util.Include("ui/cl_menu.lua")

ix.util.Include("sv_plugin.lua") -- hotkeys


--FLIPPER
ix.util.Include("item_flipper/cl_item_ent.lua")
ix.util.Include("item_flipper/cl_override.lua")
ix.util.Include("item_flipper/sh_inits.lua")
ix.util.Include("item_flipper/sh_reload.lua")
ix.util.Include("item_flipper/sv_item_meta.lua")


ix.config.Set("inventoryWidth", 6)
ix.config.Set("inventoryHeight", 4)


--form weight plugin


ix.config.Add("maxWeight", 60, "The maximum number of weight a player can take.", nil,
{
	data = {min = 10, max = 100},
	category = "characters",
})

local PlayerMeta = FindMetaTable("Player")
function PlayerMeta:GetWeight()
	weight = 0

	local char = self:GetCharacter()
	if (self:Alive() and char) then
		local inventory =  self:GetAllItems() -- char:GetInventory():GetItems() -- старая функция которая не работает с нашим инвентарем нормально. пришлось писать свою в sh_extra_inventories.

		for k, v in pairs(inventory) do
			if v.weight then
				local amount = v:GetData("amount")
				local stacks = v:GetData("stacks")

				if amount then 
					weight = (weight + (v.weight * amount))
				elseif stacks then
					weight = (weight + (v.weight * stacks))
				else
					weight = weight + v.weight
				end	 
			end
		end
	end

	return weight
end

function PlayerMeta:GetWeightAddition()
    local addition = 0
    local char = self:GetCharacter()

    if self:Alive() and char then
        local attrib = char:GetAttribute("str", 0)

        -- Увеличиваем на 0.3 с каждой новой силой
        addition = math.Round(attrib * 0.3)
    end

    return addition
end


if (SERVER) then
	function UpdatePower(client)
		timer.Simple(0.5, function()
			local weight, maxweight = client:GetWeight(), (ix.config.Get("maxWeight") + client:GetWeightAddition())
			local character = client:GetCharacter()

			if !character then return end

			client:SetNetVar("invWeight", weight)

			local walkSpeed = ix.config.Get("walkSpeed")
			local runSpeed = ix.config.Get("runSpeed") + character:GetAttribute("stm", 0)	

			if (client:WaterLevel() > 1) then
				runSpeed = runSpeed * 0.775
			end

			if weight >= maxweight then
				client:SetWalkSpeed(20)
				client:SetRunSpeed(25)
				client:SetMaxSpeed(25)
				client:SetJumpPower(100)
			elseif weight >= (maxweight / 2) then
				local speedMultiplier = math.Clamp(8 * (weight - (maxweight / 2)) / (maxweight / 2), 1.8, 6.0)

				client:SetWalkSpeed(walkSpeed - (walkSpeed * 0.1 * speedMultiplier))
				client:SetRunSpeed(runSpeed - (runSpeed * 0.1 * speedMultiplier))
				client:SetMaxSpeed(125)
				client:SetJumpPower(125)
			elseif (weight > (maxweight / 4)) or (weight <= 20) then
				client:SetWalkSpeed(walkSpeed)
				client:SetRunSpeed(runSpeed)
				client:SetMaxSpeed(200)
				client:SetJumpPower(200)
			end
		end)
	end

	--- самое тупое что я придумал.
	local function CaclStr(client)
		local weight, maxweight = client:GetWeight(), (ix.config.Get("maxWeight") + client:GetWeightAddition())
		local character = client:GetCharacter()

		if weight >= maxweight and client:GetVelocity():LengthSqr() > 0 then
			character:UpdateAttrib("str", 0.001) -- а кто говорил что будет легко?
		end
	end
	---

	function PLUGIN:CanPlayerTakeItem(client, item)
		local weight, maxweight = client:GetWeight(), (ix.config.Get("maxWeight") + client:GetWeightAddition())
		local character = client:GetCharacter()
		local ItemTable = item:GetItemTable()

		if ItemTable.weight then 
			if (weight > maxweight) or ((ItemTable.weight + weight) > maxweight) then
				client:NotifyLocalized("Арг-х! Кажется, мне не хватит сил для переноса этого..")
				
				return false
			elseif (ItemTable.weight) or (ItemTable.weight == nil) then 
				return true 
			end
		end	
	end

	function PLUGIN:PostPlayerLoadout(client)
		UpdatePower(client)

		-----------------------------------
		local uniqueID = "ixStr" .. client:SteamID()

		timer.Create(uniqueID, 5, 0, function() -- это будет качаться оооочень долго
			if (!IsValid(client)) then
				timer.Remove(uniqueID)
				return
			end

			CaclStr(client)
		end)
		-------------------------------
	end

	function PLUGIN:PlayerInteractItem(client, action, item)
		local doublecheck = client:GetNetVar("brth", false)
		if (action == "drop" and !doublecheck) then
			UpdatePower(client) 
		elseif (action == "take" and !doublecheck) then
			UpdatePower(client) 
		elseif (action == "combine" and !doublecheck) then
			UpdatePower(client) 
		elseif (action == "equip" and !doublecheck) then
			UpdatePower(client) 
		elseif ((action == "buy") or (action == "sell")) and !doublecheck then
			UpdatePower(client)
		end
	end
end

-- if CLIENT then
-- 	local local_player
-- 	function PLUGIN:ShouldShowPlayerOnScoreboard(client)
-- 		if not local_player then return false end
-- 		if not local_player:IsSuperAdmin() and client:Team() ~= local_player:Team() then
-- 			return false
-- 		end
-- 	end
-- 	function PLUGIN:InitPostEntity()
-- 		local_player = LocalPlayer()
-- 	end
-- end