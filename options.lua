local AddonName, Addon = ...

local LSM = LibStub("LibSharedMedia-3.0")

function Addon:CleanDB()
    IPMTDB = {}
    print(Addon.localization.DBCLEANED)
end
function Addon:ToggleDBTooltip(self, show)
    if show then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(Addon.localization.CLEANDBTT, .9, .9, 0, 1, true)
        GameTooltip:Show()
    else
        GameTooltip:Hide()
    end
end

function Addon:ToggleKeyRenameTooltip(self, show)
    if show then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(Addon.localization.RNMKEYSTT, .9, .9, 0, 1, true)
        GameTooltip:Show()
    else
        GameTooltip:Hide()
    end
end

function Addon:SetScale(value)
    IPMTOptions.scale = value
    Addon.fMain:SetScale(1 + IPMTOptions.scale / 100)
    Addon.fOptions.scale.Text:SetText(Addon.localization.SCALE .. " (" .. (IPMTOptions.scale + 100) .. "%)")
end

function Addon:SetProgressFormat(value)
    if IPMTOptions.progress ~= value then
        IPMTOptions.progress = value
        if not IPMTDungeon.keyActive then
            for i, info in ipairs(Addon.frames) do
                if info.label == 'progress' or info.label == 'prognosis' then
                    Addon.fMain[info.label].text:SetText(info.dummy.text[IPMTOptions.progress])
                end
            end
        else
            Addon:UpdateProgress()
        end
        if Addon.season.ShowTimer then
            Addon.season:ShowTimer()
        end
    end
end

function Addon:SetProgressDirection(value)
    if IPMTOptions.direction ~= value then
        IPMTOptions.direction = value
        if IPMTDungeon.keyActive then
            Addon:UpdateProgress()
        end
    end
end

function Addon:SetTimerDirection(value)
    if IPMTOptions.timerDir ~= value then
        IPMTOptions.timerDir = value
        Addon:RenderTimerbar()
    end
end

function Addon:SetLimitProgress(value)
    if IPMTOptions.limitProgress ~= value then
        IPMTOptions.limitProgress = value
        if IPMTDungeon.keyActive then
            Addon:UpdateProgress()
        end
    end
end

function Addon:ToggleOptions()
    if Addon.opened.options then
        Addon:CloseOptions()
    else
        Addon:ShowOptions()
    end
end
function Addon:ToggleMapButton(show)
    local icon = LibStub("LibDBIcon-1.0")
    Addon.DB.global.minimap.hide = not show
    if not Addon.DB.global.minimap.hide then
        icon:Show("IPMythicTimer")
    else
        icon:Hide("IPMythicTimer")
    end
end

function Addon:ShowOptions()
    if Addon.opened.options then
        return
    end
    Addon.opened.options = true
    if Addon.fOptions == nil then
        Addon:RenderOptions()
    end

    Addon.fOptions:Show()
    Addon.fMain:Show()
    Addon.fMain:SetMovable(true)
    Addon.fMain:EnableMouse(true)

    Addon:FillDummy(true)

    if Addon.season.options and Addon.season.options.ShowOptions then
        Addon.season.options:ShowOptions()
    end
end

function Addon:CloseOptions()
    if not Addon.opened.options then
        return
    end
    Addon.opened.options = false
    Addon:CloseThemeEditor()
    Addon:CloseImport()
    Addon.fMain:SetMovable(false)
    Addon.fMain:EnableMouse(false)
    if not IPMTDungeon.keyActive then
        Addon.fMain:Hide()
    end
    if IPMTDungeon.deathes and IPMTDungeon.deathes.list == nil or #IPMTDungeon.deathes.list == 0 then
        Addon.fMain.deathTimer:Hide()
    end
    Addon.fMain.timer:EnableMouse(true)
    Addon.fMain.deathTimer:EnableMouse(true)
    Addon.fMain.bosses:EnableMouse(true)
    Addon.fOptions:Hide()
    Addon:HideHelp()
    Addon:CloseKeyRename()
end

