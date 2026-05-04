local float_win_opts = require('plankcipher.utils').float_win_opts

vim.keymap.set('n', 'K', function() vim.lsp.buf.hover(float_win_opts) end)
vim.keymap.set('n', 'gh', '<Cmd>LspClangdSwitchSourceHeader<CR>')
