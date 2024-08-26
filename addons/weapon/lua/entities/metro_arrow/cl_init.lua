
include('shared.lua')

ENT.ArrowModelPath = "models/crossbow_bolt.mdl"
ENT.ArrowModel = nil

function ENT:Initialize()
	
	pos = self:GetPos()

	--self.ArrowModel = ClientsideModel(self.ArrowModelPath, RENDERGROUP_BOTH)
	--self.ArrowModel:SetAngles(self.Entity:GetAngles())
	--self.ArrowModel:SetNoDraw( true )
	
end

local spritemat = Material( "effects/yellowflare" )

function ENT:Draw()

	--if self.DrawModel then
		self.Entity:DrawModel()
	--else
	--	if self:GetVelocity():Length() > 100 then
	--		render.SetMaterial( spritemat ) 
	--		render.DrawSprite(self.Entity:GetPos(), 8, 8, Color( 255, 255, 255 ))
	--	end
	--end
	
	--pos = self:GetPos()
	
	--self.ArrowModel:DrawModel()
	--self.ArrowModel:SetPos(pos)
	--self.ArrowModel:SetAngles(self:GetVelocity():Angle())
		
end
