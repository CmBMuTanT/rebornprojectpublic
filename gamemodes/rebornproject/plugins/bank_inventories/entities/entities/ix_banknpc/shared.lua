ENT.Base = "base_entity"
ENT.AutomaticFrameAdvance = true
ENT.RenderGroup = RENDERGROUP_OPAQUE

ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "Bank NPC"
ENT.Category = "Incredible GMod"

function ENT:SetAutomaticFrameAdvance(bool)
	self.AutomaticFrameAdvance = bool
end

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "DisplayName")
end

properties.Add("incredible-gmod.ru/helix/bank", {
	MenuLabel = "Изменить Имя",
	Order = 999,
	MenuIcon = "icon16/user_edit.png",
	Filter = function(self, ent, ply)
		if IsValid(ent) == false then return false end
		if (ent:GetClass() ~= "ix_banknpc") then return false end
		return ply:IsSuperAdmin()
	end,
	Action = function(self, ent)
		Derma_StringRequest("Изменить имя", "Введите новое имя", ent:GetDisplayName(), function(text)
			self:MsgStart()
				net.WriteEntity(ent)
				net.WriteString(text)
			self:MsgEnd()
		end)
	end,
	Receive = function(self, length, ply)
		local ent = net.ReadEntity()
		if IsValid(ent) == false then return end
		if not self:Filter(ent, ply) then return end
		
		ent:SetDisplayName(net.ReadString())
	end
})
