local settings = {
	Toggle = true,
	Strafe_Toggle = 1,
	Stand_Toggle = 1,
	Stand_Mul = 0.2,
	Crouch_Toggle = 1,
	Crouch_Mul = 0.5,
	Prone_Toggle = 1,
	Prone_Mul = 0.5,
	Water_Toggle = 1,
	Water_Mul = 0.3,
	Land_Toggle = 1,
	Land_Mul = 0.1,
	Land_Frames = 10,
	Blacklist_PhysGun = true,
	Blacklist_ToolGun = true,
	Blacklist_Camera = false,
}

local PCalcT = {
	["VS"] = 0,
	["WT"] = 0,
	["Air"] = 0,
}

local function HeadBobbing(ply, origin, angles, fov)
	-- Create the blacklist
	local blacklistWeapon
	-- Player is not alive OR invalid or they have a craptastic weapon, cancel out.
	if not ply:Alive() or not IsValid(ply) or not IsValid(ply:GetActiveWeapon()) then return end
	-- Headbob toggles for specific weapons
	local PhysGunToggle = settings["Blacklist_PhysGun"]
	local ToolGunToggle = settings["Blacklist_ToolGun"]
	local CameraToggle = settings["Blacklist_Camera"]

	-- This is messy as shit, but the best way I know how to do it.
	if (ply:GetActiveWeapon():GetClass() == "gmod_camera" and CameraToggle) or (ply:GetActiveWeapon():GetClass() == "gmod_tool" and ToolGunToggle) or (ply:GetActiveWeapon():GetClass() == "weapon_physgun" and PhysGunToggle) then
		-- They're blasklisted, and can fuck right off
		blacklistWeapon = true
	end

	-- Create the headbob toggle cvar
	local HeadBobToggle = settings["Toggle"]

	-- If the cvar doesn't exist, or the weapon is blacklisted...
	if (not HeadBobToggle) or blacklistWeapon then
		-- Cancel out!
		-- If the cvar DOES exist and the weapon is NOT blacklisted...
		return
	else
		-- If player is in NOCLIP...
		if ply:GetMoveType() == 8 then
			-- Nullify!
			-- They're in the air or in a car
			return
		elseif (not ply:IsOnGround() and ply:WaterLevel() == 0) or ply:InVehicle() then
			PCalcT.Air = math.Clamp(PCalcT.Air + 1, 0, 300)

			return
		else -- Main script
			local ang = ply:EyeAngles() -- Eye Angles

			local view = {
				["ply"] = ply,
				["origin"] = origin,
				["angles"] = angles,
				["fov"] = fov,
			}

			-- Toggle for Landing Angles
			if settings["Land_Toggle"] ~= 0 and PCalcT.Air > 0 then
				local FrameCount

				-- If Landing Frame Blend is less than/equal to 10
				if settings["Land_Frames"] <= 10 then
					-- Limit to 10 to prevent crashing
					FrameCount = 10
				else
					-- If the number you passed it isn't bogus, set the frame count blend to the convar
					FrameCount = settings["Land_Frames"]
				end

				PCalcT.Air = PCalcT.Air - (PCalcT.Air / FrameCount) -- Make it end in some frames
				view.angles.p = view.angles.p + (PCalcT.Air * (settings["Land_Mul"] / 10)) -- Pitch Cam Shake on Land
				view.angles.r = view.angles.r + (PCalcT.Air * (settings["Land_Mul"] / 5)) * math.Rand(-1, 1) -- Roll Cam Shake on Land
			end

			-- Toggle for Crouching Angles
			if settings["Crouch_Toggle"] ~= 0 and ply:Crouching() then
				local velocityMultiplier = (ply:GetVelocity() * (2 * settings["Crouch_Mul"]))
				-------------------------
				-- Footstep Angles
				-------------------------
				PCalcT.VS = PCalcT.VS * 0.9 + velocityMultiplier:Length() * 0.1
				PCalcT.WT = PCalcT.WT + PCalcT.VS * FrameTime() * 0.1

				-------------------------
				-- Strafe Angles
				-------------------------
				if settings["Strafe_Toggle"] ~= 0 then
					view.angles.r = angles.r + ang:Right():DotProduct(velocityMultiplier) * 0.0015 -- Strafe Angles
				end

				view.angles.r = angles.r + math.sin(PCalcT.WT) * PCalcT.VS * 0.001
				view.angles.p = angles.p + math.sin(PCalcT.WT * 0.5) * PCalcT.VS * 0.001
				-- Toggle for Prone Angles
				-- Programmed for use with "The Prone Mod"
				-- Standalone version: https://steamcommunity.com/sharedfiles/filedetails/?id=1100368137
				-- wOS version: https://steamcommunity.com/sharedfiles/filedetails/?id=775573383
				-- "prone" is the global name the mod uses, so if that doesn't exist, odds are the player doesn't have the mod
				-- IsProne is the name of the function used by the mod, so this wouldn't exist without it
			elseif prone and settings["Prone_Toggle"] ~= 0 and ply:IsProne() then
				local velocityMultiplier = (ply:GetVelocity() * (5 * settings["Prone_Mul"]))
				-------------------------
				-- Footstep Angles
				-------------------------
				PCalcT.VS = PCalcT.VS * 0.9 + velocityMultiplier:Length() * 0.1
				PCalcT.WT = PCalcT.WT + PCalcT.VS * FrameTime() / 24

				-------------------------
				-- Strafe Angles
				-------------------------
				if settings["Strafe_Toggle"] ~= 0 then
					view.angles.r = angles.r + ang:Right():DotProduct(velocityMultiplier) * 0.001 -- Strafe Angles
				end

				view.angles.r = angles.r + math.sin(PCalcT.WT) * PCalcT.VS * 0.001
				view.angles.p = angles.p + math.sin(PCalcT.WT * 0.5) * PCalcT.VS * 0.001
			else -- Toggle for Movement Angles
				-- Just keep swimming...
				if settings["Water_Toggle"] ~= 0 and ply:WaterLevel() ~= 0 then
					-- print("SWIMMING!")
					local velocityMultiplier = (ply:GetVelocity() * (1 * settings["Water_Mul"]))
					-----------------------
					-- Footstep Angles
					-----------------------
					PCalcT.VS = PCalcT.VS * 0.9 + velocityMultiplier:Length() * 0.1
					PCalcT.WT = PCalcT.WT + PCalcT.VS * FrameTime() * 0.1

					-----------------------
					-- Strafe Angles
					-----------------------
					if settings["Strafe_Toggle"] ~= 0 then
						view.angles.r = angles.r + ang:Right():DotProduct(velocityMultiplier) * 0.005 -- Strafe Angles
					end

					view.angles.r = angles.r + math.sin(PCalcT.WT) * PCalcT.VS * 0.001
					view.angles.p = angles.p + math.sin(PCalcT.WT * 0.5) * PCalcT.VS * 0.001
					-- Regular boring ass walking
				else
					local velocityMultiplier = (ply:GetVelocity() * (1 * settings["Stand_Mul"]))
					-------------------------
					-- Footstep Angles
					-------------------------
					PCalcT.VS = PCalcT.VS * 0.9 + velocityMultiplier:Length() * 0.1
					PCalcT.WT = PCalcT.WT + PCalcT.VS * FrameTime() * 0.1

					-------------------------
					-- Strafe Angles
					-------------------------
					if settings["Strafe_Toggle"] ~= 0 then
						view.angles.r = angles.r + ang:Right():DotProduct(velocityMultiplier) * 0.005 -- Strafe Angles
					end

					view.angles.r = angles.r + math.sin(PCalcT.WT) * PCalcT.VS * 0.001
					view.angles.p = angles.p + math.sin(PCalcT.WT * 0.5) * PCalcT.VS * 0.001
				end
			end

			return view
		end
	end
