-- <|> Hello, fucker | Taxin2012 and PURP was here | Mysterious Zone Project | mzrp.ru <|>
local PLUGIN = PLUGIN -- Переименование переменной a в PLUGIN
local SEQUENCE_NAMES = {[1] = "base_seq", [2] = "bandit_seq", [3] = "military_seq", [4] = "damage_seq", [5] = "zombified_seq"} -- Переименование переменной b в SEQUENCE_NAMES
local PLAYER_HOLDTYPE_TRANSLATOR = PLAYER_HOLDTYPE_TRANSLATOR -- Переименование переменной PLAYER_HOLDTYPE_TRANSLATOR
local HOLDTYPE_TRANSLATOR = HOLDTYPE_TRANSLATOR -- Переименование переменной HOLDTYPE_TRANSLATOR
local OFFSET_VECTOR = Vector(3, 0, -21) -- Переименование переменной c в OFFSET_VECTOR

hook.Add("TranslateActivity", "modelsAnimations.TranslateActivity", function(player, act)
    local playerTable = player:GetTable()
    local weaponRaised = player:IsWepRaised()
    local currentSequence = "base_seq"

    local animModelClass = playerTable.ixAnimModelClass or "player"
    local characterMovement = player:GetNetVar("movementSequence", 1)
    currentSequence = SEQUENCE_NAMES[characterMovement] or "base_seq"

    local animTable = playerTable.ixAnimTable

    if animTable then
        local activeWeapon, currentTime = player:GetActiveWeapon(), CurTime()
        local holdType = (activeWeapon.HoldType or (activeWeapon.GetHoldType and activeWeapon:GetHoldType())) or "normal"
        holdType = PLAYER_HOLDTYPE_TRANSLATOR[holdType] or "passive"

        local animInfo, glideInfo, inVehicle, onGround, result = ix.anim.player[holdType], animTable["glide"], player:InVehicle(), player:OnGround(), nil

        if inVehicle then
            local vehicle = player:GetVehicle()
            if vehicle:IsValidVehicle() and vehicle:GetClass() ~= "prop_vehicle_prisoner_pod" then
                OFFSET_VECTOR = Vector(15, 0, -15)
            end
            player:SetLocalPos(OFFSET_VECTOR)
            playerTable.CalcSeqOverride = player:LookupSequence("animpoint_sit_normal_drink_idle_1")
        elseif onGround and animTable[act] then
            currentSequence = animTable[act][currentSequence] and currentSequence or "base_seq"
            if (activeWeapon.GetIronSights and activeWeapon:GetIronSights()) or (activeWeapon.GetStatus and activeWeapon:GetStatus() == TFA.Enum.STATUS_GRENADE_READY) then
                result = animTable[act][currentSequence][3] or animTable[act]["base_seq"][3]
            else
                result = animTable[act][currentSequence][weaponRaised and 2 or 1] or animTable[act]["base_seq"][weaponRaised and 2 or 1] or 0 -- 0 для дебагга, посмотрим че выйдет.
            end
            if isstring(result) then
                playerTable.CalcSeqOverride = player:LookupSequence(result)
            elseif istable(result) then
                playerTable.CalcSeqOverride = player:LookupSequence(result[1])
            else
                return result
            end
        elseif inVehicle then
            currentSequence = glideInfo[currentSequence] and currentSequence or "base_seq"
            if (activeWeapon.GetIronSights and activeWeapon:GetIronSights()) or (activeWeapon.GetStatus and activeWeapon:GetStatus() == TFA.Enum.STATUS_GRENADE_READY) then
                result = glideInfo[currentSequence][3] or glideInfo["base_seq"][3]
            elseif istable(result) then
                result = table.Random(result)
            else
                result = glideInfo[currentSequence][weaponRaised and 2 or 1] or glideInfo["base_seq"][weaponRaised and 2 or 1]
            end
            if result and player:LookupSequence(result) ~= -1 then
                playerTable.CalcSeqOverride = player:LookupSequence(result)
            end
        end
    end
end)
hook.Add("DoAnimationEvent", "modelsAnimations.DoAnimationEvent", function(player, event, data)
    local animModelClass = player.ixAnimModelClass
    local activeWeapon = player:GetActiveWeapon()
    local isMoving = player:GetVelocity():Length2D() >= 0.5

    if IsValid(activeWeapon) then
        local isTFAWeapon = activeWeapon.IsTFAWeapon and activeWeapon:GetIronSights()
        local animTable = player.ixAnimTable

        if not animTable then
            return
        end

        local gestureAnimations = animTable["gesture_animations"]

        if gestureAnimations and gestureAnimations.base_seq then
            local sequence = gestureAnimations.base_seq
            local character = player:GetCharacter()

            if character then
                local movementSequence = character:GetData("movement_sequence", 1)
                sequence = gestureAnimations[movementSequence] or gestureAnimations.base_seq
            end

            local isCrouching = player:Crouching()

            if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
                if isTFAWeapon then
                    if isCrouching then
                        if sequence.cr_aim_attack then
                            player:AddVCDSequenceToGestureSlot(
                                GESTURE_SLOT_ATTACK_AND_RELOAD,
                                player:LookupSequence(sequence.cr_aim_attack),
                                0,
                                true
                            )
                        end
                    else
                        if sequence.aim_attack then
                            player:AddVCDSequenceToGestureSlot(
                                GESTURE_SLOT_ATTACK_AND_RELOAD,
                                player:LookupSequence(sequence.aim_attack),
                                0,
                                true
                            )
                        end
                    end
                else
                    if isCrouching then
                        if isMoving then
                            if sequence.cr_walk_attack then
                                player:AddVCDSequenceToGestureSlot(
                                    GESTURE_SLOT_ATTACK_AND_RELOAD,
                                    player:LookupSequence(sequence.cr_walk_attack),
                                    0,
                                    true
                                )
                            end
                        else
                            if sequence.cr_attack then
                                player:AddVCDSequenceToGestureSlot(
                                    GESTURE_SLOT_ATTACK_AND_RELOAD,
                                    player:LookupSequence(sequence.cr_attack),
                                    0,
                                    true
                                )
                            end
                        end
                    else
                        if isMoving then
                            if sequence.walk_attack then
                                player:AddVCDSequenceToGestureSlot(
                                    GESTURE_SLOT_ATTACK_AND_RELOAD,
                                    player:LookupSequence(sequence.walk_attack),
                                    0,
                                    true
                                )
                            end
                        elseif player:IsRunning() then
                            if sequence.run_attack then
                                player:AddVCDSequenceToGestureSlot(
                                    GESTURE_SLOT_ATTACK_AND_RELOAD,
                                    player:LookupSequence(sequence.run_attack),
                                    0,
                                    true
                                )
                            end
                        else
                            if sequence.attack then
                                player:AddVCDSequenceToGestureSlot(
                                    GESTURE_SLOT_ATTACK_AND_RELOAD,
                                    player:LookupSequence(sequence.attack),
                                    0,
                                    true
                                )
                            end
                        end
                    end
                end
                return ACT_VM_PRIMARYATTACK
            elseif event == PLAYERANIMEVENT_ATTACK_SECONDARY then
                if isTFAWeapon then
                    if isCrouching then
                        if sequence.cr_aim_attack then
                            player:AddVCDSequenceToGestureSlot(
                                GESTURE_SLOT_ATTACK_AND_RELOAD,
                                player:LookupSequence(sequence.cr_aim_attack),
                                0,
                                true
                            )
                        end
                    else
                        if sequence.aim_attack then
                            player:AddVCDSequenceToGestureSlot(
                                GESTURE_SLOT_ATTACK_AND_RELOAD,
                                player:LookupSequence(sequence.shoot_aim),
                                0,
                                true
                            )
                        end
                    end
                else
                    if isCrouching then
                        if isMoving then
                            if sequence.cr_walk_attack then
                                player:AddVCDSequenceToGestureSlot(
                                    GESTURE_SLOT_ATTACK_AND_RELOAD,
                                    player:LookupSequence(sequence.cr_walk_attack),
                                    0,
                                    true
                                )
                            end
                        else
                            if sequence.cr_attack then
                                player:AddVCDSequenceToGestureSlot(
                                    GESTURE_SLOT_ATTACK_AND_RELOAD,
                                    player:LookupSequence(sequence.cr_attack),
                                    0,
                                    true
                                )
                            end
                        end
                    else
                        if isMoving then
                            if sequence.walk_attack then
                                player:AddVCDSequenceToGestureSlot(
                                    GESTURE_SLOT_ATTACK_AND_RELOAD,
                                    player:LookupSequence(sequence.walk_attack),
                                    0,
                                    true
                                )
                            end
                        elseif player:IsRunning() then
                            if sequence.run_attack then
                                player:AddVCDSequenceToGestureSlot(
                                    GESTURE_SLOT_ATTACK_AND_RELOAD,
                                    player:LookupSequence(sequence.run_attack),
                                    0,
                                    true
                                )
                            end
                        else
                            if sequence.attack then
                                player:AddVCDSequenceToGestureSlot(
                                    GESTURE_SLOT_ATTACK_AND_RELOAD,
                                    player:LookupSequence(sequence.attack),
                                    0,
                                    true
                                )
                            end
                        end
                    end
                end
                return ACT_VM_SECONDARYATTACK
            elseif event == PLAYERANIMEVENT_RELOAD then
                if isCrouching then
                    if sequence.cr_reload then
                        player:AddVCDSequenceToGestureSlot(
                            GESTURE_SLOT_ATTACK_AND_RELOAD,
                            player:LookupSequence(sequence.cr_reload),
                            0,
                            true
                        )
                    end
                else
                    if sequence.reload then
                        player:AddVCDSequenceToGestureSlot(
                            GESTURE_SLOT_ATTACK_AND_RELOAD,
                            player:LookupSequence(sequence.reload),
                            0,
                            true
                        )
                    end
                end
                return ACT_INVALID
            elseif event == PLAYERANIMEVENT_JUMP then
                player:AnimRestartMainSequence()
                return ACT_INVALID
            elseif event == PLAYERANIMEVENT_CANCEL_RELOAD then
                player:AnimResetGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD)
                return ACT_INVALID
            end
        end
    end
