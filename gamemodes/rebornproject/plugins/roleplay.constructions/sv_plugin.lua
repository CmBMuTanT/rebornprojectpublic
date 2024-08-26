local zerotable = {
	["CP_Placing"] = false,
	["CP_ReadyToPlace"] = false,
	["CP_PropModel"] = "models/props_junk/PopCan01a.mdl",
	["CP_PropID"] = 0,
	["CP_PropRotation"] = 0,
	["CP_PropRotationY"] = 0,
	["CP_PropRotationX"] = 0,
}

function PLUGIN:SaveConstructionProp()
    local data = {}
    for _, v in ipairs(ents.FindByClass("prop_physics")) do
        if v.isConstruct then
            data[#data + 1] = {
                pos = v:GetPos(),
                angles = v:GetAngles(),
                model = v:GetModel(),
                health = v:Health(),
            }
        end
    end
    ix.data.Set("ConstructionProp", data)
end

function PLUGIN:LoadConstructionProp()
    for _, v in ipairs(ix.data.Get("ConstructionProp") or {}) do
        local prop = ents.Create( "prop_physics" )

        prop:SetModel( v.model )
        prop:SetPos( v.pos )
        prop:SetMoveType(MOVETYPE_VPHYSICS)
        prop:SetSolid(SOLID_VPHYSICS)
        prop:SetAngles(v.angles)
        prop:Spawn()
        prop:GetPhysicsObject():EnableMotion( false )
        prop:SetHealth(v.health)
        prop.isConstruct = true
    end
end

function PLUGIN:PlayerSpawn(client)
    for k,v in pairs(zerotable) do
        client:SetNetVar(k,v)
    end
end

function PLUGIN:PlayerDeath(client)
    for k,v in pairs(zerotable) do
        client:SetNetVar(k,v)
    end
end

function PLUGIN:PlayerTick(ply, mv)
    local wep = ply:GetActiveWeapon()
    local ang = ply:GetAngles()
    local tr = ply:GetEyeTrace()
    local pos = ply:GetPos()
    if ply:GetNetVar("CP_Placing") then
        ply:Give("ix_construct")
        ply:SetActiveWeapon(ply:GetWeapon("ix_construct"))

        if !ply:Crouching() and IsValid(ply) and ply:Alive() and IsValid(wep) and wep:GetClass() == "ix_construct" and pos:Distance(tr.HitPos) <= 250 then
            if not IsValid(ply.propConstructHolo) then
                ply.propConstructHolo = ents.Create("prop_physics")
                if IsValid(ply.propConstructHolo) then
                    ply.propConstructHolo:SetAngles(Angle(0 - ply:GetNetVar( "CP_PropRotation" ), 0 - ply:GetNetVar( "CP_PropRotationY" ), 0 - ply:GetNetVar( "CP_PropRotationX" ) ))
                    ply.propConstructHolo:SetPos(tr.HitPos - tr.HitNormal * ply.propConstructHolo:OBBMins().z)
                    ply.propConstructHolo:SetColor(Color(0,204,204, 150))
                    ply.propConstructHolo:SetModel(ply:GetNetVar( "CP_PropModel"))
                    ply.propConstructHolo:SetMaterial("models/shiny")
                    ply.propConstructHolo:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
                    ply.propConstructHolo:SetRenderMode(RENDERMODE_TRANSALPHA)
                    ply.propConstructHolo:Spawn()
                else
                    ply.propConstructHolo = nil
                end
            elseif IsValid(ply.propConstructHolo) then
                ply.propConstructHolo:SetPos(tr.HitPos - tr.HitNormal * ply.propConstructHolo:OBBMins().z)
                ply.propConstructHolo:SetAngles(Angle(0 - ply:GetNetVar( "CP_PropRotation" ), 0 - ply:GetNetVar( "CP_PropRotationY" ), 0 - ply:GetNetVar( "CP_PropRotationX" ) ))
                ply:SetNetVar("ConstructablePropReadytoPlace", true)
            end
        elseif ply.propConstructHolo != nil and IsValid(ply.propConstructHolo) then
            ply.propConstructHolo:Remove()
            ply.propConstructHolo = nil
            ply:SetNetVar("CP_Placing", false)
            ply:StripWeapon("ix_construct")
        end
    end
