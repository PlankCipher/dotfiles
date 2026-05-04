return {
    'rmagatti/goto-preview',
    dependencies = { 'rmagatti/logger.nvim' },
    keys = {
        { 'gpd', '<Cmd>lua require("goto-preview").goto_preview_definition()<CR>' },
        { 'gpt', '<Cmd>lua require("goto-preview").goto_preview_type_definition()<CR>' },
        { 'gpi', '<Cmd>lua require("goto-preview").goto_preview_implementation()<CR>' },
    },
    opts = function()
        local utils = require('plankcipher.utils')
        local goto_preview = require('goto-preview')
        local treesitter_context = require('treesitter-context')

        local saved_opts = nil
        local OPTS = {
            fillchars = vim.wo.fillchars .. ',eob: ',
            signcolumn = 'no',
            number = true,
            numberwidth = 1,
            relativenumber = false,
            colorcolumn = '',
            list = false,
            winhighlight = utils.float_win_opts.winhighlight .. ',FloatTitle:TelescopeTitle',
        }

        local post_open_hook = function(buf, win)
            if vim.w.pc_goto_preview_is_set_up then return end

            local cur_title = vim.api.nvim_win_get_config(win).title[1][1]
            local icon, _ = utils.get_icon_color(cur_title, vim.bo[buf].filetype)
            vim.api.nvim_win_set_config(win, {
                title = string.format(' %s %s ', icon, cur_title)
            })

            if not saved_opts then
                saved_opts = {}
                for opt, _ in pairs(OPTS) do
                    saved_opts[opt] = vim.wo[win][opt]
                end
            end

            for opt, val in pairs(OPTS) do
                vim.wo[win][opt] = val
            end

            treesitter_context.disable()
            vim.lsp.inlay_hint.enable(false)

            local close = function()
                if saved_opts then
                    for opt, _ in pairs(OPTS) do
                        vim.wo[opt] = saved_opts[opt]
                    end
                end
                saved_opts = nil

                treesitter_context.enable()
                vim.lsp.inlay_hint.enable(true)

                vim.keymap.del('n', 'q',     { buffer = buf })
                vim.keymap.del('n', '<Esc>', { buffer = buf })

                goto_preview.close_all_win()
            end

            vim.keymap.set('n', 'q',     close, { buffer = buf })
            vim.keymap.set('n', '<Esc>', close, { buffer = buf })

            vim.w.pc_goto_preview_is_set_up = true
        end

        return {
            width = 120,
            height = 25,
            border = utils.float_win_opts.border,
            default_mappings = false,
            debug = false,
            opacity = 0,
            resizing_mappings = false,
            focus_on_open = true,
            dismiss_on_move = false,
            force_close = true,
            bufhidden = 'wipe',
            stack_floating_preview_windows = true,
            same_file_float_preview = true,
            preview_window_title = { enable = true, position = 'right' },
            vim_ui_input = false,
            post_open_hook = post_open_hook,
        }
    end,
}
