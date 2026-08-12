local AddonName, Addon = ...

-- C_ChallengeMode.GetActiveChallengeMapID() -> MDT index
-- ChallengeMapID: https://wago.tools/db2/MapChallengeMode?page=1

Addon.MDTdungeon = {
-- Midnight
    [557] = 152,-- Windrunner Spire
    [559] = 155,-- Nexus Point Xenas
    [560] = 154,-- Maisara Caverns
    [584] = 162, -- The Blinding Vale
    [585] = 163, -- Voidscar Arena
    [586] = 161, -- Den of Nalorakk
    [587] = 160, -- Murder Row
    [588] = 164, -- Altar of Fangs

-- TWW
    [499] = 115,-- Priory of the Sacred Flame
    [500] = 118,-- The Rookery
    [501] = 110, -- The Stonevault
    [502] = 114, -- City of Threads
    [503] = 113, -- Ara-Kara, City of Echoes
    [504] = 117, -- Darkflame Cleft
    [505] = 111, -- The Dawnbreaker
    [506] = 116, -- Cinderbrew Meadery
    [525] = 119, -- Operation: Floodgate
    [542] = 123, -- Eco-Dome Al'dani

-- DF
    [399] = 42, -- Ruby Life Pools
    [400] = 43, -- The Nokhud Offensive
    [401] = 44, -- The Azure Vault
    [402] = 45, -- Algeth'ar Academy
    [403] = 51, -- Uldaman: Legacy of Tyr
    [404] = 50, -- Neltharus
    [405] = 48, -- Brackenhide Hollow
    [406] = 49, -- Halls Of Infusion
    [463] = 100, -- Dawn Of The Infinite Lower
    [464] = 101, -- Dawn Of The Infinite Upper

-- SL
    [375] = 31, -- Mists Of Tirna Scithe
    [376] = 35, -- The Necrotic Wake
    [377] = 29, -- De Other Side
    [378] = 30, -- Halls of Atonement
    [379] = 32, -- Plaguefall
    [380] = 33, -- Sanguine Depths
    [381] = 34, -- Spires Of Ascension
    [382] = 36, -- Theater Of Pain
    [391] = 37, -- Tazavesh Streets
    [392] = 38, -- Tazavesh Gambit

-- BfA
    [244] = 15, -- Atal Dazar
    [245] = 16, -- Freehold
    [246] = 23, -- Tol Dagor
    [247] = 21, -- The Motherlode
    [249] = 17, -- Kings Rest
    [248] = 102, -- Waycrest Manor
    [250] = 20, -- Temple of Sethraliss
    [251] = 22, -- The Underrot
    [252] = 18, -- Shrine of the Storm
    [353] = 19, -- Siege of Bolarus
    [369] = 25, -- Mechagon Island (Junkyard)
    [370] = 26, -- Mechagon City (Workshop)

-- Legion
    [197] = 5, -- Eye of Azshara
    [198] = 4, -- Darkheart Thicket
    [199] = 1, -- Black Rook Hold
    [200] = 6, -- Halls of Valor
    [206] = 8, -- Neltharions Lair
    [207] = 13, -- Vault of the Wardens
    [208] = 7, -- Maw of Souls
    [209] = 12, -- The Arcway
    [210] = 3, -- Court of Stars
    [227] = 9, -- Karazhan Lower
    [233] = 2, -- Cathedral of Eternal Night
    [234] = 10, -- Karazhan Upper
    [239] = 11, -- Seat of the Triumvirate

-- WoD
    [161] = 151, -- Skyreach
    [165] = 46, -- Shadowmoon Burial Grounds
    [166] = 40, -- Grimrail Depot
    [168] = 104, -- The Everbloom
    [169] = 41, -- Iron Docks

-- Pandaria
    [2] = 47, -- Temple of the Jade Serpent

-- Cataclysm
    [438] = 77, -- The Vortex Pinnacle
    [456] = 105, -- Throne of Tides
    [507] = 112, -- Grim Batol

-- WotLK
    [556] = 150, -- Pit of Saron

-- BC
    [558] = 153, -- Magister's Terrace
}

function Addon:GetForcesFromMDT(npcID, wsave)
    local MDTAPI = _G["MythicDungeonToolsAPI"]
    if not MDTAPI then
        return nil
    end
    npcID = tonumber(npcID)
    local count = MDTAPI:GetEnemyForces(npcID)
    if count ~= nil then
        if wsave then
            IPMTDB[npcID] = count
        end
        return count
    end
    return nil
end

function Addon:MDTHasDB()
    local MDTAPI = _G["MythicDungeonToolsAPI"]
    if MDTAPI and MDTAPI:GetEnemyForces(270306) then
        return true
    end
    return false
end



function Addon:CheckMDTVersion(MDTName)
    local MDTversion = C_AddOns.GetAddOnMetadata(MDTName, 'Version')
    if MDTversion ~= nil and (not IPMTOptions.MDTversion or (IPMTOptions.MDTversion ~= MDTversion)) then
        if Addon:MDTHasDB() then
            IPMTOptions.MDTversion = MDTversion
            IPMTDB = {}
        end
    end
end
