return {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    config = function()
        local c = require('rose_pine_moon.colors')

        require('nvim-web-devicons').setup({
            color_icons = true,
            default = false,
            strict = true,
            variant = 'dark',
            blend = 0,
            override_by_filename = {
                ['send help plz'] = {
                    icon = '',
                    color = c.gold,
                    name = 'Dashboard'
                },
                ['Telescope'] = {
                    icon = '󰭎',
                    color = c.foam,
                    name = 'Telescope'
                },
                ['Lazy'] = {
                    icon = '',
                    color = c.moss,
                    name = 'Lazy'
                },
                ['Netrw'] = {
                    icon = '',
                    color = c.pine,
                    name = 'Netrw'
                },
            },
        })

        local filetype_name_mappings = {
            { filetype = 'TelescopePrompt', name = 'Telescope' },
            { filetype = 'lazy',            name = 'Lazy'      },
            { filetype = 'netrw',           name = 'Netrw'     },
        }

        for _, mapping in ipairs(filetype_name_mappings) do
            vim.api.nvim_create_autocmd('FileType', {
                pattern = mapping.filetype,
                callback = function(e)
                    vim.api.nvim_buf_set_name(e.buf, mapping.name)
                end,
            })
        end
    end,
}
