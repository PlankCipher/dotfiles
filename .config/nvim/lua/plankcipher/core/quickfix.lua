local utils = require('plankcipher.utils')

local extract_item_info = function(item)
    local shorten_filepath = function(qfitem)
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(qfitem.bufnr) , ':~:.')
    end

    local filepath         = item.bufnr > 0 and shorten_filepath(item) or ''
    local icon, icon_color = utils.get_icon_color(vim.fs.basename(filepath), nil)
    local line, col        = item.lnum, item.col
    local text             = vim.trim(item.text)

    return icon, icon_color, filepath, line, col, text
end

local construct_display_lines = function(qflist, first, last)
    local lines = {}

    for i = first, last do
        local item = qflist.items[i]
        local icon, _, filepath, line, col, text = extract_item_info(item)

        local res = ''
        res = res .. (filepath ~= '' and (icon .. ' ' .. filepath)            or '')
        res = res .. (line > 0       and ((res ~= '' and ':'  or '') .. line) or '')
        res = res .. (col  > 0       and ((res ~= '' and ':'  or '') .. col ) or '')
        res = res .. (text ~= ''     and ((res ~= '' and ': ' or '') .. text) or '')

        table.insert(lines, res)
    end

    return lines
end

local colorize = function(qflist, first, last)
    local highlight_range = function(cur, len, hl)
        vim.hl.range(
            qflist.qfbufnr,
            vim.api.nvim_create_namespace('pc_quickfix'), hl,
            { cur.line, cur.col       },
            { cur.line, cur.col + len },
            { regtype = 'v' }
        )

        return { line = cur.line, col = cur.col + len }
    end

    local make_icon_hl = function(icon_color)
        local icon_hl = 'PCQuickFixIcon' .. icon_color:sub(2, -1)
        vim.api.nvim_set_hl(0, icon_hl, { fg = icon_color })
        return icon_hl
    end

    local text_hl = function(type)
        local type_highlights = {
            ['E'] = 'QuickFixError',
            ['W'] = 'QuickFixWarning',
            ['I'] = 'QuickFixInfo',
            ['H'] = 'QuickFixHint',
        }
        return type_highlights[string.upper(type)] or 'Normal'
    end

    vim.wo[qflist.winid].spell = false

    local cur = { line = 0, col = 0 }
    for i = first, last do
        local item = qflist.items[i]
        local icon, icon_color, filepath, line, col, text = extract_item_info(item)

        if filepath == '' then
            cur = highlight_range(cur, #text, 'QuickFixNoise')
        else
            cur = highlight_range(cur, #icon + 1,       make_icon_hl(icon_color))
            cur = highlight_range(cur, #filepath,       'QuickFixFilePath'      )
            cur = highlight_range(cur, 1,               'QuickFixSep'           )
            cur = highlight_range(cur, #tostring(line), 'QuickFixLineCol'       )
            cur = highlight_range(cur, 1,               'QuickFixSep'           )
            cur = highlight_range(cur, #tostring(col),  'QuickFixLineCol'       )
            cur = highlight_range(cur, 1 + 1,           'QuickFixSep'           )
            cur = highlight_range(cur, #text,           text_hl(item.type)      )
        end

        cur = { line = cur.line + 1, col = 0 }
    end
end

_G.pc_quickfixtextfunc = function(info)
    if info.quickfix ~= 1 then return {} end

    local qflist = vim.fn.getqflist({
        id      = info.id,
        items   = true,
        qfbufnr = true,
        winid   = true,
    })
    local first, last = info.start_idx, info.end_idx

    local display_lines = construct_display_lines(qflist, first, last)
    vim.schedule(function() colorize(qflist, first, last) end)

    return display_lines
end

vim.o.quickfixtextfunc = '{ info -> v:lua._G.pc_quickfixtextfunc(info) }'
