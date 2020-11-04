if not Dummy then
    Dummy = class({})
end

function Dummy:Init()
    -- Changing that require same change in client side dummy.js
    Dummy.DPS_TIME = 10
    Dummy.DPS_DELAY = 5
end

modifier_dps_dummy = class({
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
        return { MODIFIER_PROPERTY_MIN_HEALTH }
    end,
    CheckState = function(self)
        return {
            [MODIFIER_STATE_NO_HEALTH_BAR] = true
        }
    end,
    GetMinHealth = function(self)
        return 1
    end
})

GameMode.PostDamageEventHandlersTable = {}
GameMode:RegisterPostDamageEventHandler(Dynamic_Wrap(modifier_dps_dummy, 'OnPostTakeDamage'))

---@param damageTable DAMAGE_TABLE
function modifier_dps_dummy:OnPostTakeDamage(damageTable)
    local modifier = damageTable.victim:FindModifierByName("modifier_dps_dummy")
    local playerId = damageTable.attacker:GetPlayerOwnerID()
    if (modifier) then
        local abilityDamage = false
        local abilityName = ""
        if (damageTable.ability) then
            abilityDamage = true
            abilityName = damageTable.ability:GetAbilityName()
        end
        local timer = 0
        if(damageTable.victim.isready and playerId == damageTable.victim.owner) then
            timer = 1
        end
        print(damageTable.fromtalent)
        local event = {
            player_id = playerId,
            damage = damageTable.damage,
            source = damageTable.attacker:GetUnitName(),
            ability = abilityDamage,
            abilityName = abilityName,
            physdmg = damageTable.physdmg,
            puredmg = damageTable.puredmg,
            firedmg = damageTable.firedmg,
            frostdmg = damageTable.frostdmg,
            earthdmg = damageTable.earthdmg,
            naturedmg = damageTable.naturedmg,
            voiddmg = damageTable.voiddmg,
            infernodmg = damageTable.infernodmg,
            holydmg = damageTable.holydmg,
            fromsummon = damageTable.fromsummon,
            timer = timer,
            fromtalent = damageTable.fromtalent
        }
        table.insert(damageTable.victim.damageInstances, event)
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerId), "rpg_dummy_damage", event)
    end
end

function modifier_dps_dummy:OnCreated()
    if (not IsServer()) then
        return
    end
    self.parent = self:GetParent()
    self.parent.bonusStats = {}
    self.parent.damageInstances = {}
    Timers:CreateTimer(0, function()
        local scaling = self.parent:FindModifierByName("modifier_creep_scaling")
        if (scaling) then
            scaling:Destroy()
            Timers:CreateTimer(1, function()
                local eliteModifier = self.parent:FindModifierByName("modifier_creep_elite")
                if (eliteModifier) then
                    eliteModifier:Destroy()
                end
                Units:ForceStatsCalculation(self.parent)
            end, self)
        else
            return 0.25
        end
    end, self)
end

function modifier_dps_dummy:GetArmorBonus()
    return self.parent.bonusStats.physdmg or 0
end

function modifier_dps_dummy:GetFireProtectionBonus()
    return self.parent.bonusStats.firedmg or 0
end

function modifier_dps_dummy:GetFrostProtectionBonus()
    return self.parent.bonusStats.frostdmg or 0
end

function modifier_dps_dummy:GetEarthProtectionBonus()
    return self.parent.bonusStats.earthdmg or 0
end

function modifier_dps_dummy:GetVoidProtectionBonus()
    return self.parent.bonusStats.voiddmg or 0
end

function modifier_dps_dummy:GetHolyProtectionBonus()
    return self.parent.bonusStats.holydmg or 0
end

function modifier_dps_dummy:GetNatureProtectionBonus()
    return self.parent.bonusStats.naturedmg or 0
end

function modifier_dps_dummy:GetInfernoProtectionBonus()
    return self.parent.bonusStats.infernodmg or 0
end

LinkLuaModifier("modifier_dps_dummy", "systems/dummy", LUA_MODIFIER_MOTION_NONE)

modifier_dps_dummy_counter = class({
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
        return { MODIFIER_PROPERTY_MIN_HEALTH }
    end,
    GetMinHealth = function(self)
        return 1
    end
})

