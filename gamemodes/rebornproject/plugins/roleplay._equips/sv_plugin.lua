
local PLUGIN = PLUGIN

local ScaleDamage = {
	[DMG_BULLET] = 1, -- пули
	[DMG_SLASH] = 2, -- порезы
	[DMG_SHOCK] = 3, -- электро
	[DMG_BURN] = 4, --термо
	[DMG_RADIATION] = 5, -- радиация
	[DMG_ACID] = 6, -- кислота
	[DMG_BLAST] = 7, -- взрыв
	[DMG_FALL] = 8, -- падение



	-------- дальше все это пули, ибо некоторые базы тот же FA:S, Metro, TFA, используют разные индексы предположим (DMG_BULLET = 2, DMG_NEVERGIB = 4096, 2+4096=4098 - пуля от стандартного 9mm pistol из HL2)
    [4098] = 1,
	[8194] = 1,
}


local HER = {
	"armor",
	"head_balaclava",
	"helmet",
	"head_glasses",
	"legs",
	"armor",
}

function PLUGIN:GetDamageType(dmgtype)
	return ScaleDamage[dmgtype]
end

function PLUGIN:ScalePlayerDamage( ply, hitgroup, dmginfo )
	if ply:IsBot() then return end
	local tbl = {}

	for k,v in pairs(HER) do
		local inv = ply:ExtraInventory(v)
		if not inv then return end
		local invequiped = inv:GetEquipedItem()

		if (inv and invequiped and invequiped.HitGroupScaleDmg[hitgroup]) then
			tbl[#tbl+1] = invequiped
		end
	end


	local damage = 1

	for k,v in ipairs(tbl) do
		if v:GetData("wearcondition") == 0 then continue end

		local Type = PLUGIN:GetDamageType(dmginfo:GetDamageType())
        local protect = v.damage[Type]
        damage = damage * protect
	end

     dmginfo:ScaleDamage(damage)

end


function PLUGIN:PlayerHurt( ply, attacker, health, damageTaken )
	if ply:IsBot() then return end
	if (ply:IsPlayer()) then
		for k, v in pairs(HER) do
			local inv = ply:ExtraInventory(v)
			if not inv then return end
			local invequiped = inv:GetEquipedItem()

			if (inv and invequiped) then
				local wearc = invequiped:GetData("wearcondition")
				if (wearc > 0) then
					invequiped:SetData("wearcondition", wearc - (damageTaken/20))
				else
					invequiped:SetData("wearcondition", 0)
				end
			end

		end
	end
end
<<<<<<< HEAD
 
---gasmask breathe
-- local IsFirstTimePredicted = IsFirstTimePredicted

-- local SND = "metromod/breath_1.wav"
-- local SND_DUR = SoundDuration(SND)

-- В идеале остановку аудио при снятии мы должны делать не тут,
-- а в хуке каком либо от инвентаря, что мол айтем из слота убрали.
-- Пока закомментировано полностью.
-- function PLUGIN:PlayerTick(ply)
-- 	if not IsFirstTimePredicted() then return end
-- 	local inv = ply:ExtraInventory("head_gasmask")
-- 	if not inv then return end
-- 	local invequiped = inv:GetEquipedItem()
-- 	local ent_index  = ply:EntIndex()
-- 	if not invequiped then
-- 		if ply.IsBreathSoundPlaying then
-- 			ply:StopSound(SND)
-- 			ply.IsBreathSoundPlaying = false
-- 		end
-- 		return
-- 	end

--     if not ply.NextStaminaBreathe or ply.NextStaminaBreathe <= CurTime() then
-- 		ply:EmitSound(SND, 60)
-- 		ply.IsBreathSoundPlaying = true
-- 		timer.Simple(SND_DUR, function()
-- 			if ply:IsValid() and ply.IsBreathSoundPlaying then
-- 				ply:StopSound(SND)
-- 				ply.IsBreathSoundPlaying = false
=======


-- ---gasmask breathe
-- local SND = "player/breathe1.wav"
-- local SND_DUR = SoundDuration(SND)

-- function PLUGIN:PlayerTick(ply)
-- 	local inv = ply:ExtraInventory("head_gasmask")
-- 	if not inv then return end
-- 	local invequiped = inv:GetEquipedItem()
-- 	if not invequiped then
-- 		ply:StopSound(SND)
-- 		return
-- 	end

--     if not ply.NextStaminaBreathe or ply.NextStaminaBreathe <= CurTime() then
-- 		ply:EmitSound(SND, 60)
-- 		timer.Simple(SND_DUR, function()
-- 			if ( ply:IsValid() ) then
-- 				ply:StopSound(SND)
>>>>>>> 7d2579ddb0a32578a4df13e101539166191ddaa5
-- 			end
-- 		end)
-- 		ply.NextStaminaBreathe = CurTime() + SND_DUR
--     end
-- end
