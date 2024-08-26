SWEP.PrintName = "Дозиметр КМБ-3"
SWEP.Category = "CMBMTK"
SWEP.Author = "CMBMTK"
SWEP.Spawnable = true

SWEP.HoldType = "knife"
SWEP.ViewModelFOV = 80
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/cmbmtk/eft/geigercounter.mdl"
SWEP.WorldModel = "models/cmbmtk/eft/geigercounter.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.Easteregg = false
SWEP.ViewModelBoneMods = {
	["static_prop"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
SWEP.RadOthr = nil

local loadingDots = ""
local loadingTime = 0
local showData = false
local dataDisplayTime = 5
local dataDisplayTimer = 0

SWEP.alpha = 0
local animSpeed = 0.4
SWEP.VElements = {

	["quad"] = { type = "Quad", bone = "static_prop", rel = "mainmodel", pos = Vector(0, 0, 1.1), angle = Angle(0, 90, 0), size = 0.01, draw_func = function(self)

		if !ix then return end
			local client = self.Owner
			local radply = client:GetCharacter():GetData("RadAmount", 0)
			local inventory = client:ExtraInventory("armband")
			local item = inventory:GetEquipedItem()

			if !inventory and !item then return end

			local batterylevel = item:GetData("BatteryCondition")
			if batterylevel == nil or batterylevel <= 0 then return end

			draw.RoundedBox(8, -86, -79, 170, 168, Color(0, 0, 0))

			surface.SetMaterial(Material("data/radsym.png", "mips"))
			surface.SetDrawColor( 255, 255, 255, 10 )
			surface.DrawTexturedRectRotated( 0, 0, 100, 100, (CurTime() % 360) * 20 )

			draw.DrawText("Накоплено:"..math.Round(radply, 2), "Rad_min", -85, -70, Color(0, 255, 0))

			draw.DrawText("БАТАРЕЯ: "..batterylevel.."%", "Rad_min2", 0, 12, Color(0, 255, 0), TEXT_ALIGN_CENTER)

			draw.DrawText("MUTIEV STANDART", "Rad_min", -75, 70, Color(0, 40, 0))

			local position = client:GetPos() + client:OBBCenter()
			local inRadiationZone = false

			for id, info in pairs(ix.area.stored) do
				if (position:WithinAABox(info.startPosition, info.endPosition)) then
					if info.type == "RadiationZone" then

						if not showData then
							local dotsCount = math.floor(SysTime() % 3) + 1
							loadingDots = string.rep(".", dotsCount)
					
							draw.DrawText("РАД/О:" .. loadingDots .. "/±0 μSv", "Rad_min", -85, -40, Color(0, 255, 0))
					
							if loadingTime == 0 then
								loadingTime = SysTime() + math.random(3, 5)
							elseif SysTime() > loadingTime then
								showData = true
								local rand = math.Rand(-1, 1)
								currentRadiation = info.properties.Radiationamount + rand
								--pogresh = math.abs(rand)
							end
						else
							if dataDisplayTimer == 0 then
								dataDisplayTimer = SysTime() + dataDisplayTime
							end
							
							if SysTime() <= dataDisplayTimer then
								draw.DrawText("РАД/О:" .. string.format("%.2f", currentRadiation) .. "/±1 μSv", "Rad_min", -85, -40, Color(0, 255, 0))
							else
								showData = false
								loadingTime = 0
								dataDisplayTimer = 0
							end

						end

						draw.DrawText("Загрязнение:", "Rad_min", -85, -10, Color(0, 255, 0))

						if info.properties.Radiationamount >= 3 then
							draw.RoundedBox(8, 10, -10, 20, 20, Color(255, 0, 0))
						elseif info.properties.Radiationamount > 1 then
							draw.RoundedBox(8, 10, -10, 20, 20, Color(255, 255, 0))
						else
							draw.RoundedBox(8, 10, -10, 20, 20, Color(150, 255, 0))
						end

						inRadiationZone = true
					end
				end
			end

			if not inRadiationZone then
				local dotsCount = math.floor(SysTime() % 3) + 1
				loadingDots = string.rep(".", dotsCount)

				draw.DrawText("РАД/О:" .. loadingDots .. "/±0 μSv", "Rad_min", -85, -40, Color(0, 255, 0))

				if loadingTime == 0 then
					loadingTime = SysTime() + math.random(3, 5)
				elseif SysTime() > loadingTime then
					showData = true
				end

				draw.DrawText("Загрязнение:", "Rad_min", -85, -10, Color(0, 255, 0))
				draw.RoundedBox(8, 10, -10, 20, 20, Color(0, 255, 0))
			end

		draw.DrawText("---------------------", "Rad_min", -85, 15, Color(0, 255, 0))
		
		if self.RadOthr then
			draw.DrawText("Скан: "..math.Round(self.RadOthr, 2), "Rad_min", -85, 30, Color(0, 255, 0))
		else
			draw.DrawText("Скан: [LBM PLY]", "Rad_min", -85, 30, Color(0, 255, 0))
		end
		if self.Easteregg then
			draw.RoundedBox(8, -86, -79, 170, 168, Color(0, 0, 0))
			if self.alpha < 255 then
				self.alpha = math.min(self.alpha + animSpeed, 255)
			end
			
			surface.SetMaterial(Material("data/easter.png", "mips"))
			surface.SetDrawColor(255, 255, 255, self.alpha)
			surface.DrawTexturedRect(-86, -79, 170, 168)
			draw.DrawText("Ярик", "Rad_min", -20, 40, Color(255, 255, 0, self.alpha))
			draw.DrawText("там карасей добавили", "Rad_min", -75, 55, Color(255, 255, 0, self.alpha))
		end
	end},
	["mainmodel"] = { type = "Model", model = "models/cmbmtk/eft/geigercounter.mdl", bone = "static_prop", rel = "", pos = Vector(9.869, 4, -3), angle = Angle(-75, 180, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["mainmodel"] = { type = "Model", model = "models/cmbmtk/eft/geigercounter.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(120.389, 22.208, 5.843), size = Vector(0.56, 0.56, 0.56), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

if CLIENT then
	surface.CreateFont( "Rad_min", {
		font = "Courier New",
		extended = false,
		size = 17,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )

	surface.CreateFont( "Rad_min2", {
		font = "Courier New",
		extended = false,
		size = 13,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )

	http.Fetch("https://i.imgur.com/KWKBSe1.png", function(img) file.Write("radsym.png", img) end)
	http.Fetch("https://i.imgur.com/TwRrKRb.jpg", function(img) file.Write("easter.png", img) end) -- смешной сом)

	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

function SWEP:Reload()
	return
end


function SWEP:PrimaryAttack()
	if !self:GetOwner():IsWepRaised() then return end

	self:SetNextPrimaryFire(CurTime() + 5)

	local client = self:GetOwner()
	local character = client:GetCharacter()

	if !client:Alive() and !character then return end

	local target = client:GetEyeTrace().Entity

	if !target:IsPlayer() then return end

	self.RadOthr = target:GetNetVar("RadAmount", 0)
end

function SWEP:SecondaryAttack()
	-- 	if !self:GetOwner():IsWepRaised() then return end
	
	--     if self.NextReloadTime and self.NextReloadTime > CurTime() then
	--         return
	--     end
	
	--     self.NextReloadTime = CurTime() + 5
	
	-- 	if CLIENT then
	-- 		timer.Simple(4, function()
	-- 			self.alpha = 0
	-- 			self.Easteregg = false
	-- 		end)
	-- 		sound.PlayURL("https://puu.sh/JOSeS.mp3", "mono", function(station) 
	-- 			if ( IsValid( station ) ) then
	-- 				self.Easteregg = true
	-- 			end
	-- 		end)
	-- 	end
	return
end
	

function SWEP:Initialize()

	// other initialize code goes here

	if CLIENT then
	
		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		// init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
		
	end

end

function SWEP:Holster()
	
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	return true
end

function SWEP:OnRemove()
	self:Holster()
end

if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end