end
function PLUGIN:KeyPress(ply, key)
    if key == IN_USE and IsValid(ply) and ply:Alive() and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "ix_construct" and ply:GetEyeTrace().HitPos:Distance(ply:GetPos()) <= 250 then
        if ply:GetNetVar("CP_Placing") then
            for k, v in pairs(player.GetAll()) do
                if ply.propConstructHolo:GetPos():Distance(v:GetPos()) <= ply.propConstructHolo:BoundingRadius()*2 then
                    ply.propConstructHolo:SetColor(Color(204,0,68, 150))
                    ply:SetNetVar("bCanPlace", false)
                    timer.Simple( 0.1, function() ply.propConstructHolo:SetColor(Color(0,204,204, 150)) end )
                    break 
                else
                    ply.propConstructHolo:SetColor(Color(24,204,0, 150))
                    ply:SetNetVar("bCanPlace", true)
                end
            end
            if ply:GetNetVar( "bCanPlace") then
                local fortification = ents.Create("prop_physics")
                fortification:SetModel(ply:GetNetVar( "CP_PropModel"))
                fortification:SetAngles(Angle(0 - ply:GetNetVar( "CP_PropRotation" ), 0 - ply:GetNetVar( "CP_PropRotationY" ), 0 - ply:GetNetVar( "CP_PropRotationX" )))
                fortification:SetPos(ply:GetEyeTrace().HitPos - ply:GetEyeTrace().HitNormal * fortification:OBBMins().z)
                fortification:SetMoveType(MOVETYPE_VPHYSICS)
                fortification:SetSolid(SOLID_VPHYSICS)
                fortification:Spawn()

                local phys = fortification:GetPhysicsObject()
                local mass = phys:GetMass()
                phys:EnableMotion( false )

                
                if mass < 2000 then
                fortification:SetMaxHealth(math.ceil(mass * math.random(1, 2)))
                else
                fortification:SetMaxHealth(2000)
                end

                fortification:SetHealth(fortification:GetMaxHealth())

                if fortification:Health() > fortification:GetMaxHealth() then
                    fortification:SetHealth(fortification:GetMaxHealth())
                end

                fortification.isConstruct = true
                ply.propConstructHolo:Remove()
                ply:GetCharacter():GetInventory():GetItemByID(ply:GetNetVar( "CP_PropID" ), false):Remove(false, false)
                ply:SetNetVar("bCanPlace", false)
                ply:SetNetVar("CP_Placing", false)
                ply:SetNetVar( "CP_PropModel", "nul")
                ply:StripWeapon("ix_construct")
            end
        end
    end
    if key == IN_RELOAD and IsValid(ply) and ply:Alive() and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "ix_construct" and ply:GetEyeTrace().HitPos:Distance(ply:GetPos()) <= 250 then
        if ply:GetNetVar("CP_Placing") then
            ply:SetNetVar( "CP_PropModel", "nul")
            ply.propConstructHolo:Remove()
            ply:SetNetVar("CP_Placing", false)
        end
    end
    if key == IN_ATTACK and IsValid(ply) and ply:Alive() and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "ix_construct" then
        if ply:GetNetVar("CP_Placing") then
            if ply:GetNetVar( "CP_PropRotation" ) < 180 then
                ply:SetNetVar( "CP_PropRotation", ply:GetNetVar( "CP_PropRotation" ) + 15)
            else
                ply:SetNetVar( "CP_PropRotation", 0 )
            end
        end
    end
    if key == IN_ATTACK2 and IsValid(ply) and ply:Alive() and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "ix_construct" then
        if ply:GetNetVar("CP_Placing") then
            if ply:GetNetVar( "CP_PropRotationX" ) < 180 then
                ply:SetNetVar( "CP_PropRotationX", ply:GetNetVar( "CP_PropRotationX" ) + 15)
            else
                ply:SetNetVar( "CP_PropRotationX", 0 )
            end
        end
    end

    if key == IN_WALK and IsValid(ply) and ply:Alive() and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "ix_construct" then
        if ply:GetNetVar("CP_Placing") then
            if ply:GetNetVar( "CP_PropRotationY" ) < 180 then
                ply:SetNetVar( "CP_PropRotationY", ply:GetNetVar( "CP_PropRotationY" ) + 15)
            else
                ply:SetNetVar( "CP_PropRotationY", 0 )
            end
        end
    end
end
function PLUGIN:CanPlayerDropItem(client, item)
    if client:GetNetVar("CP_Placing") then
        if item == client:GetNetVar( "CP_PropID" ) or client:GetCharacter():GetInventory():GetItemByID(item, false).isBag then
        client.propConstructHolo:Remove()
        return false
        end
    end
end


function PLUGIN:EntityTakeDamage(target, dmginfo)
    if !target.isConstruct then return end

    local blast = dmginfo:IsDamageType(DMG_BURN) or dmginfo:IsDamageType(DMG_BLAST)
	target:SetHealth(target:Health() - (blast and dmginfo:GetDamage() * 4 or dmginfo:GetDamage()))

    local brit = math.Clamp(target:Health() / target:GetMaxHealth(), 0, 1)
    local col = target:GetColor()
    col.r = 255
    col.g = 255 * brit
    col.b = 255 * brit
    target:SetColor(col)


    if target:Health() <= 0 then

		target:EmitSound("physics/metal/metal_box_break" .. math.random(1, 2) .. ".wav")
		target:Remove()

		return
	end

end