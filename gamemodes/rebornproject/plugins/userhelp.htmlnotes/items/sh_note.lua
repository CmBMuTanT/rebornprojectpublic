local PLUGIN = PLUGIN
ITEM.name = "Бумага"
ITEM.desc = "Просто кусок бумаги"
ITEM.category = "[REBORN] ALL PAPER`S"
ITEM.exRender = true 
ITEM.model = "models/props_lab/clipboard.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(4.23, 0.06, 199.93),
	ang = Angle(88.75, -180.1, 0),
	fov = 3.87
}

function ITEM:GetDescription()
	local str = self.desc
	local canwrite = self:GetData("CanWrite")

	if !canwrite then
		str = "Листок бумаги, на котором что-то написано." .. "\nЗаголовок: " .. (self:GetData("PaperTitle") or "none")
	else
		str = "Чистый листок бумаги."
	end

	return str
end

ITEM.functions.use =
{
	name = "Использовать",
	tip = "useTip",
	icon = "icon16/add.png",
	OnRun = function(item)
		local client = item.player
		if !PLUGIN.bureaucracy:bb_CanPlayerEdit(item.id, client) then 
			client:notify("Этот предмет уже кем-то используется!")
			return false
		end

		if item:GetData("CanWrite") then
			client.bb_writing_itemid = item.id
			netstream.Start(client, "bb_OpenWriteEditor")
		else
			client.bb_writing_itemid = item.id
			PLUGIN.bureaucracy:bb_SendPaper(item, client)
		end


		return false
	end,
}

ITEM.functions.zpin = {
	name = "Закрепить",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player
		local id = item:GetID()
		local xyzpos = client:GetEyeTrace().HitPos
		local distn = client:GetPos():Distance(client:GetEyeTrace().HitPos)
		local anglz = client:GetEyeTrace().HitNormal:Angle()

		if (id) then
			if (distn <= 80) then
				ix.item.Instance(0, "note", id, 0, 0, function(item)
					item:Spawn(Vector(xyzpos.x, xyzpos.y, xyzpos.z), Angle(anglz) + Angle(90, 90, 90))
					local physObj =  client:GetEyeTrace().Entity:GetPhysicsObject()
					if (IsValid(physObj)) then
						physObj:EnableMotion(false)
						physObj:Wake()
					end
				end)
				client:EmitSound("physics/metal/metal_box_impact_bullet" .. math.random(1, 3) .. ".wav", 75, math.random(75, 100), 1)
			else
				client:Notify("Вы слишком далеко от стены!")
				return false
			end

		end
	end,

	OnCanRun = function(item)
		return !IsValid(item.entity) and !item.noDrop
	end
}

ITEM:Hook("take", function(item)
	if !item:GetData("CanPickup") then return false end
end)

function ITEM:OnInstanced()
	if !self:GetData("CanWrite") then
		self:SetData("CanWrite", true)
	end

	if !self:GetData("CanPickup") then
		self:SetData("CanPickup", true)
	end

	if !self:GetData("PaperTitle") then
		self:SetData("PaperTitle", "Unnamed")
	end
end