local PLUGIN = PLUGIN

PLUGIN.doors = {
	["prop_door_rotating"] = true,
}

function PLUGIN:KnokOutDoor(client, door)
	local door = door or {}

	if door.bustedDown then return end

	if client:GetCharacter():GetAttribute("str") < ix.config.Get("StrengthNeeded") then return end

	door.bustedDown = true;
	
	door:SetNotSolid(true);
	door:DrawShadow(false);
	door:SetNoDraw(true);
	door:EmitSound("physics/wood/wood_box_impact_hard3.wav");
	door:Fire("Unlock", "", 0);

	local fakeDoor = ents.Create("prop_physics");
	
	fakeDoor:SetCollisionGroup(COLLISION_GROUP_WORLD);
	fakeDoor:SetAngles(door:GetAngles());
	fakeDoor:SetModel(door:GetModel());
	fakeDoor:SetSkin(door:GetSkin() or 0);
	fakeDoor:SetPos(door:GetPos());
	fakeDoor:Spawn();

	local physicsObject = fakeDoor:GetPhysicsObject();

	if (IsValid(physicsObject)) then
		if (IsValid(client)) then
			physicsObject:ApplyForceCenter((door:GetPos() - client:GetPos()):GetNormal() * 30000);
		end
	end;

	timer.Create("reset_door_"..door:EntIndex(), ix.config.Get("RespawnDoors"), 1, function()
		if (IsValid(door)) then
			door.bustedDown = nil;
			door:SetNotSolid(false);
			door:DrawShadow(true);
			door:SetNoDraw(false);

			fakeDoor:Remove();
		end;
	end);
end

function PLUGIN:PlayerUse( ply, ent )
	-- if the player is holding alt and is trying to use a door
	if !(ply) then return end
	if !(ent) then return end
	if !(self.doors[ent:GetClass()]) then return end
	if !(!ent:IsLocked()) then return end
	for k, v in pairs(ents.FindInSphere(ent:GetPos(), 200)) do
		if !(self.doors[v:GetClass()]) then continue end
		if (v:GetPos():Distance(ent:GetPos()) < 100) then 
			if v:GetNWBool("RunOnce") then 
				if v:GetName() == ent:GetName() then 
					v:SetNWEntity("ControlingPlayer", ply)
					if (ply:KeyDown(IN_WALK)) then
						if (v:GetKeyValues()["speed"] == v:GetNWInt("DefaultSpeed", 100)) then 
							v:Fire("setspeed", ix.config.Get("StealthySpeed"))
							v:Fire("openawayfrom", ply:UniqueID())
						end
					elseif (ply:KeyDown(IN_SPEED)) then
						if (v:GetKeyValues()["speed"] == v:GetNWInt("DefaultSpeed", 100)) then 
							self:KnokOutDoor(ply, ent)
							v:Fire("setspeed", ent:GetNWInt("DefaultSpeed"))
						end
					else
						if v:GetKeyValues()["speed"] == ix.config.Get("StealthySpeed") then
							v:Fire("setspeed", ent:GetNWInt("DefaultSpeed"))
						end
					end
					v:SetNWBool("RunOnce", false)
				end
			else
				v:SetNWBool("RunOnce", true)
			end
		end
	end
end

function PLUGIN:EntityKeyValue( ent, key, value )
	if (self.doors[ent:GetClass()]) then
		if (key == "speed") then
			ent:SetNWInt("DefaultSpeed", tonumber(value))
		end
	end 
end

function PLUGIN:EntityEmitSound( data )
	if (self.doors[data.Entity:GetClass()]) then
		if IsValid(data.Entity:GetNWEntity("ControlingPlayer")) then
			if (data.Entity:GetKeyValues()["speed"] == ix.config.Get("StealthySpeed") or (data.Entity:GetNWEntity("ControlingPlayer"):KeyDown(IN_WALK) or false)) then 
				return false
			elseif (data.Entity:GetKeyValues()["speed"] == data.Entity:GetNWInt("DefaultSpeed", tonumber(value)) or !(data.Entity:GetNWEntity("ControlingPlayer"):KeyDown(IN_WALK) or false)) then
				return true 
			end
		end
	end
end