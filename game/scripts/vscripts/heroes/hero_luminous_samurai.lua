local LinkedModifiers = {}
-- luminous_samurai_bankai modifiers
modifier_luminous_samurai_bankai_buff = class({
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
        return true
    end,
    AllowIllusionDuplicate = function(self)
        return false
    end,
    GetTexture = function(self)
        return luminous_samurai_bankai:GetAbilityTextureName()
    end,
    DeclareFunctions = function(self)
        return {
            MODIFIER_PROPERTY_TOOLTIP,
            MODIFIER_PROPERTY_TOOLTIP2
        }
    end
})

function modifier_luminous_samurai_bankai_buff:OnCreated()
    self.ability = self:GetAbility()
    self.attackDamage = self.ability:GetSpecialValueFor("attack_dmg_per_stack")
    self.critDamage = self.ability:GetSpecialValueFor("crit_dmg_per_stack") / 100
end

function modifier_luminous_samurai_bankai_buff:GetAttackDamageBonus()
    return self.attackDamage * self:GetStackCount()
end

function modifier_luminous_samurai_bankai_buff:GetCriticalDamageBonus()
    return self.critDamage * self:GetStackCount()
end

function modifier_luminous_samurai_bankai_buff:OnTooltip()
    return self.attackDamage * self:GetStackCount()
end

function modifier_luminous_samurai_bankai_buff:OnTooltip2()
    return self.critDamage * self:GetStackCount() * 100
end

LinkedModifiers["modifier_luminous_samurai_bankai_buff"] = LUA_MODIFIER_MOTION_NONE

modifier_luminous_samurai_bankai = class({
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
        return true
    end,
    AllowIllusionDuplicate = function(self)
        return false
    end,
    GetEffectName = function(self)
        return "particles/units/luminous_samurai/bankai/bankai_buff.vpcf"
    end,
    DeclareFunctions = function(self)
        return {
            MODIFIER_EVENT_ON_ATTACK_LANDED,
            MODIFIER_EVENT_ON_DEATH
        }
    end
})

function modifier_luminous_samurai_bankai:OnCreated()
    if (not IsServer()) then
        return
    end
    self.caster = self:GetParent()
    self.ability = self:GetAbility()
    self.stackDuration = self.ability:GetSpecialValueFor("stack_duration")
    self.maxStacks = self.ability:GetSpecialValueFor("max_stacks")
    self.bonusDuration = self.ability:GetSpecialValueFor("bonus_duration")
end

