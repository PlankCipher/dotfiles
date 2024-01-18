-- Automatically open/close quickfix window
-- based on errors output from `:make` command
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'make',
  nested = true,
  command = 'cwindow 20',
})

-- Make (compile) and navigate errors/warnings
vim.keymap.set('n', '<leader>,',  function()
  vim.opt.makeprg = vim.fn.input('makeprg: ')
end)
vim.keymap.set('n', '<leader>,,', ':make<CR>')
vim.keymap.set('n', '<leader>,p', ':cp<CR>')
vim.keymap.set('n', '<leader>,n', ':cn<CR>')

-- Run
local runprg_not_set = 'echo "YOU DIDN\'T SET RUNPRG" && exit 1'
local runprg = runprg_not_set

vim.keymap.set('n', '<leader>.', function()
  runprg = vim.fn.input('runprg: ')
  runprg = (runprg ~= '') and runprg or runprg_not_set
end)

local run_in_terminal = function()
  vim.g.close_on_0_status = false
  vim.api.nvim_cmd({cmd = 'te', args = {runprg}}, {})
end

vim.keymap.set('n', '<leader>..', function() run_in_terminal() end)

-- Make and Run
vim.keymap.set('n', '<leader>,.', function()
  vim.api.nvim_cmd({cmd = 'make'}, {})

  -- Only run if there were no errors making
  if vim.v.shell_error == 0 then
    run_in_terminal()
  end
end)
