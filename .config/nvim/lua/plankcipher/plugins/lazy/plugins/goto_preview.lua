return {
  'rmagatti/goto-preview',
  keys = {
    {'gpd'},
    {'gpi'},
  },
  config = function()
    vim.keymap.set('n', 'gpd', require('goto-preview').goto_preview_definition)
    vim.keymap.set('n', 'gpi', require('goto-preview').goto_preview_implementation)

    require('goto-preview').setup({
      width = 120,
      height = 21,
      border = {'↖', '─', '╮', '│', '╯', '─', '╰', '│'},
      resizing_mappings = false,
      post_open_hook = function(buffer, _)
        vim.keymap.set('n', '<Esc>', require('goto-preview').close_all_win, {buffer = buffer})
      end,
    })
  end,
}
