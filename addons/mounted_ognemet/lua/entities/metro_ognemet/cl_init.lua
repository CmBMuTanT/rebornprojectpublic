
include('shared.lua')

local function DrawCircle( x, y, radius, progress )
	local cir = {}
	
	local seg = 50
	local percentage = ((progress - 0)/(100-0))
	
	table.insert( cir, { x = x, y = y } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * (-360*percentage) )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius } )
	end
	table.insert( cir, { x = x, y = y } )

	render.SetStencilWriteMask( 0xFF )
	render.SetStencilTestMask( 0xFF )
	render.SetStencilReferenceValue( 0 )
	render.SetStencilCompareFunction( STENCIL_ALWAYS )
	render.SetStencilPassOperation( STENCIL_KEEP )
	render.SetStencilFailOperation( STENCIL_KEEP )
	render.SetStencilZFailOperation( STENCIL_KEEP )
	render.ClearStencil()
	
	render.SetStencilEnable( true )
	render.SetStencilReferenceValue( 1 )
	render.SetStencilCompareFunction( STENCIL_NEVER )
	render.SetStencilFailOperation( STENCIL_REPLACE )
		local cir2 = {}
		
		for i = 0, seg do
			local a = math.rad( ( i / seg ) * (-360) )
			table.insert( cir2, { x = (x) + math.sin( a ) * (radius-10), y = (y) + math.cos( a ) * (radius-10) } )
		end
		draw.NoTexture()
		surface.SetDrawColor( color_white )
		surface.DrawPoly( cir2 )
		
	render.SetStencilCompareFunction( STENCIL_GREATER )
	render.SetStencilFailOperation( STENCIL_KEEP )
		local cir2 = {}
		
		for i = 0, seg do
			local a = math.rad( ( i / seg ) * (-360) )
			table.insert( cir2, { x = (x) + math.sin( a ) * (radius), y = (y) + math.cos( a ) * (radius) } )
		end
		draw.NoTexture()
		surface.SetDrawColor( 0, 0, 0, 200 )
		surface.DrawPoly( cir2 )
			
	surface.SetDrawColor( 255, 194, 102, 255)
	surface.DrawPoly( cir )

	render.SetStencilEnable( false )
	render.SetStencilWriteMask( 0xFF )
	render.SetStencilTestMask( 0xFF )
	render.SetStencilReferenceValue( 0 )
	render.SetStencilCompareFunction( STENCIL_ALWAYS )
	render.SetStencilPassOperation( STENCIL_KEEP )
	render.SetStencilFailOperation( STENCIL_KEEP )
	render.SetStencilZFailOperation( STENCIL_KEEP )
	render.ClearStencil()
	
end

ENT.StrelkaBone = nil
ENT.StrelkaAng = Angle(0, 0, 0)

function ENT:Draw()

	self.Entity:DrawModel()
	
		local ply = LocalPlayer()	
	
		--[[if self.RotationBone2 == nil then
			self.RotationBone2 = self.Entity:LookupBone("ognemet_rotation_2")
		end]]
	
		--local pos, ang = self.Entity:GetBonePosition(self.RotationBone2)
	
		local angshit = self.Entity:GetAngles()--ply:EyeAngles()
		angshit = angshit * 1
		angshit:RotateAroundAxis( angshit:Right(), 0 )
		angshit:RotateAroundAxis( angshit:Up(), 0 )
		angshit:RotateAroundAxis( angshit:Forward(), 90 )

		local pos = self.Entity:GetPos() + angshit:Forward()*5 + angshit:Right()*-10 + angshit:Up() * 18
	
		cam.Start3D2D( pos, angshit, 0.1 )	
			
			DrawCircle(0, -64, 20, self:GetAmmo())

		cam.End3D2D()
	
	--[[if self.StrelkaBone == nil then
		self.StrelkaBone = self.Entity:LookupBone("ognemet_strelka")
	else
		self.StrelkaAng.r = Lerp(FrameTime()*10, self.StrelkaAng.r, self:GetAmmo())
		self.Entity:ManipulateBoneAngles(self.StrelkaBone, self.StrelkaAng)
	end]]
			
end
