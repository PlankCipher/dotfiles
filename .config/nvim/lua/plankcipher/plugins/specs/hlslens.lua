return {
    'kevinhwang91/nvim-hlslens',
    event = 'VeryLazy',
    opts = {
        auto_enable = true,
        enable_incsearch = true,
        calm_down = false,
        nearest_only = true,
        nearest_float_when = 'never',
        float_shadow_blend = 0,
        override_lens = function(render, posList, nearest, idx, _)
            local utils = require('plankcipher.utils')

            if not nearest then return end

            local search_pattern = vim.fn.getcmdline() ~= '' and vim.fn.getcmdline() or vim.fn.getreg('/')

            local search_type = vim.fn.getcmdtype()
            search_type = search_type ~= '' and search_type or (vim.v.searchforward == 1 and '/' or '?')

            local padding = string.rep(' ', utils.virt_text_opts.padding)
            local margin = string.rep(' ', utils.virt_text_opts.margin)

            local text = string.format('%s󰍉 %s%s %d/%d%s', padding, search_type, search_pattern, idx, #posList, padding)
            local chunks = { { margin }, { text, 'HlSearchLensNear' } }
            local lnum, col = unpack(posList[idx])
            render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end,
    },
}
