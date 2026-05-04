return {
    'kenzo-pj/boundary.nvim',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    config = function()
        local markers = require('boundary.markers')
        local utils = require('plankcipher.utils')

        local padding = string.rep(' ', utils.virt_text_opts.padding)
        local marker_text = string.format("%s󰜈 'use client'%s", padding, padding)
        local marker_hl_group = 'BoundaryMarker'
        local set_extmark = function(orig_set_extmark, buffer, ns_id, line, col, opts)
            opts.virt_text = {
                { string.rep(' ', utils.virt_text_opts.margin) },
                { marker_text, marker_hl_group }
            }
            orig_set_extmark(buffer, ns_id, line, col, opts)
        end

        local orig_apply = markers.apply
        markers.apply = function(...)
            local orig_set_extmark = vim.api.nvim_buf_set_extmark
            vim.api.nvim_buf_set_extmark = function(...) set_extmark(orig_set_extmark, ...) end
            orig_apply(...)
            vim.api.nvim_buf_set_extmark = orig_set_extmark
        end

        local orig_set = markers.set
        markers.set = function(...)
            local orig_set_extmark = vim.api.nvim_buf_set_extmark
            vim.api.nvim_buf_set_extmark = function(...) set_extmark(orig_set_extmark, ...) end
            orig_set(...)
            vim.api.nvim_buf_set_extmark = orig_set_extmark
        end

        require('boundary').setup({
            marker_text = marker_text,
            marker_hl_group = marker_hl_group,
            hover_only = false,
            auto = true,
        })
    end,
}