end)
do
    local VectorMetaTableAngle = FindMetaTable("Vector").Angle
    local NormalizeAngle = math.NormalizeAngle

    hook.Add("CalcMainActivity", "modelsAnimations.CalcMainActivity", function(player, velocity)
        local playerTable = player:GetTable()
        local forcedSequence = player:GetNetVar("forcedSequence")

        if forcedSequence then
            if player:GetSequence() ~= forcedSequence then
                player:SetCycle(0)
            end
            return -1, forcedSequence
        end

        local yawDifference = VectorMetaTableAngle(velocity)[2] - player:EyeAngles()[2]
        player:SetPoseParameter("move_yaw", NormalizeAngle(yawDifference))

        local playerTableOverride = playerTable.CalcSeqOverride
        playerTable.CalcSeqOverride = -1
        playerTable.CalcIdeal = ACT_MP_STAND_IDLE

        local gamemodeBaseClass = GAMEMODE.BaseClass

        if not (gamemodeBaseClass:HandlePlayerNoClipping(player, velocity) or
                gamemodeBaseClass:HandlePlayerDriving(player) or
                gamemodeBaseClass:HandlePlayerVaulting(player, velocity) or
                gamemodeBaseClass:HandlePlayerJumping(player, velocity) or
                gamemodeBaseClass:HandlePlayerSwimming(player, velocity) or
                gamemodeBaseClass:HandlePlayerDucking(player, velocity)) then
            local squaredLength = velocity:Length2DSqr()

            if squaredLength > 10000 then
                playerTable.CalcIdeal = ACT_MP_RUN
            elseif squaredLength > 0.25 then
                playerTable.CalcIdeal = ACT_MP_WALK
            end
        end

        playerTable.m_bWasOnGround = player:OnGround()
        playerTable.m_bWasNoclipping = (player:GetMoveType() == MOVETYPE_NOCLIP and not player:InVehicle())

        return playerTable.CalcIdeal, playerTableOverride or playerTable.CalcSeqOverride or -1
    end)
end

