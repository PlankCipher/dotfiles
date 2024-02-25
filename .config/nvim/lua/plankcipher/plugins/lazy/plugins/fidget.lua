return {
  'j-hui/fidget.nvim',
  opts = {
    progress = {
      clear_on_detach = false,

      display = {
        render_limit = 20,
        skip_history = false,

        done_icon = '',
        done_style = 'DiffAdd',
        icon_style = 'DiffAdd',
      },
    },

    notification = {
      override_vim_notify = false,

      view = {
        group_separator = '---',
      },

      window = {
        winblend = 0,
      },
    },

    integration = {
      ['nvim-tree'] = {
        enable = false,
      },

      ['xcodebuild-nvim'] = {
        enable = false,
      },
    },

    logger = {
      level = vim.log.levels.OFF,
    },
  },
}
