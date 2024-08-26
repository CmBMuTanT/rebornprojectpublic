PLUGIN.Name = "DRUGZ"
PLUGIN.Author = "N/A"
PLUGIN.Description = "блять я сдохнуть хочу"
local PLUGIN = PLUGIN


ix.char.RegisterVar("drugTimer", {
	field = "drugTimer",
	fieldType = ix.type.number,
	default = 5,
	isLocal = true,
	bNoDisplay = true
})

ix.char.RegisterVar("drug", {
    field = "drug",
    default = "",
    isLocal = true,
    bNoDisplay = true
})

--выглядит конечно это пиздец, согласен. Я в ахуе
if SERVER then
	function PLUGIN:SetupDrugTimer(client, character, drug, drugtimer)
		local steamID = client:SteamID64()
		local drugtimer = drugtimer or 5
		character:SetDrug(drug)
		character:SetDrugTimer(drugtimer)
		timer.Create("ixDrug" .. steamID, 1, 0, function()
			if (IsValid(client) and character) then
				self:DrugTick(client, character, drug, 1)
			else
				timer.Remove("ixDrug" .. steamID)
			end
		end)
	end
	
	function PLUGIN:PlayerDeath(client)
		local character = client:GetCharacter()
		if (character) then
			character:SetDrugTimer(0)
		end
	end
	
	function PLUGIN:DrugTick(client, character, drug, delta)
		if (!client:Alive() or client:GetMoveType() == MOVETYPE_NOCLIP) then
			return
		end
	
		local scale = 1
	
		-- update character drug timer
		local drugtimer = character:GetDrugTimer()
		local newTimer = math.Clamp(drugtimer - scale * (delta / 1), 0, 100)
	
		character:SetDrugTimer(newTimer)
	
		if (character:GetDrugTimer() < 1) then
			local boosts = character:GetBoosts()
	
			for attribID, v in pairs(boosts) do
				for boostID, _ in pairs(v) do
					character:RemoveBoost(boostID, attribID)
				end
			end
			character:SetDrugTimer(100)
			timer.Remove("ixDrug" .. client:SteamID64())
		end
	end
	
end


if CLIENT then
	netstream.Hook("lsdblyatz",function(client)

local mat_fb = Material( "pp/fb" )
local a = 1

hook.Add( "Think", "ThinkDrugsREct_savav_acid", function()
	if LocalPlayer().ALPHA1 != nil then  
if LocalPlayer().ALPHA1 <= 0 then
else
	if a == 1 then
		
		if math.random(0,600) == 1 then

				LocalPlayer():ConCommand( "+jump" )
				
		elseif math.random(0,200) == 2 then	
		LocalPlayer():ConCommand( "+forward" )
			timer.Simple(0.1,function()
				LocalPlayer():ConCommand( "-forward" )
			end)
		elseif math.random(0,600) == 2 then
				LocalPlayer():SetEyeAngles(LocalPlayer():EyeAngles()+Angle(0,math.random(-90,90),0))
		else
				LocalPlayer():ConCommand( "-jump" )
				
		end
		
	end
end
	end
end)

hook.Add( "CalcView", "CalcViewDrugsRect_savav_acid", function (ply, pos, angles, fov)
    if LocalPlayer().ALPHA1 != nil then 
        if LocalPlayer().ALPHA1 <= 0 then
        else
            if a == 1 then
                local view = {}
        
                view.origin = pos-( angles:Forward()*LocalPlayer().ALPHA1/10 )
                view.angles = angles+Angle(0,0,math.cos(CurTime()/8)*LocalPlayer().ALPHA1/4)
                view.fov = fov + LocalPlayer().ALPHA1/2
                view.drawviewer = false
        
                return view
            end
        end
            end
end )

hook.Add( "HUDPaint", "DrugsREct_savav_acid", function()
if LocalPlayer().ALPHA1 != nil then
if LocalPlayer().Active == 0 then
if LocalPlayer().ALPHA1 > 0 then LocalPlayer().ALPHA1 = LocalPlayer().ALPHA1 - 0.05 end
if LocalPlayer().ALPHA2 > 0 then LocalPlayer().ALPHA2 = LocalPlayer().ALPHA2 - 0.05 end
end

if LocalPlayer().ALPHA1 != nil then
	if a == 1 then
	if LocalPlayer().Active == 1 then
		if LocalPlayer().ALPHA1 < 255 then LocalPlayer().ALPHA1 = LocalPlayer().ALPHA1 + 0.05 end
	if !LocalPlayer():Alive() then
	LocalPlayer().Active = 0
	end
	end



	for i=1,35 do

	local Cos = math.cos(i/2) * LocalPlayer().ALPHA1*2
	local Sin = math.sin(i/2) * LocalPlayer().ALPHA1*2
	local Sinonius = math.cos(CurTime())* LocalPlayer().ALPHA1/15
	local Cosonius = math.sin(CurTime())* LocalPlayer().ALPHA1/15

		surface.SetDrawColor( 255, 255, 255, ( LocalPlayer().ALPHA1/2.1 )/(i/10) )
		surface.SetMaterial( mat_fb	) 
		surface.DrawTexturedRect( Cos-Cosonius, (Sin-Sinonius), ScrW(), ScrH() )
	end

		surface.SetDrawColor( math.sin(CurTime())*255, 255, -math.cos(CurTime())*255, ( LocalPlayer().ALPHA1/2 ) )
		surface.DrawRect( 0, 0, ScrW(), ScrH() )

		if LocalPlayer().ALPHA1 <= 0 then

				
			
		end
end

	end
end
end )




if LocalPlayer().Active == 0 or LocalPlayer().Active == nil then
LocalPlayer().Active = 1
LocalPlayer().ALPHA1 = 1
LocalPlayer().ALPHA2 = 1

timer.Simple(80,function()
LocalPlayer().Active = 0
end)
end
end)

