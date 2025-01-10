vim.keymap.set({'n', 'v'}, 'k', 'gk')
vim.keymap.set({'n', 'v'}, 'j', 'gj')

vim.keymap.set('n', '<M-j>', ":m .+1<CR>==")
vim.keymap.set('n', '<M-k>', ":m .-2<CR>==")
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

vim.keymap.set('n', '<leader>wk', '<C-W>k')
vim.keymap.set('n', '<leader>wj', '<C-W>j')
vim.keymap.set('n', '<leader>wh', '<C-W>h')
vim.keymap.set('n', '<leader>wl', '<C-W>l')

vim.keymap.set('n', '<leader>wK', '<C-W>K')
vim.keymap.set('n', '<leader>wJ', '<C-W>J')
vim.keymap.set('n', '<leader>wH', '<C-W>H')
vim.keymap.set('n', '<leader>wL', '<C-W>L')

vim.keymap.set('n', '<C-,>', '<C-W>3<')
vim.keymap.set('n', '<C-.>', '<C-W>3>')
vim.keymap.set('n', '<A-,>', '<C-W>3-')
vim.keymap.set('n', '<A-.>', '<C-W>3+')

vim.keymap.set('n', '<leader>wv', ':vs<CR>')
vim.keymap.set('n', '<leader>ws', ':sp<CR>')

vim.keymap.set('n', '<leader>h', ':bp<CR>')
vim.keymap.set('n', '<leader>l', ':bn<CR>')

vim.keymap.set('n', '<leader>wq', '<C-W>q')
vim.keymap.set('n', '<leader>bk', function() vim.api.nvim_buf_delete(0, {}) end)

vim.keymap.set({'n', 'v'}, '$', '$l')

vim.keymap.set({'i', 'c'}, 'kj', '<esc>')
vim.keymap.set('t', 'kj', '<c-\\><c-n>')

vim.keymap.set('n', 'gl', function()
  local HOME = os.getenv('HOME')

  local current_line = vim.fn.getline('.')

  local filename = ''
  local terminating_quote = ''
  for i = 1, #current_line do
    local char = current_line:sub(i,i)
    if terminating_quote == '' then
      if char == '"' or char == "'" then
        terminating_quote = char
      end
    else
      if char == terminating_quote then
        break
      else
        filename = filename .. char
      end
    end
  end

  filename = HOME .. '/.config/nvim/lua/' .. filename:gsub('%.', '/') .. '.lua'
  vim.api.nvim_cmd({cmd = 'edit', args = {filename}}, {})
end)
