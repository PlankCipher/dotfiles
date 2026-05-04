return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = { ':TSInstall all', ':TSUpdate' },
    config = function()
        vim.cmd.syntax({'off'})

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('PCTreeSitterSetup', { clear = true }),
            pattern = '*',
            callback = function(e)
                local buf = e.buf
                local ft = vim.bo[buf].filetype
                local lang = vim.treesitter.language.get_lang(ft) or ft
                if vim.treesitter.language.add(lang) then
                    vim.treesitter.start(buf, lang)
                    vim.bo[buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
                end
            end,
        })
    end,
}
