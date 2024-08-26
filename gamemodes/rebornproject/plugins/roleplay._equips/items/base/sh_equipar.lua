ITEM.name = "Equip"
ITEM.description = "Equip item base."
ITEM.category = "[EQ] TEST"
ITEM.model = "models/props_junk/watermelon01.mdl" -- ватермелон)

ITEM.EQsound = nil
ITEM.DEQsound = nil
ITEM.Armor = nil
--ITEM.EQtime = 5

ITEM.width = 1
ITEM.height = 1

ITEM.damage = {1, 1, 1, 1, 1, 1, 1, 1}


ITEM.Warm = 100
ITEM.WarmTable = {
    {.3, "Плохое утепление"},
    {.6, "Среднее утепление"}
}

ITEM.quality = "common"
ITEM.qualitycolor = {
	["common"] = Color(75, 119, 190),
	["uncommon"] = Color(75, 75, 255),
	["rare"] = Color(204, 75, 255),
	["legendary"] = Color(255, 0, 0),
	["ultralegendary"] = Color(255, 255, 0),
}

ITEM.inventoryType = "armor"

ITEM.DamageName = {
	[1] = "Пулестойкость",
	[2] = "Защита от порезов",
	[3] = "Электрозащита",
	[4] = "Термозащита",
	[5] = "Радиозащита",
	[6] = "Химзащита",
	[7] = "Взрывчатка",
	[8] = "Защита от падения"
}

ITEM.HitgroupName = {
	[HITGROUP_HEAD] = "Защищает голову",
	[HITGROUP_CHEST] = "Защищает грудь",
	[HITGROUP_STOMACH] = "Защищает живот",
	[HITGROUP_LEFTARM] = "Защищает левую руку",
	[HITGROUP_RIGHTARM] = "Защищает правую руку",
	[HITGROUP_LEFTLEG] = "Защищает левую ногу",
	[HITGROUP_RIGHTLEG] = "Защищает правую ногу",
}
ITEM.HitGroupScaleDmg = {
	[HITGROUP_HEAD] = false,
	[HITGROUP_CHEST] = false,
	[HITGROUP_STOMACH] = false,
	[HITGROUP_LEFTARM] = false,
	[HITGROUP_RIGHTARM] = false,
	[HITGROUP_LEFTLEG] = false,
	[HITGROUP_RIGHTLEG] = false,
}

ITEM.Strengthneed = 0

-- ITEM.SGarmor = 0
-- ITEM.SGarmband = 0
-- ITEM.SGhelmet = 0
ITEM.skingroupar = 0
ITEM.skingrouphelmet = 0
ITEM.skinarmband = 0


------BM------
ITEM.outfitCategory = "hat"
ITEM.IsBodyMergeble = false
--------------

ITEM.IsMask = false
ITEM.MaterialOverlay = false

local function GetPercentage(var)
	return (1-var)*100
end

local function CheckClothWarm(tbl, chk)
    for k, v in ipairs(tbl) do
        local value = v[1]
        local data = v[2]

        if (chk / 100) <= value then
            return data
        end
    end

    return "Хорошее утепление"
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end

		local multiplication = 1.75
		local strength = item:GetData("wearcondition")
		local col = math.Round(strength * multiplication)
		local r = 175 - col
		local g = col

		if strength then
			surface.SetDrawColor(Color(r,g,0))
			draw.NoTexture()
			draw.Circle(w - 10, h - 24, 4, 64)
		else
			surface.SetDrawColor(Color(255,0,255)) -- а-ля ERROR, ок? Хотя я его даже не знаю как получить блять.
			draw.NoTexture()
			draw.Circle(w - 10, h - 24, 4, 64)
		end
	end

	function ITEM:PopulateTooltip(tooltip)
		for k,v in pairs(self.qualitycolor) do
			if k == self.quality then
				local name = tooltip:GetRow("name")
				name:SetBackgroundColor(v)

				if (self.entity) then return end

				--if mdl then

				if !self.LookupBone then -- мне проще так ок
					self.LookupBone = "ValveBiped.Bip01_Head1"
				end

				if !self.CamPosVec then
					self.CamPosVec = Vector(-15, 2.5, 0)
				end

					local mdl_preview = tooltip:AddRowAfter("description", "mdl_preview")
					mdl_preview:SetBackgroundColor(Color(41, 128, 185))
					timer.Simple(0, function()
						if IsValid(mdl_preview) then
							mdl_preview:SetSize(tooltip:GetWide(), tooltip:GetWide())
							tooltip:SizeToContents()
						end
					end)

					mdl_preview.mdl = mdl_preview:Add("DModelPanel")
					mdl_preview.mdl:Dock(FILL)
					-- mdl_preview.mdl:SetModel(mdl)
					mdl_preview.mdl:SetModel(LocalPlayer():GetModel())

					if (self.bodyGroups) then
						local groups = {}
		
						for k, value in pairs(self.bodyGroups) do
							local index = LocalPlayer():FindBodygroupByName(k)
		
							if (index > -1) then
								groups[index] = value
							end
						end
		
						for index, value in pairs(groups) do
							mdl_preview.mdl.Entity:SetBodygroup(index, value)
						end
					end

					mdl_preview.mdl.LayoutEntity = function() end
					local headpos = mdl_preview.mdl.Entity:GetBonePosition(mdl_preview.mdl.Entity:LookupBone(self.LookupBone))
					headpos:Add(Vector(0, 0, 2))
					mdl_preview.mdl:SetLookAt(headpos)
					mdl_preview.mdl:SetCamPos(headpos - self.CamPosVec)
					mdl_preview.mdl.Entity:SetSequence("bandit_idle_1_idle_0")
					
					if self.SGname and self.skingroupar ~= 0 then
						mdl_preview.mdl.Entity:SetNWInt(self.SGname, self.skingroupar)
					end
				--end

				local str = "Необходимо силы: "..self.Strengthneed.."\n"
				local filtertime = ""
				local strneed = ""
				local stats = {}
				for i, v in ipairs(self.damage) do
					if v ~= 1 then
						table.insert(stats, " ".. self.DamageName[i] ..": ".. GetPercentage(v) .."%")
					end
				end

				local protection = ""
				if #stats ~= 0 then
					protection = "\n \nЗащита: \n".. table.concat(stats, "\n")
				end

				local protection_hitgroup = ""
				if self.HitGroupScaleDmg then
					local stats = {}

					for hitgroup, scale in pairs(self.HitGroupScaleDmg) do
						if scale then
							table.insert(stats, "-".. self.HitgroupName[hitgroup]) --..": ".. GetPercentage(scale) .."%")
						end
					end

					if #stats ~= 0 then
						protection_hitgroup = "\n".. table.concat(stats, "\n")
					end
				end

				if self.IsMask then
					filtertime = "Фильтр: "..string.FormattedTime(self:GetData("FilterTime", 600), "%02i:%02i").."\n"
				end

				local protections = tooltip:AddRowAfter("description", "protections")
				protections:SetText("★ | Характеристики\n"..str..filtertime..CheckClothWarm(self.WarmTable, self.Warm).."\n"..protection_hitgroup..protection)
				protections:SetBackgroundColor(Color(255, 140, 0))
				protections:SizeToContents()
			end
		end
	end
