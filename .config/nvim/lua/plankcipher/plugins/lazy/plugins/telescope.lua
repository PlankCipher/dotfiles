return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  cmd = 'Telescope',
  keys = {
    {'<leader>ff', '<cmd>Telescope find_files<cr>'},
    {'<leader>fg', '<cmd>Telescope live_grep<cr>'},
    {'<leader>fb', '<cmd>Telescope buffers<cr>'},
    {'<leader>fr', '<cmd>Telescope oldfiles<cr>'},
    {'<leader>fm', '<cmd>Telescope man_pages<cr>'},
    {'<leader>fq', '<cmd>Telescope quickfix<cr>'},
    {'<leader>fl', '<cmd>Telescope loclist<cr>'},
    {'<leader>fd', '<cmd>Telescope git_status<cr>'},
    {'z=', '<cmd>Telescope spell_suggest<cr>'},
    {'gd', '<cmd>Telescope lsp_definitions<cr>'},
    {'gr', '<cmd>Telescope lsp_references<cr>'},
    {'gi', '<cmd>Telescope lsp_implementations<cr>'},
    {'gD', vim.lsp.buf.declaration},
    {'<leader>ca', vim.lsp.buf.code_action},
  },
  config = function()
    local telescope = require('telescope')
    local themes = require('telescope.themes')
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    local previewers = require('telescope.previewers')
    local utils = require('telescope.utils')
    local from_entry = require('telescope.from_entry')
    local devicons = require('nvim-web-devicons')
    local Path = require('plenary.path')

    local custom_actions = {}

    function custom_actions._multiopen(prompt_bufnr, open_cmd)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local num_selections = #picker:get_multi_selection()

      if not num_selections or num_selections <= 1 then
        actions.add_selection(prompt_bufnr)
      end
      actions.send_selected_to_qflist(prompt_bufnr)

      vim.cmd('silent cfdo ' .. open_cmd)
    end

    function custom_actions.multi_selection_open(prompt_bufnr)
      custom_actions._multiopen(prompt_bufnr, 'edit')
    end

    function custom_actions.multi_selection_open_vsplit(prompt_bufnr)
      custom_actions._multiopen(prompt_bufnr, 'vsplit')
      vim.api.nvim_cmd({cmd = 'quit', args = {}}, {})
    end

    function custom_actions.multi_selection_open_split(prompt_bufnr)
      custom_actions._multiopen(prompt_bufnr, 'split')
      vim.api.nvim_cmd({cmd = 'quit', args = {}}, {})
    end

    function custom_actions.reset_prompt(prompt_bufnr)
      action_state.get_current_picker(prompt_bufnr):reset_prompt()
    end

    function dynamic_title_with_icon(_, entry)
      local filepath = Path:new(from_entry.path(entry, false, false)):normalize(vim.uv.cwd())
      local basename = utils.path_tail(filepath)

      local icon, _ = devicons.get_icon(basename, utils.file_extension(basename), { default = false })
      if not icon then
        icon, _ = devicons.get_icon(basename, nil, { default = true })
        icon = icon or ''
      end

      return icon .. ' ' .. filepath
    end

    local multi_selection_i_mappings = {
      i = {
        ['<CR>'] = custom_actions.multi_selection_open,
        ['<C-v>'] = custom_actions.multi_selection_open_vsplit,
        ['<C-s>'] = custom_actions.multi_selection_open_split,
      }
    }

    telescope.setup({
      defaults = {
        layout_config = {
          horizontal = {
            width = 0.94,
            height = 0.90,
            preview_cutoff = 120,
            preview_width = 0.58,
            prompt_position = 'top',
          },
          vertical = {
            width = 0.95,
          },
        },
        borderchars = {'█', '▊', '█', '🮊', '🮊', '▊', '▊', '🮊'},
        sorting_strategy = 'ascending',
        prompt_prefix = '󰍉 ',
        selection_caret = ' ',
        entry_prefix = ' ',
        dynamic_preview_title = true,
        results_title = false,
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--hidden',
          '--smart-case',
          '--glob', '!node_modules',
          '--glob', '!.git',
          '--glob', '!LICENSE',
        },
        mappings = {
          i = {
            ['kj'] = actions.close,
            ['<C-u>'] = custom_actions.reset_prompt,
            ['<C-k>'] = actions.preview_scrolling_up,
            ['<C-j>'] = actions.preview_scrolling_down,
            ['<C-h>'] = actions.preview_scrolling_left,
            ['<C-l>'] = actions.preview_scrolling_right,
          },
        },
        preview = {
          msg_bg_fillchar = '░',
        },
        file_previewer = function(...)
          local orig_file_previewer = previewers.vim_buffer_cat.new(...)
          orig_file_previewer._dyn_title_fn = dynamic_title_with_icon
          return orig_file_previewer
        end,
        grep_previewer = function(...)
          local orig_grep_previewer = previewers.vim_buffer_vimgrep.new(...)
          orig_grep_previewer._dyn_title_fn = dynamic_title_with_icon
          return orig_grep_previewer
        end,
        qflist_previewer = function(...)
          local orig_qflist_previewer = previewers.vim_buffer_qflist.new(...)
          orig_qflist_previewer._dyn_title_fn = dynamic_title_with_icon
          return orig_qflist_previewer
        end,
      },
      pickers = {
        find_files = {
          find_command = {'rg', '--files', '--hidden', '--glob', '!node_modules', '--glob', '!.git'},
          mappings = multi_selection_i_mappings,
          prompt_title = '󰈙 Find Files',
        },
        spell_suggest = {
          layout_config = {
            width = 0.5,
            height = 0.5,
          },
          prompt_title = '󰓆 Spelling Suggestions',
        },
        live_grep = {mappings = multi_selection_i_mappings, prompt_title = '󰍉 Live Grep'},
        buffers = {mappings = multi_selection_i_mappings, prompt_title = ' Buffers'},
        oldfiles = {mappings = multi_selection_i_mappings, prompt_title = '  Oldfiles'},
        quickfix = {mappings = multi_selection_i_mappings, prompt_title = '󰉹 Quickfix'},
        loclist = {mappings = multi_selection_i_mappings, prompt_title = '󰆤 Loclist'},
        git_status = {mappings = multi_selection_i_mappings, prompt_title = '󰊢 Git Status', preview_title = '󰊢 Git File Diff Preview'},
        lsp_definitions = {mappings = multi_selection_i_mappings, prompt_title = '  LSP Definitions'},
        lsp_references = {mappings = multi_selection_i_mappings, prompt_title = '  LSP References'},
        lsp_implementations = {mappings = multi_selection_i_mappings, prompt_title = '  LSP Implementations'},
        man_pages = {prompt_title = '  Man', preview_title = '  Man Preview'},
      },
      extensions = {
        ['ui-select'] = {
          layout_config = {
            width = 0.5,
            height = 0.5,
          },
        },
      },
    })

    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')

    local orig_vim_ui_select = vim.ui.select
    vim.ui.select = function(items, opts, on_choice, ...)
      opts = opts or {}

      opts.prompt = string.gsub(string.gsub(opts.prompt, '^%s+', ''), '%s+$', '')
      opts.prompt = string.gsub(string.gsub(opts.prompt, '^%a', string.upper), ' %a', string.upper)

      if opts.kind == 'codeaction' then
        opts.prompt = '󱌣 Code Actions'
      elseif opts.kind == 'codelens' then
        opts.prompt = '󰍉 Code Lenses'
      else
        opts.prompt = '󰍉 ' .. opts.prompt
      end

      orig_vim_ui_select(items, opts, on_choice, ...)
    end
  end,
}
