local AddonName, Addon = ...

Addon.DECOR_FONT = Addon.FONT_ROBOTO
Addon.DECOR_FONTSIZE_DELTA = 0
if GetLocale() == "zhTW" or GetLocale() == "zhCN" then
    Addon.DECOR_FONT = "Arial"
    Addon.DECOR_FONTSIZE_DELTA = -2
end

function Addon:Round(number, decimals)
    return (("%%.%df"):format(decimals)):format(number)
end

Addon.backdrop = {
    bgFile   = "Interface\\Buttons\\WHITE8X8",
    edgeFile = nil,
    tile     = true,
    tileSize = 32,
}

function Addon:StartDragging(self, button)
    self:StartMoving()
    self.isMoving = true
end

function Addon:StopDragging(self, button)
    self:StopMovingOrSizing()
    self.isMoving = false
end

function Addon:PrintObject(data, prefix, toText)
    local text = ''
    if prefix == nil then
        prefix = ''
    end
    for key,value in pairs(data) do
        if value == nil then
            text = text .. prefix .. key .. " = nil\n"
        elseif type(value) == 'table' then
            text = text .. Addon:PrintObject(value, prefix .. key .. '.', toText) .. "\n"
        elseif type(value) == 'boolean' then
            if value then
                text = text .. prefix .. key .. " = true\n"
            else
                text = text .. prefix .. key .. " = false\n"
            end
        else
            text = text .. prefix .. key .. " = " .. value .. "\n"
        end
    end
    if toText then
        return text
    else
        print(text)
    end
end

