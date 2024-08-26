
--
-- Copyright (C) 2019 Taxin2012
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--



--	Writed by Taxin2012
--	https://steamcommunity.com/id/Taxin2012/


local PLUGIN = PLUGIN
PLUGIN.name = "Тряска камеры"
PLUGIN.author = "Taxin2012, devdaniel, CW"
PLUGIN.description = "Ты тряси, тряси смартфон..."

------------------------------
-- Украдешь - п*дором будешь :D
-- Если все же взял у нас плагин - пожалуйста, не меняй авторов.
------------------------------

if CLIENT then
	local HBAP = 0
	local HBAY = 0
	local HBAR = 0
	local HBPX = 0
	local HBPY = 0
	local HBPZ = 0
	local Tbl = {}

	hook.Add( "CalcView", "HeadbobTest", function( pl, pos, ang, fov, znear, zfar )
		local v = {}
		if pl:GetMoveType() != MOVETYPE_NOCLIP && ( pl:GetLocalVar( "ImDrunk", 0 ) > 0 or ( pl:GetActiveWeapon().Base && not pl:GetActiveWeapon().Base:find( "tfa_" ) && not pl:GetActiveWeapon().Base:find( "metro_" ) ) ) then
			v.pos = pos
			v.ang = ang
			v.fov = fov
			
			if pl:KeyDown(IN_FORWARD) || pl:KeyDown(IN_BACK) || pl:KeyDown(IN_MOVELEFT) || pl:KeyDown(IN_MOVERIGHT) then
				HBPZ = HBPZ + (10 / 1) * FrameTime()
			end
		
			if pl:KeyDown(IN_FORWARD) then
				if HBAP < 1.5 then
					HBAP = HBAP + 0.05 * 1
				end
			else
				if HBAP > 0 then
					HBAP = HBAP - 0.05 * 1
				end
			end
			
			if pl:KeyDown(IN_BACK) then
				if HBAP > -1.5 then
					HBAP = HBAP - 0.05 * 1
				end
			else
				if HBAP < 0 then
					HBAP = HBAP + 0.05 * 1
				end
			end
			
			if pl:KeyDown(IN_MOVELEFT) then
				if HBAR > -1.5 then
					HBAR = HBAR - 0.07 * 1
				end
			else
				if HBAR < 0 then
					HBAR = HBAR + 0.07 * 1
				end
			end
			
			if pl:KeyDown(IN_MOVERIGHT) then
				if HBAR < 1.5 then
					HBAR = HBAR + 0.07 * 1
				end
			else
				if HBAR > 0 then
					HBAR = HBAR - 0.07 * 1
				end
			end

			pl.OLDANG = v.ang
			pl.OLDPOS = v.pos
			v.ang.pitch = v.ang.pitch + HBAP * 1
			v.ang.roll = v.ang.roll + HBAR * 1
			v.pos.z = v.pos.z - math.cos(HBPZ * 1)

			local frameTime = FrameTime();

			local approachTime = frameTime * 2;
			local curTime = CurTime();
			local info = { speed = 1, yaw = 0.5 * ( 1 + 4 * pl:GetLocalVar( "ImDrunk", 0 ) ), roll = 0.1 * ( 1 + 40 * pl:GetLocalVar( "ImDrunk", 0 ) ) };
			
			if (!Tbl.HeadbobAngle) then
				Tbl.HeadbobAngle = 0;
			end;
			
			if (!Tbl.HeadbobInfo) then
				Tbl.HeadbobInfo = info;
			end;
			
			Tbl.HeadbobInfo.yaw = math.Approach(Tbl.HeadbobInfo.yaw, info.yaw, approachTime);
			Tbl.HeadbobInfo.roll = math.Approach(Tbl.HeadbobInfo.roll, info.roll, approachTime);
			Tbl.HeadbobInfo.speed = math.Approach(Tbl.HeadbobInfo.speed, info.speed, approachTime);
			Tbl.HeadbobAngle = Tbl.HeadbobAngle + (Tbl.HeadbobInfo.speed * frameTime);
			
			local yawAngle = math.sin(Tbl.HeadbobAngle);
			local rollAngle = math.cos(Tbl.HeadbobAngle);
			
			ang.y = ang.y + (yawAngle * Tbl.HeadbobInfo.yaw);
			ang.r = ang.r + (rollAngle * Tbl.HeadbobInfo.roll);

			local velocity = pl:GetVelocity();
			
			if (!Tbl.VelSmooth) then Tbl.VelSmooth = 0; end;
			if (!Tbl.WalkTimer) then Tbl.WalkTimer = 0; end;
			
			Tbl.VelSmooth = math.Clamp(Tbl.VelSmooth * 0.9 + velocity:Length() * 0.1, 0, 700)
			Tbl.WalkTimer = Tbl.WalkTimer + Tbl.VelSmooth * FrameTime() * 0.05
			
			ang.p = ang.p + math.cos(Tbl.WalkTimer * 0.5) * Tbl.VelSmooth * 0.000002 * Tbl.VelSmooth;
			ang.r = ang.r + math.sin(Tbl.WalkTimer) * Tbl.VelSmooth * 0.000002 * Tbl.VelSmooth;
			ang.y = ang.y + math.cos(Tbl.WalkTimer) * Tbl.VelSmooth * 0.000002 * Tbl.VelSmooth;
		else
		end
	end )
end

------------------------------
-- Украдешь - п*дором будешь :D
-- Если все же взял у нас плагин - пожалуйста, не меняй авторов.
------------------------------