
PLUGIN.name = "Anti-Bhop"
PLUGIN.author = "Bilwin"
PLUGIN.schema = "Any"

function PLUGIN:KeyPress( ply, key )
	if ply:KeyPressed( IN_JUMP ) then
		local trace = {}
		trace.start = ply:GetShootPos() + Vector( 0, 0, 15 )
		trace.endpos = trace.start + ply:GetAimVector() * 30
		trace.filter = ply
		
		local trHi = util.TraceLine(trace)
		
		local trace = {}
		trace.start = ply:GetShootPos()
		trace.endpos = trace.start + ply:GetAimVector() * 30
		trace.filter = ply
		
		local trLo = util.TraceLine(trace)
			
		if trLo and trHi and trLo.Hit and !trHi.Hit then
			local dist = math.abs(trHi.HitPos.z - ply:GetPos().z)
			ply:SetVelocity(Vector(0, 0, (50 + dist * 3)))
		end
	end
end

function PLUGIN:PlayerBindPress(client, bind, pressed)
	if pressed and string.find(bind:lower(), "+jump") and IsValid(client) and client:Alive() and client:GetCharacter() and client:GetMoveType() == MOVETYPE_WALK and client:OnGround() then
		if (client:GetLocalVar("stm",0) < 13) then return true end
		net.Start("Jump")
		net.SendToServer()
	end
end


ix.util.Include("sv_plugin.lua")