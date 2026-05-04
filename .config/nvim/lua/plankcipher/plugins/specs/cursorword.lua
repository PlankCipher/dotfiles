return {
    'nvim-mini/mini.cursorword',
    event = 'VeryLazy',
    config = function()
        vim.g.minicursorword_disable = false

        vim.api.nvim_create_autocmd('ModeChanged', {
            group = vim.api.nvim_create_augroup('PCMiniCursorWordEnable', { clear = true }),
            pattern = '*',
            callback = function(_)
                if string.find('vV', vim.v.event.new_mode, 1, true) then
                    vim.g.minicursorword_disable = true
                else
                    vim.g.minicursorword_disable = false
                end
            end,
        })

        require('mini.cursorword').setup({ delay = vim.o.updatetime })
    end,
}
