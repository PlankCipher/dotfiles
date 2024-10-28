return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  },
  opts = function()
    local luasnip = require('luasnip')
    local cmp = require('cmp')

    local kind_icons = {
      Text = ' 󰉿 ',
      Method = '  ',
      Function = ' 󰊕 ',
      Constructor = '  ',
      Field = ' 󰜢 ',
      Variable = ' 󰀫 ',
      Class = ' 󰠱 ',
      Interface = '  ',
      Module = '  ',
      Property = ' 󰜢 ',
      Unit = ' 󰑭 ',
      Value = ' 󰎠 ',
      Enum = '  ',
      Keyword = ' 󰌋 ',
      Snippet = '  ',
      Color = ' 󰉦 ',
      File = ' 󰈙 ',
      Reference = '  ',
      Folder = '  ',
      EnumMember = '  ',
      Constant = ' 󰏿 ',
      Struct = ' 󰙅 ',
      Event = '  ',
      Operator = ' 󱓉 ',
      TypeParameter = '  ',
    }

    local orig_get_selected_entry = cmp.core.view.get_selected_entry
    cmp.core.view.get_selected_entry = function(self)
      return orig_get_selected_entry(self) or
             self:_get_entries_view():get_first_entry()
    end

    return {
      view = {
        entries = {name = 'custom', selection_order = 'near_cursor' },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-y>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = {
        {name = 'path'},
        {name = 'nvim_lsp'},
        {name = 'buffer', option = {get_bufnrs = vim.api.nvim_list_bufs}},
        {name = 'luasnip'},
      },
      formatting = {
        fields = {'kind', 'abbr', 'menu'},
        format = function(entry, vim_item)
          vim_item.kind = kind_icons[vim_item.kind]
          vim_item.abbr = string.format('%s', vim_item.abbr:gsub('^%s+', ''))
          vim_item.menu = string.format(' %s ', ({
            path = '󰈙',
            buffer = '',
            nvim_lsp = '󰒓',
            luasnip = '󰅴',
          })[entry.source.name])

          return vim_item
        end
      },
      window = {
        completion = {
          border = 'rounded',
          winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
          col_offset = -5,
          side_padding = 1,
        },
        documentation = {
          border = 'rounded',
          winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
          max_width = 100,
          max_height = 30,
        },
      },
      experimental = {
        ghost_text = {hl_group = 'cmp_ghost_text'},
      },
      preselect = cmp.PreselectMode.None,
    }
  end,
}
