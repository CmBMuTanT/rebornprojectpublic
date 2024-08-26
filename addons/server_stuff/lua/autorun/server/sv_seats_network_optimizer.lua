local ipairs = ipairs
local ents_FindByClass = ents.FindByClass
local IsValid = IsValid

hook.Add( "OnEntityCreated", "seats_network_optimizer", function( seat )
	if seat:GetClass()=="prop_vehicle_prisoner_pod" then
		seat:AddEFlags( EFL_NO_THINK_FUNCTION ) -- disable seat's Think
		seat.seats_network_optimizer = true -- Now we know that this seat has been processed by this addon.
	end
end )

local i
local seats
local last_enabled -- previously processed seat
-- This function enables the Think of one seat during each frame to save network traffic.
-- The Think of seats is only needed for animation handling.
hook.Add( "Think", "seats_network_optimizer", function()
	-- Make list:
	if not seats or not seats[i] then
		-- Begin a new loop, with a new seats list.
		i = 1
		seats = {}
		for _,seat in ipairs( ents_FindByClass( "prop_vehicle_prisoner_pod" ) ) do
			if seat.seats_network_optimizer then
				table.insert( seats, seat )
			end
		end
	end
	-- Find a valid seat:
	while seats[i] and not IsValid( seats[i] ) do
		-- Jump to the next valid seat.
		i = i+1
	end
	local seat = seats[i]
	-- Disable the previously processed seat's Think if ready:
	if last_enabled~=seat and IsValid( last_enabled ) then -- ignore a seat's Think that is gonna be re-enabled
		-- last_enabled's Think is kept enabled until m_bEnterAnimOn and m_bExitAnimOn are reset.
		local saved = last_enabled:GetSaveTable()
		if not saved["m_bEnterAnimOn"] and not saved["m_bExitAnimOn"] then
			last_enabled:AddEFlags( EFL_NO_THINK_FUNCTION ) -- disable last_enabled's Think
			last_enabled = nil
		end
	end
	-- Enable a seat's Think:
	if IsValid( seat ) then
		-- seat's Think is enabled, letting the values m_bEnterAnimOn and m_bExitAnimOn being updated.
		seat:RemoveEFlags( EFL_NO_THINK_FUNCTION )
		last_enabled = seat
	end
	i = i+1
end )

local function EnteredOrLeaved( ply, seat )
	if IsValid( seat ) and seat.seats_network_optimizer then
		table.insert( seats, i, seat ) -- seat's Think will be enabled on next game's Think
	end
end
hook.Add( "PlayerEnteredVehicle", "seats_network_optimizer", EnteredOrLeaved )
hook.Add( "PlayerLeaveVehicle", "seats_network_optimizer", EnteredOrLeaved )

function SetFpsFix(size)
	if not entFog then
		local v = ents.Create( "env_fog_controller" )
		v:SetKeyValue("fogend",2000)
		v:SetKeyValue("fogstart",500)
		v:SetKeyValue("farz",2000)
		--:SetPos(Vector(-2556, -659, 271))
		v:Spawn( )
		entFog = v
		print("created")
	end

	entFog:SetKeyValue("farz",size)
end

local globalFogDed = 4000
local TableCountFps = {
	[40]	=	4000,
	[41]	=	3950,
	[42]	=	3900,
	[43]	=	3850,
	[44]	=	3800,
	[45]	=	3750,
	[46]	=	3700,
	[47]	=	3650,
	[48]	=	3600,
	[49]	=	3550,
	[50]	=	3500,
	[51]	=	3450,
	[52]	=	3400,
	[53]	=	3350,
	[54]	=	3300,
	[55]	=	3250,
	[56]	=	3200,
	[57]	=	3150,
	[58]	=	3100,
	[59]	=	3050,
	[60]	=	3000,
	[61]	=	2950,
	[62]	=	2900,
	[63]	=	2850,
	[64]	=	2800,
	[65]	=	2750,
	[66]	=	2700,
	[67]	=	2650,
	[68]	=	2600,
	[69]	=	2550,
	[70]	=	2500,
	[71]	=	2450,
	[72]	=	2400,
	[73]	=	2350,
	[74]	=	2300,
	[75]	=	2250,
	[76]	=	2200,
	[77]	=	2150,
	[78]	=	2100,
	[79]	=	2050,
	[80]	=	2000,
}
timer.Create( "fpsoptdix", 2, 0, function()  
	if #player.GetAll()>40 and #player.GetAll()<80 then 
		globalFogDed = TableCountFps[#player.GetAll()]
	elseif #player.GetAll()>80 then
		globalFogDed = 2000
	elseif #player.GetAll()<40 then
		globalFogDed = 4000
	end

	SetFpsFix(globalFogDed)
end )


for _,VehicleTable in pairs( list.GetForEdit( "Vehicles" ) ) do
	if isstring( VehicleTable.Model ) then
		util.PrecacheModel( VehicleTable.Model )
	end
end

-- Preload all scripted weapon models:
for _,EntityTable in pairs( scripted_ents.GetList() ) do
	if isstring( EntityTable.t.Model ) then -- may contain useful value
		util.PrecacheModel( EntityTable.t.Model )
	end
end

-- Preload all scripted entity models:
for _,WeaponTable in pairs( scripted_ents.GetList() ) do
	if isstring( WeaponTable.ViewModel ) then
		util.PrecacheModel( WeaponTable.ViewModel )
	end
	if isstring( WeaponTable.WorldModel ) then
		util.PrecacheModel( WeaponTable.WorldModel )
	end
	if isstring( WeaponTable.Model ) then -- might be useful
		util.PrecacheModel( WeaponTable.Model )
	end
end