end

--[[
DefaultPresets["Gameplay"] = {
	enable = 1,
	speed = 15,
	exponential = 0,
	exponential_speed = 1,
	adjust_mouse = 1,
	adjust_mouse_mult = 1,
	adjust_viewmodel = 1
}

DefaultPresets["Cinematic Noclip"] = {
	enable = 1,
	speed = 5,
	exponential = 0,
	exponential_speed = 1,
	adjust_mouse = 0,
	adjust_mouse_mult = 1,
	adjust_viewmodel = 1
}

DefaultPresets["Exponential"] = {
	adjust_mouse = 0,
	adjust_mouse_mult	= 1,
	enable = 1,
	exponential = 1,
	exponential_speed = 30,
	speed = 4,
	adjust_viewmodel = 0
}
]]--

local smooth_settings = {
	enable = true,
	speed = 10,
	exponential = true,
	exponential_speed = 1,
	adjust_mouse = true,
	adjust_mouse_mult = 1,
	adjust_viewmodel = true
}

local CameraAngles = IsValid(LocalPlayer()) and LocalPlayer():EyeAngles() or Angle(0, 0, 0)
local LerpAngle, FrameTime, abs = LerpAngle, FrameTime, math.abs

local function SmoothCamera(ply, origin, angles, fov)
	if smooth_settings.enable == false or (ply:InVehicle() and ply:GetVehicle():GetThirdPersonMode()) or ply:GetViewEntity() ~= ply then return end

	if smooth_settings.exponential then
		local diff = abs(
			abs(CameraAngles.x) - abs(angles.x) + abs(CameraAngles.y) - abs(angles.y) + abs(CameraAngles.z) - abs(angles.z)
		) * 0.01

		local exp = math.max(math.exp(diff, smooth_settings.exponential_speed), 1)
		local speed = FrameTime() * smooth_settings.speed * exp

		CameraAngles = LerpAngle(speed, CameraAngles, angles)
	else
		CameraAngles = LerpAngle(FrameTime() * smooth_settings.speed, CameraAngles, angles)
	end

	return {
		origin = origin,
		angles = CameraAngles,
		fov = fov,
		drawviewer = false,
	}
