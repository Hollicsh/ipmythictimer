local AddonName, Addon = ...

local STONEBORN_ID = 174175
local STONEBORN_SPELL = 342171

local DEVOURING_MAGGOT_ID = 134024
local DEVOURING_MAGGOT_SPELL = 278444

local UnitExists = UnitExists
local UnitCanAttack = UnitCanAttack
local UnitIsDead = UnitIsDead
local UnitThreatSituation = UnitThreatSituation
local UnitPlayerControlled = UnitPlayerControlled
local UnitAffectingCombat = UnitAffectingCombat

function Addon:GetNameplateInfo(nameplate)
    local unitName, unitExists = nil, nil
    if nameplate and nameplate.UnitFrame then
        unitExists = nameplate.UnitFrame.unitExists
        unitName = nameplate.UnitFrame.displayedUnit
    end
    return unitName, unitExists
end

local function GrabPrognosis()
    local inCombat = false
    if UnitAffectingCombat("player") then
        inCombat = true
    else
        for i=1,4 do
            local unit = "party" .. i
            if UnitExists(unit) and UnitAffectingCombat(unit) then
                inCombat = true
                break
            end
        end
    end

    if inCombat then
        for _, nameplate in pairs(C_NamePlate.GetNamePlates()) do
            local unitName, unitExists = Addon:GetNameplateInfo(nameplate)

            if unitExists and unitName and UnitCanAttack("player", unitName) and not UnitIsDead(unitName) then
                local threat = UnitThreatSituation("player", unitName) or -1

                local allow = false
                if threat >= 0 then
                    allow = true
                else
                    local targetUnit = unitName .. "target"
                    if UnitExists(targetUnit) and UnitPlayerControlled(targetUnit) then
                        allow = true
                    end
                end

                if allow then
                    local npcID = nil

                    if Addon.GetNPCIDFromUnit then
                        npcID = Addon:GetNPCIDFromUnit(unitName)
                    end

                    if npcID then
                        local npcUID = unitName -- fallback unique key

                        if not IPMTDungeon.checkmobs[npcUID] and not IPMTDungeon.prognosis[npcUID] then
                            local forces = Addon:GetEnemyForces(npcID, Addon.PROGRESS_FORMAT_FORCES)
                            if forces then
                                IPMTDungeon.prognosis[npcUID] = forces
                            end
                        end
                    end
                end
            end
        end
    else
        IPMTDungeon.prognosis = {}
    end
end

function Addon:ShowPrognosis()
    GrabPrognosis()

    local prognosis = 0
    for _, percent in pairs(IPMTDungeon.prognosis) do
        if percent then
            prognosis = prognosis + percent
        end
    end

    if prognosis > 0 then
        local progress = IPMTDungeon.trash.current + prognosis

        if Addon.season and Addon.season.isActive and Addon.season.Prognosis then
            Addon.season:Prognosis(progress)
        end

        if IPMTOptions.progress == Addon.PROGRESS_FORMAT_PERCENT then
            progress = progress / IPMTDungeon.trash.total * 100
            if IPMTOptions.limitProgress then
                progress = math.min(100, progress)
            end
            if IPMTOptions.direction == Addon.PROGRESS_DIRECTION_DESC then
                progress = 100 - progress
            end
            Addon.fMain.prognosis.text:SetFormattedText("%.2f%%", progress)
        else
            if IPMTOptions.direction == Addon.PROGRESS_DIRECTION_ASC then
                if IPMTOptions.limitProgress then
                    progress = math.min(progress, IPMTDungeon.trash.total)
                end
            else
                if IPMTOptions.limitProgress then
                    progress = math.max(IPMTDungeon.trash.total - progress, 0)
                else
                    progress = IPMTDungeon.trash.total - progress
                end
            end
            Addon.fMain.prognosis.text:SetText(progress)
        end
        Addon.fMain.prognosis:Show()
    elseif not Addon.opened.themes then
        Addon.fMain.prognosis:Hide()
    end
end

function Addon:PrognosisCheck()
    local _, event, _, sourceGUID, _, _, _, destGUID, _, _, _, spellId =
        CombatLogGetCurrentEventInfo()

    if event == "SPELL_AURA_APPLIED" then
        if sourceGUID then
            local _, _, _, _, _, npcID, spawnID = strsplit("-", sourceGUID)
            -- Devouring Maggot applied "Infest" and despawn (no more give force)
            if tonumber(npcID) == DEVOURING_MAGGOT_ID and tonumber(spellId) == DEVOURING_MAGGOT_SPELL then
                if spawnID then
                    local npcUID = spawnID .. "_" .. npcID
                    IPMTDungeon.prognosis[npcUID] = 0
                    IPMTDungeon.checkmobs[npcUID] = true
                end
                return
            end
        end

        if destGUID then
            local _, _, _, _, _, npcID, spawnID = strsplit("-", destGUID)
            -- Loyal Stoneborn mind control by Ventyr's
            if tonumber(npcID) == STONEBORN_ID and tonumber(spellId) == STONEBORN_SPELL then
                if spawnID then
                    local npcUID = spawnID .. "_" .. npcID
                    IPMTDungeon.prognosis[npcUID] = 0
                    IPMTDungeon.checkmobs[npcUID] = true
                end
                return
            end
        end
    end
end