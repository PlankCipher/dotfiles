return {
  'mg979/vim-visual-multi',
  keys = {
    {'<C-k>'},
    {'<C-j>'},
    {'<C-n>', mode = {'n', 'v'}},
  },
  init = function()
    vim.g.VM_set_statusline = 0
    vim.g.VM_theme_set_by_colorscheme = 1
    vim.g.VM_highlight_matches = 'hi! Search guifg=#ffffff guibg=#56526e'
    vim.g.VM_maps = {
      ['Add Cursor Up'] = '<C-k>',
      ['Add Cursor Down'] = '<C-j>',
    }
  end,
  config = false,
}
