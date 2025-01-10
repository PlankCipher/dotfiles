return {
  'saghen/blink.cmp',
  build = 'cargo build --release',
  event = 'InsertEnter',
  opts = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpListSelect',
      callback = function(event)
        local data = event.data

        if data.item == nil then
          require('blink.cmp.completion.windows.documentation').auto_show_item(data.context, data.items[1])
        end
      end,
    })

    return {
      keymap = {
        preset = 'default',

        ['<C-space>'] = { 'show' },

        ['<C-k>'] = { function(cmp) return cmp.scroll_documentation_up(4) end, 'fallback' },
        ['<C-j>'] = { function(cmp) return cmp.scroll_documentation_down(4) end, 'fallback' },

        ['<Tab>']   = {
          function(cmp)
            if vim.api.nvim_get_mode().mode == 'c' then
              return cmp.select_and_accept()
            else
              return cmp.snippet_forward()
            end
          end,
          'fallback',
        },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      },

      completion = {
        keyword = { range = 'prefix' },
        trigger = {
          prefetch_on_insert = true,
          show_on_insert_on_trigger_character = false,
        },
        list = { selection = { preselect = false, auto_insert = true } },
        accept = { auto_brackets = { enabled = false } },

        menu = {
          scrolloff = vim.o.scrolloff,
          max_height = vim.o.pumheight,
          border = 'rounded',

          draw = {
            padding = 0,
            gap = 1,

            columns = {
              { 'kind_icon' }, { 'label' }, { 'source_icon' },
            },

            components = {
              kind_icon = {
                text = function(ctx)
                  return ' ' .. ctx.kind_icon .. ' '
                end,
              },

              source_icon = {
                text = function(ctx)
                  local source_icons = {
                    path = '󰈙',
                    buffer = '',
                    lsp = '󰒓',
                    cmdline = '',
                  }

                  return ' ' .. source_icons[ctx.source_name:lower()] .. ' '
                end,
                highlight = 'BlinkCmpSourceIcon',
              },
            },
          }
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          update_delay_ms = 0,
          window = {
            max_width = 100,
            max_height = 30,
            border = 'rounded',
          },
        },

        ghost_text = {
          enabled = true,
          show_with_selection = false,
          show_without_selection = true,
        },
      },

      signature = {
        enabled = true,
        window = {
          max_width = 100,
          max_height = 30,
          border = 'rounded',
        },
      },

      fuzzy = {
        use_frecency = false,
        use_proximity = false,
        prebuilt_binaries = { download = false },
      },

      sources = {
        min_keyword_length = 0,

        default = { 'path', 'lsp', 'buffer' },

        cmdline = function()
          if vim.fn.getcmdtype() == ':' then
            return { 'path', 'cmdline' }
          else
            return {}
          end
        end,

        providers = {
          path = {
            opts = {
              show_hidden_files_by_default = true,
            }
          },
        },
      },

      appearance = {
        nerd_font_variant = 'mono',
        kind_icons = {
          Method = '󰊕',
          Function = '󰊕',
          Class = '󰠱',
          Interface = '',
          Struct = '󰙅',
          Constructor = '',
          Field = '󰜢',
          Property = '󰜢',
          Enum = '',
          EnumMember = '',
          Variable = '󰀫',
          Constant = '󰏿',
          Keyword = '󰌋',
          Operator = '󱓉',
          Module = '',
          Text = '󰉿',
          Unit = '󰑭',
          Value = '󰎠',
          Color = '󰉦',
          File = '󰈙',
          Folder = '',
          Snippet = '',
          Reference = '',
          Event = '',
          TypeParameter = '',
        },
      },
    }
  end,
  opts_extend = { 'sources.default' },
}
