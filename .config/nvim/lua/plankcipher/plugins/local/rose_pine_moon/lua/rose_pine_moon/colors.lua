local M = {}

M.alpha = 0.21

M.blend_fg_and_bg = function(fg, bg, alpha)
    local rgb = function(hex)
        hex = string.lower(hex)
        return { tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16) }
    end

    local blend_channel = function(i)
        local ret = (alpha * rgb(fg)[i] + ((1 - alpha) * rgb(bg)[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format(
        '#%02x%02x%02x',
        blend_channel(1),
        blend_channel(2),
        blend_channel(3)
    )
end

M.blend_with_base = function(fg, alpha)
    return M.blend_fg_and_bg(fg, M.base, alpha and alpha or M.alpha)
end

M.terminal_0  = '#1d1b2c'
M.terminal_1  = '#eb6f92'
M.terminal_2  = '#76b360'
M.terminal_3  = '#f6c177'
M.terminal_4  = '#3e8fb0'
M.terminal_5  = '#c4a7e7'
M.terminal_6  = '#9ccfd8'
M.terminal_7  = '#e0def4'
M.terminal_8  = '#908caa'
M.terminal_9  = '#ef8faa'
M.terminal_10 = '#8bbf78'
M.terminal_11 = '#f8d19b'
M.terminal_12 = '#52a1c2'
M.terminal_13 = '#d7c3ef'
M.terminal_14 = '#b6dce2'
M.terminal_15 = '#f8f7fc'

M.base           = '#1d1b2c'
M.surface        = '#2a273f'
M.overlay        = '#393552'
M.muted          = '#6e6a86'
M.subtle         = '#908caa'
M.text           = '#e0def4'
M.love           = '#eb6f92'
M.gold           = '#f6c177'
M.rose           = '#ea9a97'
M.pine           = '#3e8fb0'
M.foam           = '#9ccfd8'
M.iris           = '#c4a7e7'
M.moss           = '#8ec07c'
M.highlight_low  = '#2a283e'
M.highlight_med  = '#44415a'
M.highlight_high = '#56526e'

return M
