local cl = 0
local cl_ = true


function PLUGIN:HUDPaint()
	local player = LocalPlayer()

	if player:GetCharacter() and player:Alive() and player:get_bleeding() != 0 then
		if cl_ then
			cl = cl + 1
		else
			cl = cl - 1
		end

		if cl >= 255 then
			cl_ = false
		elseif cl <= 80 then
			cl_ = true
		end

		local levels = {
			[1] = 'СЛАБОЕ',
			[2] = 'СРЕДНЕЕ',
			[3] = 'СИЛЬНОЕ'
		}

	--	draw.simple_text(('%s КРОВОТЕЧЕНИЕ'):format(levels[player:get_bleeding()]), 'DermaLarge', ScrW() / 2, math.scale(100), Color(cl, 0, 0), TEXT_ALIGN_CENTER)
	end
end

local next_effect = CurTime()

function PLUGIN:Think()
	if next_effect <= CurTime() then
		for k, v in pairs(player.GetAll()) do
			if v:get_bleeding() != 0 then
				local effect_data = EffectData()
					effect_data:SetOrigin(pos or (v:GetPos() + Vector(0,0,32)))
					effect_data:SetAngles(ang or Angle())
					effect_data:SetScale(1)
				util.Effect('BloodImpact', effect_data, true, true)
			end
		end

		next_effect = CurTime() + 3
	end
end
