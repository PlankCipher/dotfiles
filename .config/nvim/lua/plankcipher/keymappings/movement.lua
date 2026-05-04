vim.keymap.set({'n', 'v'}, 'k', 'gk')
vim.keymap.set({'n', 'v'}, 'j', 'gj')

vim.keymap.set('n', '<M-k>', "<Cmd>m .-2<CR>==")
vim.keymap.set('n', '<M-j>', "<Cmd>m .+1<CR>==")
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv")

vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

vim.keymap.set({'n', 'v'}, '$', '$l')

vim.keymap.set({'i', 'c'}, 'kj', '<Esc>')
vim.keymap.set('t', 'kj', '<C-\\><C-N>')

vim.keymap.set('c', '<C-h>', '<Left>')
vim.keymap.set('c', '<C-l>', '<Right>')
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')
vim.keymap.set('c', '<M-h>', '<C-Left>')
vim.keymap.set('c', '<M-l>', '<C-Right>')

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

vim.keymap.set('n', '<leader>w=', '<C-W>=')
vim.keymap.set('n', '<leader>wo', '<C-W>o')

vim.keymap.set('n', '<leader>wv', '<Cmd>vs<CR>')
vim.keymap.set('n', '<leader>ws', '<Cmd>sp<CR>')

vim.keymap.set('n', '<leader>wq', '<C-W>q')
vim.keymap.set('n', '<leader>bk', '<Cmd>bw<CR>')