function Addon:InitOptions()
    local globalVars = nil
    if IPMTOptions ~= nil and IPMTOptions.global then
        globalVars = IPMTOptions.global
    end
    local keysName = nil
    if IPMTOptions ~= nil and IPMTOptions.keysName then
        keysName = IPMTOptions.keysName
    end
    local news = nil
    if IPMTOptions ~= nil and IPMTOptions.news then
        news = IPMTOptions.news
    end

    IPMTOptions = Addon:CopyObject(Addon.defaultOption, IPMTOptions)
    if globalVars ~= nil then
        IPMTOptions.global = globalVars
    end
    if news ~= nil then
        IPMTOptions.news = news
    end
    if keysName ~= nil then
        IPMTOptions.keysName = keysName
    end
    if IPMTTheme[IPMTOptions.theme] == nil then
        IPMTOptions.theme = 1
    end
end

function Addon:ThemeAction(action)
    if action == Addon.THEME_ACTIONS_COPY then
        Addon:DuplicateTheme(IPMTTheme[IPMTOptions.theme])
    elseif action == Addon.THEME_ACTIONS_IMPORT then
        Addon:ShowImport()
    elseif action == Addon.THEME_ACTIONS_EXPORT then
        Addon:ShowExport()
    else
        Addon:DuplicateTheme(IPMTTheme[1])
    end
end

function Addon:DuplicateTheme(theme, import)
    local newTheme = Addon:CopyObject(theme)
    local source = Addon.localization.COPY
    if import == true then
        source = Addon.localization.IMPORT
    end
    newTheme.name = newTheme.name .. " (" .. source .. ")"
    table.insert(IPMTTheme, newTheme)
    Addon.fOptions.theme:SelectItem(#IPMTTheme)
end

function Addon:ApplyTheme(themeID)
    IPMTOptions.theme = themeID
    local theme = IPMTTheme[IPMTOptions.theme]

    Addon:ChangeDecor('main', theme.main, true)
    for i, info in ipairs(Addon.frames) do
        local frame = info.label
        local elemInfo = theme.elements[frame]
        Addon:MoveElement(frame, nil, true)
        if info.canResize then
            Addon:SetSize(frame, elemInfo.size.w, elemInfo.size.h)
        end
        if elemInfo.fontSize ~= nil then
            Addon:SetFontSize(frame, elemInfo.fontSize, true)
            Addon:SetJustifyH(frame, elemInfo.justifyH, true)
            if elemInfo.justifyV then
                Addon:SetJustifyV(frame, elemInfo.justifyV, true)
            end
            if elemInfo.color ~= nil then
                if elemInfo.color.r ~= nil then
                    Addon:SetColor(frame, elemInfo.color, nil, true)
                else
                    Addon:SetColor(frame, elemInfo.color[0], nil, true)
                end
            end
        end
        if elemInfo.iconSize then
            Addon:SetIconSize(frame, elemInfo.iconSize, true)
        end
        if elemInfo.hidden then
            Addon.fMain[frame]:Hide()
        else
            Addon.fMain[frame]:Show()
            if frame ~= 'timerbar' then
                Addon.fMain[frame]:SetBackdropColor(1,1,1, 0)
            end
        end
    end
    Addon:SetFont(theme.font, true)
    Addon:SetFontStyle(theme.fontStyle, true)
    Addon:SetDeathsFontStyle(theme.deaths.fontStyle, true)
    for decorID, info in ipairs(theme.decors) do
        Addon:RenderDecor(decorID)
    end
    for decorID = #theme.decors+1, #Addon.fMain.decors do
        Addon.fMain.decors[decorID]:Hide()
    end
    if Addon.opened.themes then
        Addon:FillThemeEditor()
    end
    if Addon.fOptions ~= nil then
        Addon.fOptions.removeTheme:ToggleDisabled(IPMTOptions.theme == 1)
    end
    Addon.themeApplying = false
end

function Addon:RemoveTheme(themeID)
    if themeID == 1 then
        return
    end
    table.remove(IPMTTheme, themeID)
    Addon.fOptions.theme:SelectItem(1)
end

function Addon:RestoreDefaultTheme()
    IPMTTheme[1] = Addon:CopyObject(Addon.theme[1])
    Addon.fOptions.theme:SelectItem(1)
end