netstream.Hook("meth",function(client)
    local mat_fb = Material( "pp/fb" )
local WMmat = Material( "Melon_screen" )
local a = 1




hook.Add( "RenderScreenspaceEffects", "DrugsREcts_savav_meth", function()
	if LocalPlayer().ALPHA1 != nil then 
if LocalPlayer().ALPHA1 <= 0 then
else
	if a == 1 then
 DrawTexturize( 0, Material( "meth_screen" ) )
end
end
	end

end )


local function MyCalcView( ply, pos, angles, fov )
	if LocalPlayer().ALPHA1 != nil then 
if LocalPlayer().ALPHA1 <= 0 then
else
	if a == 1 then
		local view = {}
		
		view.origin = pos-angles:Forward()*LocalPlayer().ALPHA1/6
		view.angles = angles+Angle(0,math.cos(CurTime())*LocalPlayer().ALPHA1/120,0)
		view.fov = fov - LocalPlayer().ALPHA1/7
		view.drawviewer = false

		return view
	end
end
	end
end

hook.Add( "CalcView", "CalcViewDrugsRect_savav_meth", MyCalcView )

hook.Add( "HUDPaint", "DrugsREct_savav_meth", function()

if LocalPlayer().ALPHA1 != nil then
if LocalPlayer().Active == 0 then
if LocalPlayer().ALPHA1 > 0 then LocalPlayer().ALPHA1 = LocalPlayer().ALPHA1 - 0.05 end
if LocalPlayer().ALPHA2 > 0 then LocalPlayer().ALPHA2 = LocalPlayer().ALPHA2 - 0.05 end
end

	if a == 1 then
	if LocalPlayer().Active == 1 then
		if LocalPlayer().ALPHA1 < 255 then LocalPlayer().ALPHA1 = LocalPlayer().ALPHA1 + 0.05 end
		
	for i=1,30 do

	local Cos = math.cos(i) * LocalPlayer().ALPHA1*2
	local Sin = math.sin(i) * LocalPlayer().ALPHA1*2
	local Sinonius = math.cos(CurTime())* LocalPlayer().ALPHA1/10
	local Cosonius = math.sin(CurTime())* LocalPlayer().ALPHA1/10

		surface.SetDrawColor( 255, 255, 255, ( LocalPlayer().ALPHA1/20 ))
		surface.SetMaterial( mat_fb	) 
		surface.DrawTexturedRect( Cos-Cosonius, (Sin-Sinonius), ScrW(), ScrH() )
	end

	
		surface.SetDrawColor( 255, 255, 255, ( 255-LocalPlayer().ALPHA1 ))
		surface.SetMaterial( mat_fb	) 
		surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		
	if !LocalPlayer():Alive() then
	LocalPlayer().Active = 0
	
	
	end
	end


		
		if LocalPlayer().ALPHA1 <= 0 then

			
		end

	end
end
end )




if LocalPlayer().Active == 0 or LocalPlayer().Active == nil then
LocalPlayer().Active = 1
LocalPlayer().ALPHA1 = 1
LocalPlayer().ALPHA2 = 1

timer.Simple(60,function()
LocalPlayer().Active = 0


end)
end

end)

