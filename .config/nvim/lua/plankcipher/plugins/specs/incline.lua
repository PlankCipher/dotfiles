return {
    'b0o/incline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
        render = function(props)
            local utils = require('plankcipher.utils')
            local c = require('rose_pine_moon.colors')

            local icon, icon_color, filename
            if vim.bo[props.buf].buftype == 'quickfix' then
                icon, icon_color = '', c.rose
                filename = vim.trim(vim.w[props.win].quickfix_title)
            else
                local filepath = vim.api.nvim_buf_get_name(props.buf)
                local filetype = vim.bo[props.buf].filetype
                icon, icon_color = utils.get_icon_color(filepath, filetype)
                filename = vim.fs.basename(filepath)
                filename = (filename ~= '') and filename or '[No Name]'
            end

            local icon_fg = utils.luminance(icon_color) < 0.6 and c.text or c.base
            local modified = vim.bo[props.buf].modified

            return {
                { ' ', icon, ' ', guibg = icon_color, guifg = icon_fg, gui = 'italic' },
                { ' ', filename, ' ', group = 'InclineNormal' },
                modified and { ' ', group = 'InclineNormal' } or '',
            }
        end,
        window = {
            placement = {
                horizontal = 'right',
                vertical = 'top',
            },
            margin = {
                horizontal = 4,
                vertical = 0,
            },
            overlap = {
                borders = true,
                statusline = false,
                tabline = false,
                winbar = false,
            },
            width = 'fit',
            padding = 0,
            padding_char = ' ',
        },
        ignore = {
            unlisted_buffers = false,
            floating_wins = true,
            filetypes = {},
            buftypes = {},
            wintypes = {},
        },
        hide = {
            cursorline = 'smart',
            focused_win = false,
            only_win = false,
        },
    },
}
