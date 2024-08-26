ix.command.Add("loot_spawn", {
    description = "Спавн ящиков с лутом",
    adminOnly = true,
    arguments = {
        ix.type.number,
    },
    OnRun = function(self, client, cooldown)
        local vec = Vector(client:GetEyeTrace().HitPos.x,client:GetEyeTrace().HitPos.y,client:GetPos().z) + Vector(0,0,60)
        print(client:GetPos().z)
        print(vec)
        local box = ents.Create("box")
        box:SetPos(vec)
        box:SetAngles(client:GetAngles())
        box:SetNetworkedInt("uid",box:EntIndex())
        box:Spawn()
        box:DropToFloor()
        SaveLootFromDB(vec,cooldown,box:GetNetworkedInt("uid"),client:GetAngles())
    end
})

ix.command.Add("loot_remove", {
	description = "Удаляет ящик с лутом",
	adminOnly = true,
	OnRun = function(self, client)
		if IsValid(client:GetEyeTraceNoCursor().Entity) then
			if client:GetEyeTraceNoCursor().Entity:GetClass() == "box" then
				if client:GetEyeTraceNoCursor().Entity:GetNetworkedInt("uid") != 0 then
					RemoveLootFromDB(client:GetEyeTraceNoCursor().Entity:GetNetworkedInt("uid"))
				end
				client:GetEyeTraceNoCursor().Entity:Remove()
			else
				client:Notify([[Предмет, на который вы смотрите не является "Ящик с лутом"!]])
			end
		else
			client:Notify("Вы должны смотреть на энтити!")
		end
	end
}) 