end

local s2fov = 0

local function Speed2Fov(ply, pos, angles, fov)
	if IsValid(ply) and ply:Alive() and ply:Health() > 0 and ply:InVehicle() == false then
		s2fov = Lerp(FrameTime() * 3, s2fov, ply:GetVelocity():Length() * 0.015)

		return {
			origin = pos,
			angles = angles,
			fov = fov + s2fov,
			drawviewer = false
		}
	else
		s2fov = 0
	end
end

if smooth_settings.enable then
	hook.Add("AdjustMouseSensitivity", "SmoothCamera", function(default)
		if smooth_settings.adjust_mouse == false then return end

		return default * smooth_settings.speed * (0.02 * smooth_settings.adjust_mouse_mult)
	end)

	hook.Add("CalcViewModelView", "SmoothCamera", function(wep, vm, oldPos, oldAng, pos, ang)
		if (smooth_settings.enable and smooth_settings.adjust_viewmodel) == false then return end

		return pos, CameraAngles
	end)
else
	hook.Remove("AdjustMouseSensitivity", "SmoothCamera")
	hook.Remove("CalcViewModelView", "SmoothCamera")
end

hook.Add("CalcView", "CameraEffects", function(ply, origin, angles, fov)
	local data = Speed2Fov(ply, origin, angles, fov) or {
		origin = pos,
		angles = angles,
		fov = fov
	}
	table.Merge(data, SmoothCamera(ply, data.origin, data.angles, data.fov) or {})
	table.Merge(data, HeadBobbing(ply, data.origin, data.angles, data.fov) or {})

	local swep = ply:GetActiveWeapon()
	if IsValid(swep) and swep.CalcView then
		origin, angles, fov = swep:CalcView(ply, data.origin, data.angles, data.fov)
		data.origin, data.angles, data.fov = origin or view.origin, angles or view.angles, fov or view.fov
	end

	return data
end)