end

-- On item is dropped, Remove a weapon from the player and keep the ammo in the item.

function ITEM:OnInstanced()
	self:SetData("wearcondition", 100)
	self:SetData("SG_Outfit", self.skingroupar.."_"..self.skinarmband.."_"..self.skingrouphelmet)

	if self.IsMask then
		self:SetData("FilterTime", 600)
	end
end

ITEM.functions.Filter = {
	name = "Надеть Фильтр",
	icon = "icon16/wrench.png",

	OnRun = function(item)
		local client = item.player 
		local char = client:GetCharacter()
		local inv = char:GetInventory()
		local filter = inv:HasItem("gasmaskfilter")
		client:EmitSound("gasmask/change_filter.wav", 40)

		if (filter) then
			item:SetData("FilterTime", 600)
			filter:Remove()
		else
			client:Notify("У вас нет фильтра!")
		end

		return false
	end,
	OnCanRun = function(item)
		local client = item.player
		local inv = client:GetCharacter():GetInventory():HasItem("gasmaskfilter")
		return (!IsValid(item.entity) and inv != false and item.IsMask)
	end
}

if (SERVER) then
    function ITEM:Equip(client)
		local character = client:GetCharacter()

		-- client:Freeze(true)
		-- client:SetAction("Надеваю "..self.name.."...", self.EQtime, function()	

			--client:Freeze(false)

			self:SetData("equip", true)
			client:SetNetVar("SG_Outfit", self.skingroupar.."_"..self.skinarmband.."_"..self.skingrouphelmet)
			if (self.bodyGroups) then
				local groups = {}

				for k, value in pairs(self.bodyGroups) do
					local index = client:FindBodygroupByName(k)

					if (index > -1) then
						groups[index] = value
					end
				end

				local newGroups = character:GetData("groups", {})

				for index, value in pairs(groups) do
					newGroups[index] = value
					client:SetBodygroup(index, value)
				end

				if (table.Count(newGroups) > 0) then
					character:SetData("groups", newGroups)
				end
			end

			if self.EQsound then
				client:EmitSound(self.EQsound)
			end

			if self.Armor then
				client:SetArmor(self.Armor)
			end

			self:RSO_Equip(client)
			self:OnEquipped()
		--end)
    end

    function ITEM:Unequip(client)
		local character = client:GetCharacter()
		self:SetData("equip", false)

		for k, _ in pairs(self.bodyGroups or {}) do
			local index = client:FindBodygroupByName(k)

			if (index > -1) then
				client:SetBodygroup(index, 0)
			end
		end


		self:RSO_UnEquip(client)

		if self.DEQsound then
			client:EmitSound(self.DEQsound)
		end
		
		client:SetArmor(0)
		
		self:OnUnequipped()
	end

	function ITEM:OnLoadout()
		if (self:GetData("equip")) then
			local client = self.player
			self:RSO_Equip(client)
		end
	end
end

function ITEM:CanTransfer(oldInventory, newInventory)
	local client = self.player or self:GetOwner() -- больше я ничего не придумал кроме того как использовать либо игрока либо игрока но по другому...
	if !IsValid(client) then return end
	
	if ( newInventory == client:ExtraInventory(self.inventoryType) ) then
		if client:GetCharacter():GetAttribute("str", 0) >=  self.Strengthneed then
			return true 
		else
			client:Notify("Вам не хватает '"..self.Strengthneed - client:GetCharacter():GetAttribute("str", 0).."' очков силы дабы это надеть!")
			return false
		end
	end

	return !newInventory or newInventory:GetID() != oldInventory:GetID()
end

function ITEM:RSO_Equip(client)
end

function ITEM:RSO_UnEquip(client)
end

function ITEM:OnEquipped()
end

function ITEM:OnUnequipped()
end