netstream.Hook("cocaine",function(client)
    local mat_fb = Material( "pp/fb" )
local a = 1




hook.Add( "RenderScreenspaceEffects", "DrugsREcts_savav_cocaine", function()

	if LocalPlayer().ALPHA1 != nil then 
if LocalPlayer().ALPHA1 <= 0 then
else
	if a == 1 then
	DrawColorModify( 

{
	[ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = -LocalPlayer().ALPHA1/300,
	[ "$pp_colour_contrast" ] = 1+LocalPlayer().ALPHA1/200,
	[ "$pp_colour_colour" ] = 1+LocalPlayer().ALPHA1/150,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}

	)
end
end
	end

end )

local LERPANGL = Angle()

local function MyCalcView( ply, pos, angles, fov )
	if LocalPlayer().ALPHA1 != nil then 
if LocalPlayer().ALPHA1 <= 0 then
else
	if a == 1 then
		local view = {}
		
local blah = WorldToLocal( ply:GetVelocity(), Angle(0,0,0) , Vector(0,0,0), Angle(0,ply:EyeAngles().yaw,0) ) 
LERPANGL = LerpAngle(LocalPlayer().ALPHA1/258,angles,LERPANGL)
		view.origin = ( pos+ply:GetVelocity()/80 ) + angles:Forward()*LocalPlayer().ALPHA1/12
		view.angles = LERPANGL+Angle(((blah.x/4550)*LocalPlayer().ALPHA1),((blah.y/2550)*LocalPlayer().ALPHA1),((blah.y/2550)*LocalPlayer().ALPHA1)+math.cos(CurTime())*LocalPlayer().ALPHA1/10)
		view.fov = fov + LocalPlayer().ALPHA1/3.7
		view.drawviewer = false

		return view
	end
end
	end
end

hook.Add( "CalcView", "CalcViewDrugsRect_savav_cocaine", MyCalcView )

hook.Add( "HUDPaint", "DrugsREct_savav_cocaine", function()
if LocalPlayer().ALPHA1 != nil then
if LocalPlayer().Active == 0 then
if LocalPlayer().ALPHA1 > 0 then LocalPlayer().ALPHA1 = LocalPlayer().ALPHA1 - 0.05 end
if LocalPlayer().ALPHA2 > 0 then LocalPlayer().ALPHA2 = LocalPlayer().ALPHA2 - 0.05 end
end

if LocalPlayer().ALPHA1 != nil then
	if a == 1 then
	if LocalPlayer().Active == 1 then
		if LocalPlayer().ALPHA1 < 255 then LocalPlayer().ALPHA1 = LocalPlayer().ALPHA1 + 0.05 end
	if !LocalPlayer():Alive() then
	LocalPlayer().Active = 0
	end
	end
 
LocalPlayer():SetEyeAngles(LocalPlayer():EyeAngles()+Angle((math.cos(CurTime())/2550)*LocalPlayer().ALPHA1,(math.sin(CurTime()*2)/2550)*LocalPlayer().ALPHA1,0))

	for i=1,35 do

	local Cos = math.cos(i/2) * LocalPlayer().ALPHA1*2
	local Sin = math.sin(i/2) * LocalPlayer().ALPHA1
	local Sinonius = math.cos(CurTime())* LocalPlayer().ALPHA1/15
	local Cosonius = math.sin(CurTime())* LocalPlayer().ALPHA1/15

		surface.SetDrawColor( 255, 255, 255, ( LocalPlayer().ALPHA1/2.1 )/(i/10) )
		surface.SetMaterial( mat_fb	) 
		surface.DrawTexturedRect( Cos-Cosonius, (Sin-Sinonius), ScrW(), ScrH() )
	end

		surface.SetDrawColor(255, 0, 255, LocalPlayer().ALPHA1/30 )
		surface.DrawRect( 0, 0, ScrW(), ScrH() )

		if LocalPlayer().ALPHA1 <= 0 then
			
		end
end

	end
end
end )


if LocalPlayer().Active == 0 or LocalPlayer().Active == nil then
LocalPlayer().Active = 1
LocalPlayer().ALPHA1 = 1
LocalPlayer().ALPHA2 = 1
timer.Simple(110,function()
LocalPlayer().Active = 0
end)
end

end)

netstream.Hook("stimulators",function(client)
hook.Add("RenderScreenspaceEffects", "just_stimulators", function()
	DrawMotionBlur(0.03, 0.77, 0)
	LocalPlayer():SetDSP(6)
end)
timer.Simple(15, function()
	hook.Remove("RenderScreenspaceEffects", "just_stimulators")
	LocalPlayer():SetDSP(0)
end)
end)

end