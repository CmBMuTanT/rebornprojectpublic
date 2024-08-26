AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = { "models/devcon/mrp/act/stalker.mdl" } -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 100000000000000
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
ENT.HasSetSolid = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_Ghost"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodParticle = {""} -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = {""} -- Leave blank for none | Commonly used: Red = Blood, Yellow Blood = YellowBlood
ENT.BloodPoolSize = "" -- What's the size of the blood pool?
ENT.MovementType = VJ_MOVETYPE_STATIONARY  -- How does the SNPC move?
ENT.CanTurnWhileStationary = false -- If set to true, the SNPC will be able to turn while it's a stationary SNPC
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 20 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 100 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.1 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.1 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random( 400,800 )
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttackTime = 3 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = true -- Should the player bleed when attacked by melee
ENT.MeleeAttackBleedEnemyChance = 1 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1

function ENT:CustomOnThink_AIEnabled()
if (self:GetEnemy() and self:GetEnemy() != nil) then
    if (self:GetPos( ):Distance( self:GetEnemy():GetPos( ) ) > 350 ) then
		self:SetRenderMode(RENDERMODE_TRANSCOLOR)
		self:SetColor(Color(0,0,0,0))
    elseif (self:GetPos( ):Distance( self:GetEnemy():GetPos( ) ) < 100 ) then
		self:SetRenderMode(RENDERMODE_TRANSCOLOR)
		self:SetColor(Color(0,0,0,0))
	end
 end
end

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {"metro_urfim/ghost_prayer_2_man.wav"}