return {
    'petertriho/nvim-scrollbar',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
        local scrollbar = require('scrollbar')
        local config = require('scrollbar.config')
        local utils = require('scrollbar.utils')
        local putils = require('plankcipher.utils')

        scrollbar.setup({
            show = true,
            show_in_active_only = false,
            set_highlights = false,
            folds = true,
            max_lines = false,
            hide_if_all_visible = true,
            throttle_ms = 100,
            handle = {
                text = '▍',
                blend = 0,
                hide_if_all_visible = true,
            },
            excluded_buftypes = {},
            excluded_filetypes = putils.merge_lists(config.get().excluded_filetypes, {
                'blink-cmp-menu',
                'blink-cmp-documentation',
                'blink-cmp-signature',
                'TelescopePrompt',
                'noice',
            }),
            handlers = {
                handle = true,
                cursor = false,
                diagnostic = false,
                gitsigns = false,
                search = false,
                ale = false,
            },
        })

        utils.show()
    end,
}
