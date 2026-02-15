local AddonName, Addon = ...

local function toggleOptions()
    Addon:ShowOptions()
end

----------------------------------------------------------------
-- Tooltip handler (SECURE / DF+ SAFE)
----------------------------------------------------------------
local function OnTooltipSetUnit(tooltip, data)
    -- Kein aktiver Key → nichts tun
    if not IPMTDungeon or not IPMTDungeon.keyActive then
        return
    end

    -- Keine Trashdaten
    if not IPMTDungeon.trash or IPMTDungeon.trash.total <= 0 then
        return
    end

    -- TooltipData prüfen (DF+ Weg)
    if not data or not data.guid then
        return
    end

    local guid = data.guid
    local npcID = select(6, strsplit("-", guid))
    if not npcID then
        return
    end

    local npcInfo

    -- OPTIONAL: Season / Nameplate Info
    -- Nameplates nur nutzen, wenn erlaubt
    if Addon.season and Addon.season.GetInfoByNamePlate then
        local unit = data.unit
        if unit and type(unit) == "string" and unit:match("^nameplate") then
            npcInfo = Addon.season:GetInfoByNamePlate(unit)
        end
    end

    -- Enemy Forces anzeigen
    if not npcInfo then
        local percent = Addon:GetEnemyForces(npcID)
        if percent then
            if IPMTOptions.progress == Addon.PROGRESS_FORMAT_PERCENT then
                percent = percent .. "%"
            end
            tooltip:AddDoubleLine("|cFFEEDE70" .. percent)
        end
    end

    -- Zusatz-Tooltip aus Season
    if npcInfo and npcInfo.tooltip then
        tooltip:AddLine(npcInfo.tooltip)
    end
end

----------------------------------------------------------------
-- DEBUG (unverändert, nur aufgeräumt)
----------------------------------------------------------------
local debugLines = {}

local function PrintDebug()
    local text = ""
    for i, line in ipairs(debugLines) do
        text = text .. line .. "\n"
    end

    if not Addon.fDebug:IsShown() then
        Addon.fDebug:Show()
        print("debug")
    end

    Addon.fDebug.textarea:SetText(text)
end

function Addon:ClearDebug()
    debugLines = {}
    PrintDebug()
end

function Addon:AddDebug(text)
    if #debugLines >= 17 then
        table.remove(debugLines, 1)
    end
    table.insert(debugLines, text)
    PrintDebug()
end

----------------------------------------------------------------
-- ADDON START
----------------------------------------------------------------
function Addon:StartAddon()
    SLASH_IPMTOPTS1 = "/ipmt"
    SLASH_IPMTDEBUG1 = "/ipmt_debug"

    SlashCmdList["IPMTOPTS"] = toggleOptions
    SlashCmdList["IPMTDEBUG"] = PrintDebug

    Addon.fMain:RegisterEvent("ADDON_LOADED")
    Addon.fMain:RegisterEvent("CHALLENGE_MODE_DEATH_COUNT_UPDATED")
    Addon.fMain:RegisterEvent("CHALLENGE_MODE_COMPLETED")
    Addon.fMain:RegisterEvent("CHALLENGE_MODE_RESET")
    Addon.fMain:RegisterEvent("PLAYER_ENTERING_WORLD")
    Addon.fMain:RegisterEvent("CHALLENGE_MODE_KEYSTONE_RECEPTABLE_OPEN")
    Addon.fMain:RegisterEvent("VARIABLES_LOADED")

    -- SECURE Tooltip Hook (DF+)
    TooltipDataProcessor.AddTooltipPostCall(
        Enum.TooltipDataType.Unit,
        OnTooltipSetUnit
    )

    DEFAULT_CHAT_FRAME:AddMessage(Addon.localization.STARTINFO)
end

Addon:StartAddon()
