---------------
--HELPER FUNCTION
-----------------
function IsMirana(unit)
    if unit:GetUnitName() == "npc_boss_mirana" then
        return true
    else
        return false
    end
end

-------------
--luna void
------------
luna_void = class({
    GetAbilityTextureName = function(self)
        return "luna_void"
    end,
    GetIntrinsicModifierName = function(self)
        return "modifier_luna_void"
    end,
})

modifier_luna_void = class({
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
        return true
    end,
    DeclareFunctions = function(self)
        return { MODIFIER_EVENT_ON_ATTACK_LANDED }
    end
})


function modifier_luna_void:OnCreated()
    if not IsServer() then
        return
    end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
end

function modifier_luna_void:OnAttackLanded(keys)
    if not IsServer() then
        return
    end
    if (keys.attacker == self.parent) then
        Timers:CreateTimer(0.1,function()
        local radius = self:GetAbility():GetSpecialValueFor("radius")
        local Max_mana = keys.target:GetMaxMana()
        local Mana = keys.target:GetMana()
        local damage = self:GetAbility():GetSpecialValueFor("explode_per_mana") * (Max_mana - Mana)
        local void_pfx = ParticleManager:CreateParticle("particles/econ/items/antimage/antimage_weapon_basher_ti5/antimage_manavoid_ti_5.vpcf", PATTACH_POINT_FOLLOW, keys.target)
        ParticleManager:SetParticleControlEnt(void_pfx, 0, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetOrigin(), true)
        ParticleManager:SetParticleControl(void_pfx, 1, Vector(radius,0,0))
        ParticleManager:ReleaseParticleIndex(void_pfx)
        keys.attacker:EmitSoundParams("Hero_Antimage.ManaVoidCast", 1.0, 0.2, 0) --name pitch volume(81 for base) delay
        keys.target:EmitSoundParams("Hero_Antimage.ManaVoid", 1.0, 0.2, 0)
        -- Find all nearby enemies
        local enemies = FindUnitsInRadius(keys.attacker:GetTeamNumber(),
                keys.target:GetAbsOrigin(),
                nil,
                radius,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                DOTA_UNIT_TARGET_FLAG_NONE,
                FIND_ANY_ORDER,
                false)
        for _, enemy in pairs(enemies) do
            local damageTable= {}
            damageTable.caster = keys.attacker
            damageTable.target = enemy
            damageTable.ability = self.ability
            damageTable.damage = damage*0.001
            damageTable.voiddmg = true
            GameMode:DamageUnit(damageTable)
        end
        end)
    end
end

LinkLuaModifier("modifier_luna_void", "creeps/zone1/boss/luna.lua", LUA_MODIFIER_MOTION_NONE)

---------
--luna wax
--------

--local wax_sound = "luna_luna_levelup_10"

--function PathRainOfStarsAA( event )
    --local caster = event.caster
    --local target = event.target
    --local chance = 15
    --if math.random(1,100) <= chance then
        --EmitSoundOn("Hero_Luna.Eclipse.Cast", target)
        --local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_mirana/mirana_starfall_attack.vpcf", PATTACH_POINT_FOLLOW, target)
        --ParticleManager:ReleaseParticleIndex(particle)
    --end
--end

--------------
--luna bound
---------------
luna_bound = class({
    GetAbilityTextureName = function(self)
        return "luna_bound"
    end,
    GetIntrinsicModifierName = function(self)
        return "modifier_luna_bound"
    end,
})

modifier_luna_bound = class({
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
    DeclareFunctions = function(self)
        return { MODIFIER_EVENT_ON_DEATH }
    end
})

