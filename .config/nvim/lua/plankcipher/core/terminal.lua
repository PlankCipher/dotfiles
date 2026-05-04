vim.api.nvim_create_autocmd('TermOpen', {
    pattern = '*',
    callback = function()
        vim.opt_local.fillchars:append({ eob = ' ' })
        vim.opt_local.signcolumn = 'no'
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.colorcolumn = ''
        vim.opt_local.list = false
        vim.opt_local.spell = false

        vim.b.pc_close_on_0_status = vim.g.pc_close_on_0_status
        vim.g.pc_close_on_0_status = nil

        vim.cmd.startinsert()
    end,
})

vim.api.nvim_create_autocmd('TermClose', {
    pattern = '*',
    callback = function(event)
        if vim.v.event.status == 0 and vim.b.pc_close_on_0_status then
            vim.api.nvim_buf_delete(event.buf, {})
            vim.cmd.match({'TrailingWhitespace', [[/\s\+$/]]})
        end
    end,
})