function modifier_dps_dummy_counter:OnCreated(keys)
    if (not IsServer()) then
        return
    end
    if (not keys or not keys.delay) then
        self:Destroy()
    end
    self.parent = self:GetParent()
    self.particle = ParticleManager:CreateParticle("particles/units/dummy/dummy_number.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(self.particle, 1, Vector(0, keys.delay, 0))
    self:SetStackCount(keys.delay)
    self:StartIntervalThink(1.0)
end

function modifier_dps_dummy_counter:OnIntervalThink()
    if (not IsServer()) then
        return
    end
    local stacks = self:GetStackCount() - 1
    if (stacks < 1) then
        self:Destroy()
    else
        ParticleManager:SetParticleControl(self.particle, 1, Vector(0, stacks, 0))
        self:SetStackCount(stacks)
    end
end

function modifier_dps_dummy_counter:OnDestroy()
    if (not IsServer()) then
        return
    end
    local responses = { "ogre_magi_ogmag_kill_06", "ogre_magi_ogmag_attack_04", "ogre_magi_ogmag_level_07" }
    self.parent:EmitSound(responses[math.random(#responses)])
    ParticleManager:DestroyParticle(self.particle, true)
    ParticleManager:ReleaseParticleIndex(self.particle)
    self.parent.isready = true
    local dummy = self.parent
    dummy.dummyParticle = ParticleManager:CreateParticle("particles/units/dummy/dummy.vpcf", PATTACH_OVERHEAD_FOLLOW, dummy)
    Timers:CreateTimer(Dummy.DPS_TIME, function()
        Dummy:Release(dummy)
        ParticleManager:DestroyParticle(dummy.dummyParticle, true)
        ParticleManager:ReleaseParticleIndex(dummy.dummyParticle)
    end, nil)
end

LinkLuaModifier("modifier_dps_dummy_counter", "systems/dummy", LUA_MODIFIER_MOTION_NONE)

function Dummy:InitPanaromaEvents()
    CustomGameEventManager:RegisterListener("rpg_dummy_start", Dynamic_Wrap(Dummy, 'OnDummyStartRequest'))
    CustomGameEventManager:RegisterListener("rpg_dummy_open_window", Dynamic_Wrap(Dummy, 'OnDummyOpenWindowRequest'))
    CustomGameEventManager:RegisterListener("rpg_dummy_close_window", Dynamic_Wrap(Dummy, 'OnDummyCloseWindowRequest'))
    CustomGameEventManager:RegisterListener("rpg_dummy_update_stats", Dynamic_Wrap(Dummy, 'OnDummyUpdateStatsRequest'))
end

function Dummy:OnDummyUpdateStatsRequest(event)
    if (not event or not event.dummy) then
        return
    end
    event.physdmg = string.gsub(tostring(event.physdmg), ",", ".")
    event.physdmg = tonumber(event.physdmg)
    event.firedmg = string.gsub(tostring(event.firedmg), ",", ".")
    event.firedmg = tonumber(event.firedmg)
    event.frostdmg = string.gsub(tostring(event.frostdmg), ",", ".")
    event.frostdmg = tonumber(event.frostdmg)
    event.earthdmg = string.gsub(tostring(event.earthdmg), ",", ".")
    event.earthdmg = tonumber(event.earthdmg)
    event.naturedmg = string.gsub(tostring(event.naturedmg), ",", ".")
    event.naturedmg = tonumber(event.naturedmg)
    event.voiddmg = string.gsub(tostring(event.voiddmg), ",", ".")
    event.voiddmg = tonumber(event.voiddmg)
    event.infernodmg = string.gsub(tostring(event.infernodmg), ",", ".")
    event.infernodmg = tonumber(event.infernodmg)
    event.holydmg = string.gsub(tostring(event.holydmg), ",", ".")
    event.holydmg = tonumber(event.holydmg)
    event.dummy = EntIndexToHScript(event.dummy)
    if (not event.dummy) then
        return
    end
    if (not event.physdmg or event.physdmg < 0) then
        return
    end
    if (not event.firedmg or event.firedmg < 0) then
        return
    end
    if (not event.frostdmg or event.frostdmg < 0) then
        return
    end
    if (not event.earthdmg or event.earthdmg < 0) then
        return
    end
    if (not event.naturedmg or event.naturedmg < 0) then
        return
    end
    if (not event.voiddmg or event.voiddmg < 0) then
        return
    end
    if (not event.infernodmg or event.infernodmg < 0) then
        return
    end
    if (not event.holydmg or event.holydmg < 0) then
        return
    end
    event.physdmg = event.physdmg
    event.firedmg = event.firedmg / 100
    event.frostdmg = event.frostdmg / 100
    event.earthdmg = event.earthdmg / 100
    event.naturedmg = event.naturedmg / 100
    event.voiddmg = event.voiddmg / 100
    event.infernodmg = event.infernodmg / 100
    event.holydmg = event.holydmg / 100
    event.dummy.bonusStats.physdmg = event.physdmg
    event.dummy.bonusStats.firedmg = event.firedmg
    event.dummy.bonusStats.frostdmg = event.frostdmg
    event.dummy.bonusStats.earthdmg = event.earthdmg
    event.dummy.bonusStats.naturedmg = event.naturedmg
    event.dummy.bonusStats.voiddmg = event.voiddmg
    event.dummy.bonusStats.infernodmg = event.infernodmg
    event.dummy.bonusStats.holydmg = event.holydmg
    Units:ForceStatsCalculation(event.dummy)
end

function Dummy:Release(dummy)
    if (not IsServer() or not dummy) then
        return
    end
    dummy.isbusy = nil
    dummy.isready = nil
    dummy.owner = nil
end

function Dummy:OnDummyCloseWindowRequest(event)
    if (not event) then
        return
    end
    event.player_id = tonumber(event.player_id)
    if (not event.player_id) then
        return
    end
    local player = PlayerResource:GetPlayer(event.player_id)
    if (player) then
        CustomGameEventManager:Send_ServerToPlayer(player, "rpg_dummy_close_window_from_server", { player_id = event.player_id })
    end
end

function Dummy:OnDummyOpenWindowRequest(event)
    if (not event) then
        return
    end
    event.player_id = tonumber(event.player_id)
    if (not event.player_id) then
        return
    end
    local player = PlayerResource:GetPlayer(event.player_id)
    if (player) then
        CustomGameEventManager:Send_ServerToPlayer(player, "rpg_dummy_open_window_from_server", { player_id = event.player_id })
    end
end

function Dummy:OnDummyStartRequest(event)
    if (not event) then
        return
    end
    event.player_id = tonumber(event.player_id)
    if (not event.player_id) then
        return
    end
    event.dummy = tonumber(event.dummy)
    if (not event.dummy) then
        return
    end
    event.dummy = EntIndexToHScript(event.dummy)
    if (not event.dummy or event.dummy:IsNull() or not event.dummy:HasModifier("modifier_dps_dummy")) then
        return
    end
    if (event.dummy.isbusy and event.player_id ~= event.dummy.owner) then
        return
    end
    event.dummy.damageInstances = {}
    event.dummy.isbusy = true
    event.dummy.owner = event.player_id
    event.dummy:AddNewModifier(event.dummy, nil, "modifier_dps_dummy_counter", { duration = -1, delay = Dummy.DPS_DELAY })
    EmitSoundOn("ogre_magi_ogmag_battlebegins_01", event.dummy)
end

function Dummy:OnNPCSpawned(keys)
    if (not IsServer()) then
        return
    end
    local dummy = EntIndexToHScript(keys.entindex)
    if (dummy and dummy:GetUnitName() == "npc_dummy_dps_unit" and not dummy:HasModifier("modifier_dps_dummy") and dummy:GetTeam() ~= DOTA_TEAM_GOODGUYS) then
        dummy:AddNewModifier(dummy, nil, "modifier_dps_dummy", { Duration = -1 })
    end
end

if not Dummy.initialized and IsServer() then
    ListenToGameEvent('npc_spawned', Dynamic_Wrap(Dummy, 'OnNPCSpawned'), Dummy)
    GameMode:RegisterPostDamageEventHandler(Dynamic_Wrap(modifier_dps_dummy, 'OnPostTakeDamage'))
    Dummy:InitPanaromaEvents()
    Dummy:Init()
    Dummy.initialized = true
end

