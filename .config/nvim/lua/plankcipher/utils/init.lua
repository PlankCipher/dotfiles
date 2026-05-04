local utils = {}

utils.file_extension = function(filename)
    local parts = vim.split(filename, '%.')
    if #parts > 2 then
        return table.concat(vim.list_slice(parts, #parts - 1), '.')
    else
        return table.concat(vim.list_slice(parts, #parts), '.')
    end
end

utils.luminance = function(hex)
    local r = tonumber(hex:sub(2, 3), 16) / 255
    local g = tonumber(hex:sub(4, 5), 16) / 255
    local b = tonumber(hex:sub(6, 7), 16) / 255
    return 0.2126*r + 0.7152*g + 0.0722*b
end

utils.get_icon_color = function(filepath, filetype)
    local devicons = require('nvim-web-devicons')

    local filename = vim.fs.basename(filepath)
    local extension = utils.file_extension(filename)

    local icon, icon_color = devicons.get_icon_color(filename, extension, { default = false })
    if not icon then
        icon, icon_color = devicons.get_icon_color_by_filetype(filetype, { default = true })
    end

    return icon, icon_color
end

utils.merge_lists = function(a, b)
    local res = {}

    for i=1, #a do
        res[i] = a[i]
    end

    for i=1, #b do
        res[i + #a] = b[i]
    end

    return res
end

utils.float_win_opts = {
    min_width = 20,
    max_width = 80,
    max_height = 25,
    border = { '▄', '▄', '▄', '█', '▀', '▀', '▀', '█' },
    winhighlight = 'Normal:NoBorderNormalFloat,FloatBorder:NoBorderFloatBorder,CursorLine:NoBorderFloatSel,Search:None',
    wrap = true,
    focusable = true,
    focus = true,
    offset_x = -1,
    relative = 'cursor',
    anchor_bias = 'auto',
}

utils.virt_text_opts = {
    margin = 3,
    padding = 1,
}

return utils
