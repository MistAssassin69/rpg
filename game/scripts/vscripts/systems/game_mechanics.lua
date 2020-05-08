if (IsServer()) then
    ---@param handler function
    function GameMode:RegisterCritDamageEventHandler(handler)
        if (handler == nil) then
            DebugPrint("[GAME MECHANICS] Someone passed nil to RegisterCritDamageEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        if (type(handler) ~= "function") then
            DebugPrint("[GAME MECHANICS] Someone passed " .. tostring(handler) .. " instead of function to RegisterCritDamageEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        table.insert(GameMode.CritDamageEventHandlersTable, handler)
    end

    ---@param handler function
    function GameMode:RegisterPreDamageEventHandler(handler)
        if (handler == nil) then
            DebugPrint("[GAME MECHANICS] Someone passed nil to RegisterPreDamageEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        if (type(handler) ~= "function") then
            DebugPrint("[GAME MECHANICS] Someone passed " .. tostring(handler) .. " instead of function to RegisterPreDamageEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        table.insert(GameMode.PreDamageEventHandlersTable, handler)
    end

    ---@param handler function
    function GameMode:RegisterPostDamageEventHandler(handler)
        if (handler == nil) then
            DebugPrint("[GAME MECHANICS] Someone passed nil to RegisterPostDamageEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        if (type(handler) ~= "function") then
            DebugPrint("[GAME MECHANICS] Someone passed " .. tostring(handler) .. " instead of function to RegisterPostDamageEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        table.insert(GameMode.PostDamageEventHandlersTable, handler)
    end

    ---@param handler function
    function GameMode:RegisterPostApplyModifierEventHandler(handler)
        if (handler == nil) then
            DebugPrint("[GAME MECHANICS] Someone passed nil to RegisterPostApplyModifierEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        if (type(handler) ~= "function") then
            DebugPrint("[GAME MECHANICS] Someone passed " .. tostring(handler) .. " instead of function to RegisterPostApplyModifierEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        table.insert(GameMode.PostApplyModifierEventHandlersTable, handler)
    end

    ---@param handler function
    function GameMode:RegisterPreHealEventHandler(handler)
        if (handler == nil) then
            DebugPrint("[GAME MECHANICS] Someone passed nil to RegisterPreHealEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        if (type(handler) ~= "function") then
            DebugPrint("[GAME MECHANICS] Someone passed " .. tostring(handler) .. " instead of function to RegisterPreHealEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        table.insert(GameMode.PreHealEventHandlersTable, handler)
    end

    ---@param handler function
    function GameMode:RegisterPostHealEventHandler(handler)
        if (handler == nil) then
            DebugPrint("[GAME MECHANICS] Someone passed nil to RegisterPostHealEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        if (type(handler) ~= "function") then
            DebugPrint("[GAME MECHANICS] Someone passed " .. tostring(handler) .. " instead of function to RegisterPostHealEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        table.insert(GameMode.PostHealEventHandlersTable, handler)
    end

    ---@param handler function
    function GameMode:RegisterCritHealEventHandler(handler)
        if (handler == nil) then
            DebugPrint("[GAME MECHANICS] Someone passed nil to RegisterCritHealEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        if (type(handler) ~= "function") then
            DebugPrint("[GAME MECHANICS] Someone passed " .. tostring(handler) .. " instead of function to RegisterCritHealEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        table.insert(GameMode.CritHealEventHandlersTable, handler)
    end

    ---@param handler function
    function GameMode:RegisterPreHealManaEventHandler(handler)
        if (handler == nil) then
            DebugPrint("[GAME MECHANICS] Someone passed nil to RegisterPreHealManaEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        if (type(handler) ~= "function") then
            DebugPrint("[GAME MECHANICS] Someone passed " .. tostring(handler) .. " instead of function to RegisterPreHealManaEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        table.insert(GameMode.PreHealManaEventHandlersTable, handler)
    end

    ---@param handler function
    function GameMode:RegisterPostHealManaEventHandler(handler)
        if (handler == nil) then
            DebugPrint("[GAME MECHANICS] Someone passed nil to RegisterPostHealManaEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        if (type(handler) ~= "function") then
            DebugPrint("[GAME MECHANICS] Someone passed " .. tostring(handler) .. " instead of function to RegisterPostHealManaEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        table.insert(GameMode.PostHealManaEventHandlersTable, handler)
    end

    ---@param handler function
    function GameMode:RegisterCritHealManaEventHandler(handler)
        if (handler == nil) then
            DebugPrint("[GAME MECHANICS] Someone passed nil to RegisterCritHealManaEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        if (type(handler) ~= "function") then
            DebugPrint("[GAME MECHANICS] Someone passed " .. tostring(handler) .. " instead of function to RegisterCritHealManaEventHandler()")
            DebugPrint("[GAME MECHANICS] Source of that shit:")
            DebugPrintTable(debug.getinfo(2))
            return
        end
        table.insert(GameMode.CritHealManaEventHandlersTable, handler)
    end

    --- handle every dmg instance in game. true = allow damage event, false = cancel damage event (damage itself, numbers still showed on client side)
    function GameMode:DamageFilter(args)
        if not IsServer() then
            return false
        end
        local attacker
        local victim
        if args.entindex_attacker_const and args.entindex_victim_const then
            attacker = EntIndexToHScript(args.entindex_attacker_const)
            victim = EntIndexToHScript(args.entindex_victim_const)
        else
            -- some weird shit happened, cancel that
            return false
        end
        if (args.damagetype_const ~= DAMAGE_TYPE_PURE) then
            -- creep aa or hero aa or another weird shit, cancel that
            -- creeps & heroes deal aa dmg via corresponding modifier
            return false
        end
        -- another weird shit happened, ignore that
        if not attacker or not victim then
            return false
        end
        --[[local ability
        if args.entindex_inflictor_const then
            ability = EntIndexToHScript(args.entindex_inflictor_const)
        end --]]
        return true
    end

    ---@class MODIFIER_TABLE
    ---@field public caster CDOTA_BaseNPC
    ---@field public target CDOTA_BaseNPC
    ---@field public ability CDOTA_Ability_Lua
    ---@field public modifier_name string
    ---@field public modifier_params table
    ---@field public duration number

    ---@class STACKING_MODIFIER_TABLE
    ---@field public caster CDOTA_BaseNPC
    ---@field public target CDOTA_BaseNPC
    ---@field public ability CDOTA_Ability_Lua
    ---@field public modifier_name string
    ---@field public modifier_params table
    ---@field public duration number
    ---@field public stacks number
    ---@field public max_stacks number
    ---
    --- Apply (or refresh if exists) buff
    ---@param args MODIFIER_TABLE
    ---@param fireEvent boolean
    ---@return CDOTA_Modifier_Lua
    function GameMode:ApplyBuff(args, fireEvent)
        if (args ~= nil) then
            args.duration = tonumber(args.duration)
            if (args.caster ~= nil and args.target ~= nil and args.modifier_name ~= nil and args.duration ~= nil) then
                local modifierParams = args.modifier_params or {}
                if (args.duration > 0) then
                    args.duration = args.duration * Units:GetBuffAmplification(args.caster)
                end
                modifierParams.Duration = args.duration
                local modifier = args.target:AddNewModifier(args.caster, args.ability, args.modifier_name, modifierParams)
                if (fireEvent == nil) then
                    fireEvent = true
                end
                if (modifier ~= nil) then
                    GameMode:ChangeModifier(modifier)
                    if (fireEvent == true) then
                        args.stacks = 0
                        args.max_stacks = 0
                        for i = 1, #GameMode.PostApplyModifierEventHandlersTable do
                            GameMode.PostApplyModifierEventHandlersTable[i](modifier, args)
                        end
                    end
                end
                return modifier
            end
        end
        return nil
    end

    --- Apply (or refresh if exists) buff + increase his stacks count by args.stacks up to args.max_stacks
    ---@param args STACKING_MODIFIER_TABLE
    ---@return CDOTA_Modifier_Lua
    function GameMode:ApplyStackingBuff(args)
        if (args ~= nil and args.stacks ~= nil and args.max_stacks ~= nil and args.stacks > 0 and args.max_stacks > 0) then
            local modifier = GameMode:ApplyBuff(args, false)
            if (modifier ~= nil) then
                local stacks = modifier:GetStackCount() + args.stacks
                modifier:SetStackCount(math.min(stacks, args.max_stacks))
                for i = 1, #GameMode.PostApplyModifierEventHandlersTable do
                    GameMode.PostApplyModifierEventHandlersTable[i](modifier, args)
                end
                return modifier
            end
        end
        return nil
    end

    --- Apply (or refresh if exists) debuff
    ---@param args MODIFIER_TABLE
    ---@param fireEvent boolean
    ---@return CDOTA_Modifier_Lua
    function GameMode:ApplyDebuff(args, fireEvent)
        if (args ~= nil) then
            args.duration = tonumber(args.duration)
            if (args.caster ~= nil and args.target ~= nil and args.modifier_name ~= nil and args.duration ~= nil) then
                local modifierParams = args.modifier_params or {}
                if (args.duration > 0) then
                    args.duration = args.duration * Units:GetDebuffAmplification(args.caster) * Units:GetDebuffResistance(args.target)
                end
                modifierParams.Duration = args.duration
                local isTargetCasting = false
                local abilitiesCount = args.target:GetAbilityCount() - 1
                local ability = nil
                for i = 0, abilitiesCount do
                    ability = args.target:GetAbilityByIndex(i)
                    if (ability and ability:IsInAbilityPhase()) then
                        isTargetCasting = true
                        break
                    end
                end
                if (isTargetCasting == true) then
                    local isModifierWillPreventCasting = false
                    local crowdControlModifier = GameMode.CrowdControlModifiersTable[args.modifier_name]
                    if (crowdControlModifier) then
                        isModifierWillPreventCasting = (crowdControlModifier.stun == true) or (crowdControlModifier.silence == true) or (crowdControlModifier.hex == true)
                    else
                        if (args.modifier_name == "modifier_stunned" or args.modifier_name == "modifier_silence") then
                            isModifierWillPreventCasting = true
                        end
                    end
                    if (isModifierWillPreventCasting == true and ability.IsInterruptible and ability:IsInterruptible() == false) then
                        return nil
                    end
                end
                local modifier = args.target:AddNewModifier(args.caster, args.ability, args.modifier_name, modifierParams)
                if (fireEvent == nil) then
                    fireEvent = true
                end
                if (modifier ~= nil) then
                    GameMode:ChangeModifier(modifier)
                    if (fireEvent == true) then
                        args.stacks = 0
                        args.max_stacks = 0
                        for i = 1, #GameMode.PostApplyModifierEventHandlersTable do
                            GameMode.PostApplyModifierEventHandlersTable[i](modifier, args)
                        end
                    end
                end
                return modifier
            end
        end
        return nil
    end

    --- Apply (or refresh if exists) debuff + increase his stacks count by args.stacks up to args.max_stacks
    ---@param args STACKING_MODIFIER_TABLE
    ---@return CDOTA_Modifier_Lua
    function GameMode:ApplyStackingDebuff(args)
        if (args ~= nil and args.stacks ~= nil and args.max_stacks ~= nil and args.stacks > 0 and args.max_stacks > 0) then
            local modifier = GameMode:ApplyDebuff(args, false)
            if (modifier ~= nil) then
                local stacks = modifier:GetStackCount() + args.stacks
                modifier:SetStackCount(math.min(stacks, args.max_stacks))
                for i = 1, #GameMode.PostApplyModifierEventHandlersTable do
                    GameMode.PostApplyModifierEventHandlersTable[i](modifier, args)
                end
                return modifier
            end
        end
        return nil
    end

    ---@class REDUCE_ABILITY_CD_TABLE
    ---@field public target CDOTA_BaseNPC
    ---@field public ability CDOTA_Ability_Lua
    ---@field public reduction number
    ---@field public isflat boolean

    --- Reduce any ability cooldown by args.reduction. If args.isflat = true then cooldown = cooldown - reduction else cooldown = cooldown * reduction
    ---@param args REDUCE_ABILITY_CD_TABLE
    function GameMode:ReduceAbilityCooldown(args)
        local target = args.target
        local ability = args.ability
        local reduction = args.reduction
        if (not reduction) then
            if (args.isflat) then
                reduction = 0
            else
                reduction = 1
            end
        end
        if (target ~= nil and ability ~= nil) then
            ability = target:FindAbilityByName(ability)
            if (ability ~= nil) then
                local abilityLevel = ability:GetLevel()
                if (abilityLevel > 0) then
                    local reducedCooldown = ability:GetCooldownTimeRemaining()
                    if (args.isflat) then
                        reducedCooldown = math.max(0, reducedCooldown - reduction)
                    else
                        reducedCooldown = reducedCooldown * reduction
                        local minCooldown = ability:GetCooldown(abilityLevel) * 0.5
                        if (reducedCooldown < minCooldown) then
                            reducedCooldown = minCooldown
                        end
                    end
                    if (reducedCooldown == 0) then
                        return
                    end
                    ability:EndCooldown()
                    ability:StartCooldown(reducedCooldown)
                end
            end
        end
    end

    ---@class DAMAGE_TABLE
    ---@field public caster CDOTA_BaseNPC
    ---@field public target CDOTA_BaseNPC
    ---@field public damage number
    ---@field public ability CDOTA_Ability_Lua
    ---@field public physdmg boolean
    ---@field public puredmg boolean
    ---@field public firedmg boolean
    ---@field public frostdmg boolean
    ---@field public earthdmg boolean
    ---@field public naturedmg boolean
    ---@field public voiddmg boolean
    ---@field public infernodmg boolean
    ---@field public holydmg boolean
    ---@field public fromsummon boolean

    ---@param args DAMAGE_TABLE
    function GameMode:DamageUnit(args)
        if (args == nil) then
            return
        end
        local caster = args.caster
        local target = args.target
        local damage = tonumber(args.damage)
        if (caster == nil or target == nil or damage == nil) then
            return
        end
        local ability = args.ability
        -- perform all reductions/amplifications, should work fine unless unit recieved really hard mixed dmg instance with all types and have every block like 99%
        local totalReduction = 1
        local totalBlock = 0
        if (not args.puredmg) then
            local instanceHasPhysDmg = args.physdmg
            local instanceHasSpellDmg = false
            if (instanceHasPhysDmg) then
                -- armor formula gl hf, 999999999 armor = 100% phys resistance, 2000 armor = 99,1% phys resistance
                local targetArmor = Units:GetArmor(target)
                local physReduction = (targetArmor * 0.06) / (1 + targetArmor * 0.06)
                totalReduction = totalReduction * (1 - physReduction)
            end
            if (args.firedmg) then
                totalReduction = totalReduction * Units:GetFireProtection(target)
                instanceHasSpellDmg = true
            end
            if (args.frostdmg) then
                totalReduction = totalReduction * Units:GetFrostProtection(target)
                instanceHasSpellDmg = true
            end
            if (args.earthdmg) then
                totalReduction = totalReduction * Units:GetEarthProtection(target)
                instanceHasSpellDmg = true
            end
            if (args.naturedmg) then
                totalReduction = totalReduction * Units:GetNatureProtection(target)
                instanceHasSpellDmg = true
            end
            if (args.voiddmg) then
                totalReduction = totalReduction * Units:GetVoidProtection(target)
                instanceHasSpellDmg = true
            end
            if (args.infernodmg) then
                totalReduction = totalReduction * Units:GetInfernoProtection(target)
                instanceHasSpellDmg = true
            end
            if (args.holydmg) then
                totalReduction = totalReduction * Units:GetHolyProtection(target)
                instanceHasSpellDmg = true
            end
            -- post reduction effects
            if (instanceHasPhysDmg) then
                totalBlock = totalBlock + Units:GetBlock(target)
            end
            if (instanceHasSpellDmg) then
                totalBlock = totalBlock + Units:GetMagicBlock(target)
            end
        end
        if (args.firedmg) then
            totalReduction = totalReduction * Units:GetFireDamage(caster)
        end
        if (args.frostdmg) then
            totalReduction = totalReduction * Units:GetFrostDamage(caster)
        end
        if (args.earthdmg) then
            totalReduction = totalReduction * Units:GetEarthDamage(caster)
        end
        if (args.naturedmg) then
            totalReduction = totalReduction * Units:GetNatureDamage(caster)
        end
        if (args.voiddmg) then
            totalReduction = totalReduction * Units:GetVoidDamage(caster)
        end
        if (args.infernodmg) then
            totalReduction = totalReduction * Units:GetInfernoDamage(caster)
        end
        if (args.holydmg) then
            totalReduction = totalReduction * Units:GetHolyDamage(caster)
        end
        -- Damage reduction reduce even pure dmg
        totalReduction = totalReduction * Units:GetDamageReduction(target)
        if (ability ~= nil) then
            damage = damage * (1 + Units:GetSpellDamage(caster))
        end
        -- well, let them suffer
        if (totalReduction < 0.01) then
            totalReduction = 0.01
        end
        -- final damage
        damage = (damage * totalReduction) - totalBlock
        -- dont trigger pre/post damage event if damage = 0 and dont apply "0" damage instances
        if (damage > 0) then
            local damageTable = {
                victim = target,
                attacker = caster,
                damage = damage,
                damage_type = DAMAGE_TYPE_PURE,
                ability = ability,
                physdmg = args.physdmg,
                firedmg = args.firedmg,
                frostdmg = args.frostdmg,
                earthdmg = args.earthdmg,
                naturedmg = args.naturedmg,
                voiddmg = args.voiddmg,
                infernodmg = args.infernodmg,
                holydmg = args.holydmg,
                puredmg = args.puredmg,
                fromsummon = args.fromsummon,
                crit = 1.0
            }
            -- trigger pre/post dmg event for all skills/etc
            local preDamageHandlerResultTable
            local damageCanceled = false
            for i = 1, #GameMode.PreDamageEventHandlersTable do
                if (not damageTable.victim or damageTable.victim:IsNull() or not damageTable.victim:IsAlive() or not damageTable.attacker or damageTable.attacker:IsNull() or not damageTable.attacker:IsAlive()) then
                    break
                end
                preDamageHandlerResultTable = GameMode.PreDamageEventHandlersTable[i](nil, damageTable)
                if (preDamageHandlerResultTable ~= nil) then
                    if (not damageCanceled) then
                        damageCanceled = (preDamageHandlerResultTable.damage <= 0)
                    end
                    local latestCrit = damageTable.crit
                    damageTable = preDamageHandlerResultTable
                    if (latestCrit > damageTable.crit) then
                        damageTable.crit = latestCrit
                    end
                end
            end
            if (not damageCanceled) then
                if (damageTable.crit > 1.0) then
                    damageTable.damage = damageTable.damage * damageTable.crit * Units:GetCriticalDamage(damageTable.attacker)
                    for i = 1, #GameMode.CritDamageEventHandlersTable do
                        if (not damageTable.victim or damageTable.victim:IsNull() or not damageTable.victim:IsAlive() or not damageTable.attacker or damageTable.attacker:IsNull() or not damageTable.attacker:IsAlive()) then
                            break
                        end
                        GameMode.CritDamageEventHandlersTable[i](nil, damageTable)
                    end
                    PopupCriticalDamage(target, damageTable.damage)
                end
                ApplyDamage(damageTable)
                for i = 1, #GameMode.PostDamageEventHandlersTable do
                    if (not damageTable.victim or damageTable.victim:IsNull() or not damageTable.victim:IsAlive() or not damageTable.attacker or damageTable.attacker:IsNull() or not damageTable.attacker:IsAlive()) then
                        break
                    end
                    GameMode.PostDamageEventHandlersTable[i](nil, damageTable)
                end
            end
        end
    end

    ---@class HEAL_TABLE
    ---@field public caster CDOTA_BaseNPC
    ---@field public target CDOTA_BaseNPC
    ---@field public ability CDOTA_Ability_DataDriven
    ---@field public heal number
    ---@param args HEAL_TABLE
    function GameMode:HealUnit(args)
        if (args == null) then
            return
        end
        args.heal = tonumber(args.heal)
        if (args.caster == nil or args.target == nil or args.heal == nil) then
            return
        end
        args.heal = (args.heal + Units:GetHealingCaused(args.caster) + Units:GetHealingReceived(args.target)) * Units:GetHealingCausedPercent(args.caster) * Units:GetHealingReceivedPercent(args.target)
        args.crit = 1.0
        local preHealHandlerResultTable
        local healCanceled = false
        for i = 1, #GameMode.PreHealEventHandlersTable do
            if (not args.caster or args.caster:IsNull() or not args.caster:IsAlive() or not args.target or args.target:IsNull() or not args.target:IsAlive()) then
                break
            end
            preHealHandlerResultTable = GameMode.PreHealEventHandlersTable[i](nil, args)
            if (preHealHandlerResultTable ~= nil) then
                local latestCrit = args.crit
                args = preHealHandlerResultTable
                if (latestCrit > args.crit) then
                    args.crit = latestCrit
                end
            end
        end
        healCanceled = (args.heal < 1)
        if (not healCanceled) then
            if (args.crit > 1.0) then
                args.heal = args.heal * args.crit
                for i = 1, #GameMode.CritHealEventHandlersTable do
                    if (not args.caster or args.caster:IsNull() or not args.caster:IsAlive() or not args.target or args.target:IsNull() or not args.target:IsAlive()) then
                        break
                    end
                    GameMode.CritHealEventHandlersTable[i](nil, args)
                end
            end
            args.target:Heal(args.heal, caster)
            PopupHealing(args.target, args.heal)
            for i = 1, #GameMode.PostHealEventHandlersTable do
                if (not args.caster or args.caster:IsNull() or not args.caster:IsAlive() or not args.target or args.target:IsNull() or not args.target:IsAlive()) then
                    break
                end
                GameMode.PostHealEventHandlersTable[i](nil, args)
            end
        end
    end

    ---@class HEAL_MANA_TABLE
    ---@field public caster CDOTA_BaseNPC
    ---@field public target CDOTA_BaseNPC
    ---@field public ability CDOTA_Ability_DataDriven
    ---@field public heal number
    ---@param args HEAL_MANA_TABLE
    function GameMode:HealUnitMana(args)
        if (args == null) then
            return
        end
        args.heal = tonumber(args.heal)
        if (args.caster == nil or args.target == nil or args.heal == nil) then
            return
        end
        args.crit = 1.0
        args.heal = (args.heal + Units:GetHealingCaused(args.caster) + Units:GetHealingReceived(args.target)) * Units:GetHealingCausedPercent(args.caster) * Units:GetHealingReceivedPercent(args.target)
        local preHealHandlerResultTable
        local healCanceled = false
        for i = 1, #GameMode.PreHealManaEventHandlersTable do
            if (not args.caster or args.caster:IsNull() or not args.caster:IsAlive() or not args.target or args.target:IsNull() or not args.target:IsAlive()) then
                break
            end
            preHealHandlerResultTable = GameMode.PreHealManaEventHandlersTable[i](nil, args)
            if (preHealHandlerResultTable ~= nil) then
                local latestCrit = args.crit
                args = preHealHandlerResultTable
                if (latestCrit > args.crit) then
                    args.crit = latestCrit
                end
            end
        end
        healCanceled = (args.heal < 1)
        if (not healCanceled) then
            if (args.crit > 1.0) then
                args.heal = args.heal * args.crit
                for i = 1, #GameMode.CritHealManaEventHandlersTable do
                    if (not args.caster or args.caster:IsNull() or not args.caster:IsAlive() or not args.target or args.target:IsNull() or not args.target:IsAlive()) then
                        break
                    end
                    GameMode.CritHealManaEventHandlersTable[i](nil, args)
                end
            end
            args.target:GiveMana(args.heal)
            PopupManaHealing(args.target, args.heal)
            for i = 1, #GameMode.PostHealManaEventHandlersTable do
                if (not args.caster or args.caster:IsNull() or not args.caster:IsAlive() or not args.target or args.target:IsNull() or not args.target:IsAlive()) then
                    break
                end
                GameMode.PostHealManaEventHandlersTable[i](nil, args)
            end
        end
    end

    function GameMode:RollCriticalChance(unit, chance)
        return RollPercentage(chance * Units:GetCriticalChanceMultiplier(unit))
    end

    ---@param modifierTable MODIFIER_TABLE
    function GameMode:OnModifierApplied(modifierTable)
        if (modifierTable.target) then
            print("Modifier added ", modifierTable.modifier_name)
            Units:ForceStatsCalculation(modifierTable.target)
        end
    end

    function GameMode:BuildCrowdControlModifiersList()
        Timers:CreateTimer(2.0, function()
            for k, v in pairs(_G) do
                if (type(v) == "table" and v.CheckState) then
                    local stateTable = v.CheckState(nil)
                    local isRoot = (stateTable[MODIFIER_STATE_ROOTED] == true)
                    local isStun = (stateTable[MODIFIER_STATE_STUNNED] == true)
                    local isSilence = (stateTable[MODIFIER_STATE_SILENCED] == true)
                    local isHex = (stateTable[MODIFIER_STATE_HEXED] == true)
                    GameMode.CrowdControlModifiersTable[k] = { root = isRoot, stun = isStun, silence = isSilence, hex = isHex }
                end
            end
        end)
    end

    function GameMode:ChangeModifier(modifier)
        if (modifier.OnDestroy and not modifier.OnDestroy2) then
            modifier.OnDestroy2 = modifier.OnDestroy
            modifier.OnDestroy = function(context)
                context.OnDestroy2(context)
                if (IsServer()) then
                    Units:ForceStatsCalculation(context:GetParent())
                end
            end
        end
        if (not modifier.SetStackCount2) then
            modifier.SetStackCount2 = modifier.SetStackCount
            modifier.SetStackCount = function(context, count)
                context.SetStackCount2(context, count)
                if (IsServer()) then
                    Units:ForceStatsCalculation(context:GetParent())
                end
            end
        end
        if (not modifier.IncrementStackCount2) then
            modifier.IncrementStackCount2 = modifier.IncrementStackCount
            modifier.IncrementStackCount = function(context)
                context.IncrementStackCount2(context)
                if (IsServer()) then
                    Units:ForceStatsCalculation(context:GetParent())
                end
            end
        end
        if (not modifier.DecrementStackCount2) then
            modifier.DecrementStackCount2 = modifier.DecrementStackCount
            modifier.DecrementStackCount = function(context)
                context.DecrementStackCount2(context)
                if (IsServer()) then
                    Units:ForceStatsCalculation(context:GetParent())
                end
            end
        end
    end
end

modifier_cooldown_reduction_custom = class({
    IsDebuff = function(self)
        return false
    end,
    IsHidden = function(self)
        return true
    end,
    IsPurgable = function(self)
        return false
    end,
    RemoveOnDeath = function(self)
        return false
    end,
    AllowIllusionDuplicate = function(self)
        return false
    end,
    GetAttributes = function(self)
        return MODIFIER_ATTRIBUTE_PERMANENT
    end,
    DeclareFunctions = function(self)
        return { MODIFIER_EVENT_ON_ABILITY_FULLY_CAST }
    end
})

function modifier_cooldown_reduction_custom:OnAbilityFullyCast(keys)
    if (not IsServer()) then
        return
    end
    if (keys.unit == self.unit) then
        local cooldownTable = {}
        cooldownTable.reduction = Units:GetCooldownReduction(self.unit)
        cooldownTable.ability = keys.ability:GetAbilityName()
        cooldownTable.isflat = false
        cooldownTable.target = self.unit
        GameMode:ReduceAbilityCooldown(cooldownTable)
    end
end

function modifier_cooldown_reduction_custom:OnCreated(keys)
    if (not IsServer()) then
        return
    end
    self.unit = self:GetParent()
end

LinkLuaModifier("modifier_cooldown_reduction_custom", "systems/game_mechanics", LUA_MODIFIER_MOTION_NONE)

ListenToGameEvent("npc_spawned", function(keys)
    if (not IsServer()) then
        return
    end
    local unit = EntIndexToHScript(keys.entindex)
    local isUnitThinker = (unit:GetUnitName() == "npc_dota_thinker")
    if (not unit:HasModifier("modifier_cooldown_reduction_custom") and not Summons:IsSummmon(unit) and not isUnitThinker) then
        unit:AddNewModifier(unit, nil, "modifier_cooldown_reduction_custom", { Duration = -1 })
    end
end, nil)

modifier_out_of_combat = class({
    IsDebuff = function(self)
        return false
    end,
    IsHidden = function(self)
        return true
    end,
    IsPurgable = function(self)
        return false
    end,
    RemoveOnDeath = function(self)
        return false
    end,
    AllowIllusionDuplicate = function(self)
        return false
    end,
    GetAttributes = function(self)
        return MODIFIER_ATTRIBUTE_PERMANENT
    end
})

function modifier_out_of_combat:OnCreated(keys)
    if (not IsServer()) then
        return
    end
    self.caster = self:GetParent()
    self.delay = 4
    self:StartIntervalThink(1.0)
end

function modifier_out_of_combat:OnIntervalThink()
    if (not IsServer()) then
        return
    end
    local stacks = self:GetStackCount() + 1
    if (stacks > self.delay) then
        stacks = self.delay
        if (not self.buff) then
            self.buff = self.caster:AddNewModifier(self.caster, nil, "modifier_out_of_combat_buff", { duration = -1 })
        end
    end
    self:SetStackCount(stacks)
end

function modifier_out_of_combat:OnPostTakeDamage(damageTable)
    local modifier = damageTable.victim:FindModifierByName("modifier_out_of_combat")
    if (modifier) then
        modifier_out_of_combat:ResetTimer(damageTable.victim)
    end
    modifier = damageTable.attacker:FindModifierByName("modifier_out_of_combat")
    if (modifier) then
        modifier_out_of_combat:ResetTimer(damageTable.attacker)
    end
end

function modifier_out_of_combat:OnPostHeal(healTable)
    local modifier = healTable.caster:FindModifierByName("modifier_out_of_combat")
    if (modifier and not healTable.target:HasModifier("modifier_out_of_combat_buff")) then
        modifier_out_of_combat:ResetTimer(healTable.caster)
    end
end

function modifier_out_of_combat:ResetTimer(unit)
    if (not unit or unit:IsNull()) then
        return
    end
    local buff = unit:FindModifierByName("modifier_out_of_combat_buff")
    if (buff) then
        buff:Destroy()
    end
    local modifier = unit:FindModifierByName("modifier_out_of_combat")
    if (modifier) then
        modifier:SetStackCount(0)
        modifier.buff = nil
    end
end

LinkLuaModifier("modifier_out_of_combat", "systems/game_mechanics", LUA_MODIFIER_MOTION_NONE)

modifier_out_of_combat_buff = class({
    IsDebuff = function(self)
        return false
    end,
    IsHidden = function(self)
        return false
    end,
    IsPurgable = function(self)
        return false
    end,
    RemoveOnDeath = function(self)
        return false
    end,
    AllowIllusionDuplicate = function(self)
        return false
    end,
    GetAttributes = function(self)
        return MODIFIER_ATTRIBUTE_PERMANENT
    end,
    GetTexture = function(self)
        return "chen_divine_favor"
    end
})

function modifier_out_of_combat_buff:GetMoveSpeedBonus()
    return 100
end

function modifier_out_of_combat_buff:OnCreated(keys)
    if (not IsServer()) then
        return
    end
    self.caster = self:GetParent()
    self:StartIntervalThink(1.0)
    self:OnIntervalThink()
end

function modifier_out_of_combat_buff:OnIntervalThink()
    if (not IsServer() or not self.caster:IsAlive()) then
        return
    end
    local healTable = {}
    healTable.caster = self.caster
    healTable.target = self.caster
    healTable.ability = nil
    healTable.heal = self.caster:GetMaxHealth() * 0.10
    GameMode:HealUnit(healTable)
    healTable.heal = self.caster:GetMaxMana() * 0.10
    GameMode:HealUnitMana(healTable)
end

LinkLuaModifier("modifier_out_of_combat_buff", "systems/game_mechanics", LUA_MODIFIER_MOTION_NONE)

ListenToGameEvent("npc_spawned", function(keys)
    if (not IsServer()) then
        return
    end
    local unit = EntIndexToHScript(keys.entindex)
    local isUnitThinker = (unit:GetUnitName() == "npc_dota_thinker")
    if (not unit:HasModifier("modifier_out_of_combat") and not Summons:IsSummmon(unit) and not isUnitThinker and unit.IsRealHero and unit:IsRealHero()) then
        unit:AddNewModifier(unit, nil, "modifier_out_of_combat", { Duration = -1 })
    end
end, nil)

if (IsServer() and not GameMode.GAME_MECHANICS_INIT) then
    GameMode.PreDamageEventHandlersTable = {}
    GameMode.PostDamageEventHandlersTable = {}
    GameMode.CritDamageEventHandlersTable = {}
    GameMode.PostApplyModifierEventHandlersTable = {}
    GameMode.PreHealEventHandlersTable = {}
    GameMode.PostHealEventHandlersTable = {}
    GameMode.CritHealEventHandlersTable = {}
    GameMode.PreHealManaEventHandlersTable = {}
    GameMode.PostHealManaEventHandlersTable = {}
    GameMode.CritHealManaEventHandlersTable = {}
    GameMode.CrowdControlModifiersTable = {}
    GameMode:RegisterPostDamageEventHandler(Dynamic_Wrap(modifier_out_of_combat, 'OnPostTakeDamage'))
    GameMode:RegisterPostHealEventHandler(Dynamic_Wrap(modifier_out_of_combat, 'OnPostHeal'))
    GameMode:RegisterPostApplyModifierEventHandler(Dynamic_Wrap(GameMode, 'OnModifierApplied'))
    GameMode:BuildCrowdControlModifiersList()
    GameMode.GAME_MECHANICS_INIT = true
end