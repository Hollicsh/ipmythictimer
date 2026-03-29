local AddonName, Addon = ...

local function toggleOptions()
    Addon:ShowOptions()
end

----------------------------------------------------------------
-- Tooltip komplett deaktiviert (Retail Secure Changes)
-- Keine TooltipDataProcessor Nutzung mehr!
----------------------------------------------------------------


----------------------------------------------------------------
-- DEBUG
----------------------------------------------------------------
local debugLines = {}

local function PrintDebug()
    local text = table.concat(debugLines, "\n")

    if not Addon.fDebug:IsShown() then
        Addon.fDebug:Show()
    end

    Addon.fDebug.textarea:SetText(text)
end

function Addon:ClearDebug()
    wipe(debugLines)
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

    DEFAULT_CHAT_FRAME:AddMessage(Addon.localization.STARTINFO)
end

Addon:StartAddon()