function modifier_luminous_samurai_bankai:OnAttackLanded(keys)
    if (not IsServer()) then
        return
    end
    local attacker = keys.attacker
    local target = keys.target
    if (attacker ~= nil and target ~= nil and attacker ~= target and attacker == self.caster) then
        local modifierTable = {}
        modifierTable.ability = self.ability
        modifierTable.target = self.caster
        modifierTable.caster = self.caster
        modifierTable.modifier_name = "modifier_luminous_samurai_bankai_buff"
        modifierTable.duration = self.stackDuration
        modifierTable.stacks = 1
        modifierTable.max_stacks = self.maxStacks
        GameMode:ApplyStackingBuff(modifierTable)
        local pidx = ParticleManager:CreateParticle("particles/units/luminous_samurai/bankai/bankai_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
        ParticleManager:SetParticleControlEnt(pidx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        Timers:CreateTimer(3.0, function()
            ParticleManager:DestroyParticle(pidx, false)
            ParticleManager:ReleaseParticleIndex(pidx)
        end)
    end
end

function modifier_luminous_samurai_bankai:OnDeath(keys)
    if (not IsServer()) then
        return
    end
    if (keys.attacker == self.caster) then
        self:SetDuration(self:GetElapsedTime() + self.bonusDuration, true)
    end
end

LinkedModifiers["modifier_luminous_samurai_bankai"] = LUA_MODIFIER_MOTION_NONE

-- luminous_samurai_bankai
luminous_samurai_bankai = class({
    GetAbilityTextureName = function(self)
        return "luminous_samurai_bankai"
    end
})

function luminous_samurai_bankai:OnSpellStart()
    if (not IsServer()) then
        return
    end
    local caster = self:GetCaster()
    local modifierTable = {}
    modifierTable.ability = self
    modifierTable.target = caster
    modifierTable.caster = caster
    modifierTable.modifier_name = "modifier_luminous_samurai_bankai"
    modifierTable.duration = self:GetSpecialValueFor("duration")
    GameMode:ApplyBuff(modifierTable)
    EmitSoundOn("Hero_Juggernaut.HealingWard.Cast", caster)
    local pidx = ParticleManager:CreateParticle("particles/units/luminous_samurai/bankai/bankai.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    Timers:CreateTimer(3.0, function()
        ParticleManager:DestroyParticle(pidx, false)
        ParticleManager:ReleaseParticleIndex(pidx)
    end)
end

-- luminous_samurai_jhana modifiers
modifier_luminous_samurai_jhana_buff = class({
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
    GetTexture = function(self)
        return luminous_samurai_jhana:GetAbilityTextureName()
    end
})

function modifier_luminous_samurai_jhana_buff:OnCreated()
    if (not IsServer()) then
        return
    end
    self.ability = self:GetAbility()
end

function modifier_luminous_samurai_jhana_buff:GetHealthRegenerationBonus()
    return self.ability.hpPerStack * self:GetStackCount()
end

function modifier_luminous_samurai_jhana_buff:GetManaRegenerationBonus()
    return self.ability.mpPerStack * self:GetStackCount()
end

LinkedModifiers["modifier_luminous_samurai_jhana_buff"] = LUA_MODIFIER_MOTION_NONE

modifier_luminous_samurai_jhana = class({
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

function modifier_luminous_samurai_jhana:OnCreated()
    if (not IsServer()) then
        return
    end
    self.caster = self:GetParent()
    self.ability = self:GetAbility()
end

function modifier_luminous_samurai_jhana:OnTakeDamage(damageTable)
    local modifier = damageTable.victim:FindModifierByName("modifier_luminous_samurai_jhana")
    if (damageTable.damage > 0 and modifier and RollPercentage(modifier.ability.procChance) and not modifier.cooldown) then
        local modifierTable = {}
        modifierTable.ability = modifier.ability
        modifierTable.target = damageTable.victim
        modifierTable.caster = damageTable.victim
        modifierTable.modifier_name = "modifier_luminous_samurai_jhana_buff"
        modifierTable.duration = -1
        modifierTable.stacks = 1
        modifierTable.max_stacks = modifier.ability.maxStacks
        local buff = GameMode:ApplyStackingBuff(modifierTable)
        modifier.cooldown = true
        EmitSoundOn("Hero_Juggernaut.HealingWard.Stop", damageTable.victim)
        local pidx = ParticleManager:CreateParticle("particles/units/luminous_samurai/jhana/jhana.vpcf", PATTACH_POINT_FOLLOW, damageTable.victim)
        Timers:CreateTimer(modifier.ability.stackDuration, function()
            local stacks = buff:GetStackCount() - 1
            if (stacks < 1) then
                buff:Destroy()
            else
                buff:SetStackCount(stacks)
            end
        end)
        Timers:CreateTimer(modifier.ability.stackCooldown, function()
            ParticleManager:DestroyParticle(pidx, false)
            ParticleManager:ReleaseParticleIndex(pidx)
            modifier.cooldown = nil
        end)
        damageTable.damage = 0
        return damageTable
    end
end

LinkedModifiers["modifier_luminous_samurai_jhana"] = LUA_MODIFIER_MOTION_NONE

-- luminous_samurai_jhana
luminous_samurai_jhana = class({
    GetAbilityTextureName = function(self)
        return "luminous_samurai_jhana"
    end,
    GetIntrinsicModifierName = function(self)
        return "modifier_luminous_samurai_jhana"
    end
})

function luminous_samurai_jhana:OnUpgrade()
    if (not IsServer()) then
        return
    end
    self.procChance = self:GetSpecialValueFor("proc_chance")
    self.hpPerStack = self:GetSpecialValueFor("hp_per_stack")
    self.mpPerStack = self:GetSpecialValueFor("mp_per_stack")
    self.maxStacks = self:GetSpecialValueFor("max_stacks")
    self.stackDuration = self:GetSpecialValueFor("stack_duration")
    self.stackCooldown = self:GetSpecialValueFor("stack_cd")
end

-- luminous_samurai_judgment_of_light modifiers
modifier_luminous_samurai_judgment_of_light_buff = class({
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
        return true
    end,
    AllowIllusionDuplicate = function(self)
        return false
    end
})
function modifier_luminous_samurai_judgment_of_light_buff:OnCreated(keys)
    if (not IsServer()) then
        return
    end
    if (not keys) then
        self:Destroy()
    end
    self.attackDamage = keys.attackDamage
end

function modifier_luminous_samurai_judgment_of_light_buff:GetAttackDamageBonus()
    return self.attackDamage * self:GetStackCount()
end

LinkedModifiers["modifier_luminous_samurai_judgment_of_light_buff"] = LUA_MODIFIER_MOTION_NONE

modifier_luminous_samurai_judgment_of_light_jump = class({
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
    GetStatusEffectName = function(self)
        return "particles/status_fx/status_effect_omnislash.vpcf"
    end,
    DeclareFunctions = function(self)
        return {
            MODIFIER_EVENT_ON_DEATH,
            MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE
        }
    end,
    CheckState = function(self)
        return {
            [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
            [MODIFIER_STATE_STUNNED] = true
        }
    end
})

function modifier_luminous_samurai_judgment_of_light_jump:GetModifierBaseDamageOutgoing_Percentage()
    return -100
end

function modifier_luminous_samurai_judgment_of_light_jump:OnDeath(keys)
    if (not IsServer()) then
        return
    end
    if (keys.attacker == self.caster) then
        local modifierTable = {}
        modifierTable.ability = self.ability
        modifierTable.target = self.caster
        modifierTable.caster = self.caster
        modifierTable.modifier_name = "modifier_luminous_samurai_judgment_of_light_buff"
        modifierTable.modifier_params = {
            attackDamage = self.attackDamage
        }
        modifierTable.duration = self.attackDamageDuration
        modifierTable.stacks = 1
        modifierTable.max_stacks = 99999
        GameMode:ApplyStackingBuff(modifierTable)
    end
end

function modifier_luminous_samurai_judgment_of_light_jump:OnCreated(keys)
    if (not IsServer()) then
        return
    end
    if (not keys) then
        self:Destroy()
    end
    self.ability = self:GetAbility()
    self.caster = self:GetParent()
    self.target = EntIndexToHScript(keys.target)
    if (not self.target or self.target:IsNull()) then
        self:Destroy()
    end
    self.jumps = keys.jumps
    self.critDamage = keys.critDamage
    self.critChance = keys.critChance
    self.holyDamage = keys.holyDamage
    self.attackDamage = keys.attackDamage
    self.attackDamageDuration = keys.attackDamageDuration
    self.jumpDelay = keys.jumpDelay
    self.jumpDamage = keys.jumpDamage
    self.caster:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
    self:StartIntervalThink(self.jumpDelay)
end

function modifier_luminous_samurai_judgment_of_light_jump:OnIntervalThink()
    if (not IsServer()) then
        return
    end
    self.jumps = self.jumps - 1
    if (self.jumps < 0 or not self.target or self.target:IsNull() or not self.caster:IsAlive()) then
        self:Destroy()
    else
        local casterPosition = self.caster:GetAbsOrigin()
        local targetPosition = self.target:GetAbsOrigin()
        local jumpPosition = targetPosition + RandomVector(128)
        self.caster:SetAbsOrigin(jumpPosition)
        self.caster:SetForwardVector((targetPosition - jumpPosition):Normalized())
        local pidx = ParticleManager:CreateParticle("particles/units/luminous_samurai/judgment_of_light/judgment_of_light_trail.vpcf", PATTACH_ABSORIGIN, self.caster)
        ParticleManager:SetParticleControl(pidx, 0, casterPosition)
        ParticleManager:SetParticleControl(pidx, 1, jumpPosition)
        Timers:CreateTimer(2.0, function()
            ParticleManager:DestroyParticle(pidx, false)
            ParticleManager:ReleaseParticleIndex(pidx)
        end)
        EmitSoundOn("Hero_Juggernaut.OmniSlash", self.caster)
        local damageTable = {}
        damageTable.caster = self.caster
        damageTable.target = self.target
        damageTable.ability = self.ability
        damageTable.damage = Units:GetAttackDamage(self.caster) * self.jumpDamage
        damageTable.holydmg = true
        GameMode:DamageUnit(damageTable)
        self.caster:PerformAttack(self.target, true, true, true, true, false, false, true)
        local pidx = ParticleManager:CreateParticle("particles/units/luminous_samurai/judgment_of_light/judgment_of_light_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.target)
        ParticleManager:SetParticleControlEnt(pidx, 0, self.target, PATTACH_POINT_FOLLOW, "attach_hitloc", targetPosition, true)
        Timers:CreateTimer(2.0, function()
            ParticleManager:DestroyParticle(pidx, false)
            ParticleManager:ReleaseParticleIndex(pidx)
        end)
    end
end

function modifier_luminous_samurai_judgment_of_light_jump:OnDestroy()
    if (not IsServer()) then
        return
    end
    self.caster:RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
    Units:ForceStatsCalculation(self.caster)
end

function modifier_luminous_samurai_judgment_of_light_jump:GetCriticalDamageBonus()
    return self.critDamage
end

function modifier_luminous_samurai_judgment_of_light_jump:GetCriticalChanceBonus()
    return self.critChance
end

function modifier_luminous_samurai_judgment_of_light_jump:GetHolyDamageBonus()
    return self.holyDamage
end

LinkedModifiers["modifier_luminous_samurai_judgment_of_light_jump"] = LUA_MODIFIER_MOTION_NONE

modifier_luminous_samurai_judgment_of_light = class({
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

function modifier_luminous_samurai_judgment_of_light:OnCreated()
    if (not IsServer()) then
        return
    end
    self.ability = self:GetAbility()
    self.pidx = ParticleManager:CreateParticle("particles/units/luminous_samurai/judgment_of_light/judgment_of_light.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.ability.caster)
    ParticleManager:SetParticleControlEnt(self.pidx, 1, self.ability.target, PATTACH_POINT_FOLLOW, "attach_hitloc", self.ability.target:GetAbsOrigin(), true)
    self:StartIntervalThink(0.05)
end

function modifier_luminous_samurai_judgment_of_light:OnIntervalThink()
    if (not IsServer()) then
        return
    end
    if (not self.ability.target or self.ability.target:IsNull() or not self.ability.target:IsAlive()) then
        self:Destroy()
    end
end

function modifier_luminous_samurai_judgment_of_light:OnDestroy()
    if (not IsServer()) then
        return
    end
    ParticleManager:DestroyParticle(self.pidx, false)
    ParticleManager:ReleaseParticleIndex(self.pidx)
end

LinkedModifiers["modifier_luminous_samurai_judgment_of_light"] = LUA_MODIFIER_MOTION_NONE

-- luminous_samurai_judgment_of_light
luminous_samurai_judgment_of_light = class({
    GetAbilityTextureName = function(self)
        return "luminous_samurai_judgment_of_light"
    end,
    IsRequireCastbar = function(self)
        return true
    end
})

function luminous_samurai_judgment_of_light:OnSpellStart()
    if (not IsServer()) then
        return true
    end
    self.modifier:Destroy()
    local targetLocation = self.target:GetAbsOrigin()
    local pidx = ParticleManager:CreateParticle("particles/units/luminous_samurai/judgment_of_light/judgment_of_light_trail.vpcf", PATTACH_ABSORIGIN, self.caster)
    ParticleManager:SetParticleControl(pidx, 1, targetLocation)
    Timers:CreateTimer(2.0, function()
        ParticleManager:DestroyParticle(pidx, false)
        ParticleManager:ReleaseParticleIndex(pidx)
    end)
    FindClearSpaceForUnit(self.caster, targetLocation, false)
    local modifierTable = {}
    modifierTable.ability = self
    modifierTable.target = self.caster
    modifierTable.caster = self.caster
    modifierTable.modifier_name = "modifier_luminous_samurai_judgment_of_light_jump"
    modifierTable.modifier_params = {
        target = self.target:GetEntityIndex(),
        jumps = self:GetSpecialValueFor("jumps"),
        critDamage = self:GetSpecialValueFor("crit_dmg") / 100,
        critChance = self:GetSpecialValueFor("crit_chance") / 100,
        holyDamage = self:GetSpecialValueFor("holy_dmg") / 100,
        attackDamage = self:GetSpecialValueFor("aa_dmg"),
        jumpDelay = self:GetSpecialValueFor("jump_delay"),
        jumpDamage = self:GetSpecialValueFor("jump_damage") / 100,
        attackDamageDuration = self:GetSpecialValueFor("aa_dmg_duration")
    }
    modifierTable.duration = -1
    GameMode:ApplyBuff(modifierTable)
end

function luminous_samurai_judgment_of_light:OnAbilityPhaseStart()
    if (not IsServer()) then
        return true
    end
    self.caster = self:GetCaster()
    self.target = self:GetCursorTarget()
    self.modifier = self.caster:AddNewModifier(self.caster, self, "modifier_luminous_samurai_judgment_of_light", { duration = -1 })
    return true
end

function luminous_samurai_judgment_of_light:OnAbilityPhaseInterrupted()
    if (not IsServer()) then
        return
    end
    if (self.modifier and not self.modifier:IsNull()) then
        self.modifier:Destroy()
    end
end
-- luminous_samurai_blade_dance modifiers
modifier_luminous_samurai_blade_dance_debuff = class({
    IsDebuff = function(self)
        return true
    end,
    IsHidden = function(self)
        return false
    end,
    IsPurgable = function(self)
        return true
    end,
    RemoveOnDeath = function(self)
        return true
    end,
    AllowIllusionDuplicate = function(self)
        return false
    end
})

function modifier_luminous_samurai_blade_dance_debuff:OnCreated()
    if (not IsServer()) then
        return
    end
    self.ability = self:GetAbility()
    self.caster = self:GetCaster()
    self.casterTeam = self.caster:GetTeam()
    self.target = self:GetParent()
    self.damage = self.ability:GetSpecialValueFor("proc_damage") * 0.01
    self.radius = self.ability:GetSpecialValueFor("proc_radius")
    self.count = self.ability:GetSpecialValueFor("proc_stacks")
end

function modifier_luminous_samurai_blade_dance_debuff:OnStackCountChanged()
    if (not IsServer()) then
        return
    end
    local stacks = self:GetStackCount()
    if (stacks >= self.count) then
        self:Destroy()
        local enemies = FindUnitsInRadius(self.casterTeam,
                self.target:GetAbsOrigin(),
                nil,
                self.radius,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_ALL,
                DOTA_UNIT_TARGET_FLAG_NONE,
                FIND_ANY_ORDER,
                false)
        local damage = self.damage * Units:GetAttackDamage(self.caster)
        for _, enemy in pairs(enemies) do
            local damageTable = {}
            damageTable.caster = self.caster
            damageTable.target = enemy
            damageTable.ability = self.ability
            damageTable.damage = damage
            damageTable.holydmg = true
            GameMode:DamageUnit(damageTable)
        end
    end
end
LinkedModifiers["modifier_luminous_samurai_blade_dance_debuff"] = LUA_MODIFIER_MOTION_NONE

-- luminous_samurai_blade_dance
luminous_samurai_blade_dance = class({
    GetAbilityTextureName = function(self)
        return "luminous_samurai_blade_dance"
    end
})

function luminous_samurai_blade_dance:OnSpellStart()
    if (not IsServer()) then
        return
    end
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    local slashes = self:GetSpecialValueFor("slashes")
    local damage = self:GetSpecialValueFor("damage") * Units:GetAttackDamage(caster) * 0.01
    local slashPositions = {
        { Vector(31, 65, 71), Vector(15, -111, 52) },
        { Vector(-43, 65, 71), Vector(62, -111, 52) },
    }
    local targetPosition = target:GetAbsOrigin()
    Timers:CreateTimer(0, function()
        local slashPosition = slashPositions[math.random(1, #slashPositions)]
        local pidx = ParticleManager:CreateParticle("particles/units/luminous_samurai/blade_dance/blade_dance_slash.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
        ParticleManager:SetParticleControl(pidx, 7, targetPosition + slashPosition[1])
        ParticleManager:SetParticleControl(pidx, 8, targetPosition + slashPosition[2])
        Timers:CreateTimer(1.0, function()
            ParticleManager:DestroyParticle(pidx, false)
            ParticleManager:ReleaseParticleIndex(pidx)
        end)
        EmitSoundOn("Hero_Juggernaut.OmniSlash.Damage", target)
        local damageTable = {}
        damageTable.caster = caster
        damageTable.target = target
        damageTable.ability = self
        damageTable.damage = damage
        damageTable.holydmg = true
        GameMode:DamageUnit(damageTable)
        local modifierTable = {}
        modifierTable.ability = self
        modifierTable.target = target
        modifierTable.caster = caster
        modifierTable.modifier_name = "modifier_luminous_samurai_blade_dance_debuff"
        modifierTable.duration = -1
        modifierTable.stacks = 1
        modifierTable.max_stacks = 99999
        GameMode:ApplyStackingDebuff(modifierTable)
        slashes = slashes - 1
        if (slashes > 0) then
            return 0.1
        end
    end, self)
end

-- Internal stuff
for LinkedModifier, MotionController in pairs(LinkedModifiers) do
    LinkLuaModifier(LinkedModifier, "heroes/hero_luminous_samurai", MotionController)
end

if (IsServer() and not GameMode.LUMINOUS_SAMURAI_INIT) then
    GameMode:RegisterPreDamageEventHandler(Dynamic_Wrap(modifier_luminous_samurai_jhana, 'OnTakeDamage'))
    GameMode.LUMINOUS_SAMURAI_INIT = true
end