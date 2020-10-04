-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc

require('internal/util')
require('gamemode')

function Precache(context)
    --[[
      This function is used to precache resources/units/items/abilities that will be needed
      for sure in your game and that will not be precached by hero selection.  When a hero
      is selected from the hero selection screen, the game will precache that hero's assets,
      any equipped cosmetics, and perform the data-driven precaching defined in that hero's
      precache{} block, as well as the precache{} block for any equipped abilities.

      See GameMode:PostLoadPrecache() in gamemode.lua for more information
      ]]

    DebugPrint("[BAREBONES] Performing pre-load precache")
    -- Dummy
    PrecacheResource("particle", "particles/units/dummy/dummy.vpcf", context)
    PrecacheResource("particle", "particles/units/dummy/dummy_number.vpcf", context)
    PrecacheResource("soundfile", "soundevents/voscripts/game_sounds_vo_ogre_magi.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_ogre_magi.vsndevts", context)
    -- Elite enemies
    PrecacheResource("particle", "particles/units/elite/elite_overhead.vpcf", context)
    -- Boss healing mechanic particle
    PrecacheResource("particle", "particles/units/boss/boss_healing.vpcf", context)
    PrecacheResource("particle", "particles/units/boss/boss_teleport.vpcf", context)
    -- Item drops
    PrecacheResource("particle", "particles/items/drop/projectile/item_projectile.vpcf", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_ui_imported.vsndevts", context)
    -- Save npc
    PrecacheResource("soundfile", "soundevents/voscripts/game_sounds_vo_oracle.vsndevts", context)
    -- All enemy abilities
    for _, ability in pairs(Enemies.enemyAbilities) do
        PrecacheItemByNameSync(ability.name, context)
    end
    for _, ability in pairs(Enemies.eliteAbilities) do
        PrecacheItemByNameSync(ability, context)
    end
    -- Every hero sounds/responses
    local heroesData = LoadKeyValues("scripts/npc/herolist.txt")
    local heroesStatsData = LoadKeyValues("scripts/npc/npc_heroes.txt")
    for hero, enabled in pairs(heroesData) do
        if (enabled == 1) then
            PrecacheResource("soundfile", heroesStatsData[hero]["GameSoundsFile"], context)
            PrecacheResource("soundfile", heroesStatsData[hero]["VoiceFile"], context)
        end
    end
end

-- Create the game mode when we activate
function Activate()
    GameRules.GameMode = GameMode()
    GameRules.GameMode:_InitGameMode()
end

LinkLuaModifier("modifier_charges", "generic/modifier_charges", LUA_MODIFIER_MOTION_NONE)