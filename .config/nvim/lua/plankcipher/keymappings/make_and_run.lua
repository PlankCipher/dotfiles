local MAKEPRG_NOT_SET = [[for _ in {0..4}; do echo YOU DIDN\'t SET MAKEPRG; done && exit 1]]
vim.o.makeprg = MAKEPRG_NOT_SET

vim.keymap.set('n', '<leader>,', function()
    local makeprg = vim.fn.input('makeprg: ')
    vim.o.makeprg = (makeprg ~= '') and makeprg or MAKEPRG_NOT_SET
end)
vim.keymap.set('n', '<leader>,,', '<Cmd>make<CR>')

local RUNPRG_NOT_SET = [[for _ in {0..4}; do echo YOU DIDN\'t SET RUNPRG; done && exit 1]]
local runprg = RUNPRG_NOT_SET

vim.keymap.set('n', '<leader>.', function()
    runprg = vim.fn.input('runprg: ')
    runprg = (runprg ~= '') and runprg or RUNPRG_NOT_SET
end)

local run_in_terminal = function()
    vim.g.pc_close_on_0_status = false
    vim.cmd.terminal({ runprg })
end

vim.keymap.set('n', '<leader>..', run_in_terminal)

vim.keymap.set('n', '<leader>,.', function()
    vim.cmd.make()

    if vim.v.shell_error == 0 and #vim.fn.getqflist() == 0 then
        run_in_terminal()
    end
end)

vim.keymap.set('n', '<leader>,p', '<Cmd>cp<CR>')
vim.keymap.set('n', '<leader>,n', '<Cmd>cn<CR>')

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
    group = vim.api.nvim_create_augroup('PCMakeAndRun', { clear = true }),
    pattern = 'make',
    command = 'cwindow 25',
})
