local open_terminal = function(close_on_0_status, command)
    vim.g.pc_close_on_0_status = close_on_0_status
    vim.cmd.terminal({command})
end

vim.keymap.set('n', '<leader>ot', function() open_terminal(true, vim.env.SHELL) end)
vim.keymap.set('n', '<leader>of', function() open_terminal(true, 'ranger') end)
vim.keymap.set('n', '<leader>or', function() open_terminal(false, 'g++ %:p -o %:p:r && %:p:r') end)