function modifier_luna_bound:OnCreated()
    if not IsServer() then
        return
    end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    --apply buff to luna but set inactive state
    local modifierTable = {}
    modifierTable.ability = self.ability
    modifierTable.target = self.parent
    modifierTable.caster = self.parent
    modifierTable.modifier_name = "modifier_luna_bound_buff"
    modifierTable.duration = -1
    modifierTable.stacks = 1
    modifierTable.max_stacks = 2
    GameMode:ApplyStackingBuff(modifierTable)
    self.mirana = nil
    Timers:CreateTimer(0, function()
        if self.mirana == nil then
            self.mirana = self.ability:FindMirana(self.parent)
            return 0.1
        end
    end)
    local bound = "particles/econ/items/spectre/spectre_transversant_soul/spectre_transversant_spectral_dagger_path_owner_impact.vpcf"
    local bound_fx = ParticleManager:CreateParticle(bound, PATTACH_POINT_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(bound_fx, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    Timers:CreateTimer(1.0, function()
        ParticleManager:DestroyParticle(bound_fx, false)
        ParticleManager:ReleaseParticleIndex(bound_fx)
    end)
end

function luna_bound:FindMirana(parent)
    local allies = FindUnitsInRadius(parent:GetTeamNumber(),
            parent:GetAbsOrigin(),
            nil,
            25000,
            DOTA_UNIT_TARGET_TEAM_FRIENDLY,
            DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER,
            false)
    for _, ally in pairs(allies) do
        if IsMirana(ally) == true then
            local Mirana = ally
            return Mirana
        else return nil
        end
    end
end

function modifier_luna_bound:OnDeath(params)
    local stack = self.parent:FindModifierByName("modifier_luna_bound_buff"):GetStackCount()
    if (params.unit == self.parent and stack == 1) then
        if self.mirana ~= nil then
            self.mirana:FindModifierByName("modifier_mirana_bound_buff"):SetStackCount(2)
        end
        local bound = "particles/econ/items/spectre/spectre_transversant_soul/spectre_transversant_spectral_dagger_path_owner_impact.vpcf"
        local bound_fx = ParticleManager:CreateParticle(bound, PATTACH_POINT_FOLLOW, self.parent)
        ParticleManager:SetParticleControlEnt(bound_fx, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
        Timers:CreateTimer(1.0, function()
            ParticleManager:DestroyParticle(bound_fx, false)
            ParticleManager:ReleaseParticleIndex(bound_fx)
        end)
    end
end

LinkLuaModifier("modifier_luna_bound", "creeps/zone1/boss/luna.lua", LUA_MODIFIER_MOTION_NONE)

modifier_luna_bound_buff = class({
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
        return luna_bound:GetAbilityTextureName()
    end,
})

function modifier_luna_bound_buff:OnCreated()
    if not IsServer() then
        return
    end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.lifesteal = self:GetAbility():GetSpecialValueFor("lifesteal")
end

---@param damageTable DAMAGE_TABLE
function modifier_luna_bound_buff:OnTakeDamage(damageTable)
    local modifier = damageTable.attacker:FindModifierByName("modifier_luna_bound_buff")
    local stack = 1
    if modifier ~= nil then
        stack = modifier:GetStackCount()
    end
    if (damageTable.damage > 0 and stack>1 and not damageTable.ability and damageTable.physdmg) then
        --lifesteal
        local healFX = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_POINT_FOLLOW, damageTable.attacker)
        Timers:CreateTimer(1.0, function()
            ParticleManager:DestroyParticle(healFX, false)
            ParticleManager:ReleaseParticleIndex(healFX)
        end)
        local healTable = {}
        healTable.caster = damageTable.attacker
        healTable.target = damageTable.attacker
        healTable.ability = modifier:GetAbility()
        healTable.heal = damageTable.damage * modifier:GetAbility():GetSpecialValueFor("lifesteal") * 0.01
        GameMode:HealUnit(healTable)
        --moonshard arrow
        local mana_burn =  modifier:GetAbility():GetSpecialValueFor("mana_burn") * 0.01
        local void_per_burn =  modifier:GetAbility():GetSpecialValueFor("void_per_burn") *0.01
        local Max_mana = damageTable.victim:GetMaxMana()
        local burn = Max_mana * mana_burn

        local Mana = damageTable.victim:GetMana()
        --if burn more than current mana burn equal to current mana
        if burn > Mana then
            burn = Mana
        end
        local damage = burn * void_per_burn
        damageTable.victim:ReduceMana(burn)
        damageTable.victim:EmitSound("Hero_Antimage.ManaBreak")
        local manaburn_pfx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN_FOLLOW, damageTable.victim)
        ParticleManager:SetParticleControl(manaburn_pfx, 0, damageTable.victim:GetAbsOrigin() )
        ParticleManager:ReleaseParticleIndex(manaburn_pfx)

        local damageTable= {}
        damageTable.caster =  modifier:GetParent()
        damageTable.target = damageTable.victim
        damageTable.ability =  modifier:GetAbility()
        damageTable.damage = damage
        damageTable.voiddmg = true
        GameMode:DamageUnit(damageTable)
    end
end

LinkLuaModifier("modifier_luna_bound_buff", "creeps/zone1/boss/luna.lua", LUA_MODIFIER_MOTION_NONE)

--internal stuff
if (IsServer() and not GameMode.ZONE1_BOSS_LUNA) then
    GameMode:RegisterPreDamageEventHandler(Dynamic_Wrap(modifier_luna_bound_buff, 'OnTakeDamage'))
    GameMode.ZONE1_BOSS_LUNA = true
end