return {
  'nvim-tree/nvim-web-devicons',
  lazy = true,
  config = function()
    require('nvim-web-devicons').setup({
      strict = true,
      override_by_filename = {
        ['send help'] = {
          icon = '',
          color = '#fabd2f',
          name = 'Dashboard'
        },
        ['Telescope'] = {
          icon = '󰭎',
          color = '#9ccfd8',
          name = 'Telescope'
        },
        ['Lazy'] = {
          icon = '',
          color = '#8ec07c',
          name = 'Lazy'
        },
        ['Netrw'] = {
          icon = '',
          color = '#3e8fb0',
          name = 'Netrw'
        },
      },
    })

    local filetype_name_mappings = {
      {filetype = 'TelescopePrompt', name = 'Telescope'},
      {filetype = 'lazy', name = 'Lazy'},
      {filetype = 'netrw', name = 'Netrw'},
    }

    for _, mapping in ipairs(filetype_name_mappings) do
      vim.api.nvim_create_autocmd('FileType', {
        pattern = mapping.filetype,
        callback = function(e)
          vim.api.nvim_buf_set_name(e.buf, mapping.name)
        end,
      })
    end
  end,
}
