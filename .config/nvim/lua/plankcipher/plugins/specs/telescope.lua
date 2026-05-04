return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-telescope/telescope-ui-select.nvim',
        'catgoose/telescope-helpgrep.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
    },
    cmd = 'Telescope',
    keys = {
        { '<leader>ff', '<Cmd>Telescope find_files<CR>' },
        { '<leader>fg', '<Cmd>Telescope live_grep<CR>' },
        { '<leader>fb', '<Cmd>Telescope buffers<CR>' },
        { '<leader>fm', '<Cmd>Telescope man_pages<CR>' },
        { '<leader>fq', '<Cmd>Telescope quickfix<CR>' },
        { '<leader>fl', '<Cmd>Telescope loclist<CR>' },
        { '<leader>fd', '<Cmd>Telescope git_status<CR>' },
        { '<leader>fh', '<Cmd>Telescope helpgrep<CR>' },
        { '<leader>fr', '<Cmd>Telescope file_browser<CR>' },
        { 'z=', '<Cmd>Telescope spell_suggest<CR>' },
        { 'gd', '<Cmd>Telescope lsp_definitions<CR>' },
        { 'gt', '<Cmd>Telescope lsp_type_definitions<CR>' },
        { 'gr', '<Cmd>Telescope lsp_references<CR>' },
        { 'gi', '<Cmd>Telescope lsp_implementations<CR>' },
        { '<leader>ca', function() vim.lsp.buf.code_action({ apply = false }) end },
    },
    config = function()
        local telescope = require('telescope')
        local previewers = require('telescope.previewers')
        local from_entry = require('telescope.from_entry')
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')
        local builtin = require('telescope.builtin')
        local Path = require('plenary.path')
        local utils = require('plankcipher.utils')
        local fb_actions = telescope.extensions.file_browser.actions

        local dynamic_title_with_icon = function(_, entry)
            local filepath = Path:new(from_entry.path(entry, false, false)):normalize(vim.uv.cwd())
            local icon, _ = utils.get_icon_color(filepath, nil)
            return icon .. ' ' .. filepath
        end

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
            vim.cmd.quit()
        end

        function custom_actions.multi_selection_open_split(prompt_bufnr)
            custom_actions._multiopen(prompt_bufnr, 'split')
            vim.cmd.quit()
        end

        local multi_selection_mappings = {
            i = {
                ['<CR>']  = custom_actions.multi_selection_open,
                ['<C-v>'] = custom_actions.multi_selection_open_vsplit,
                ['<C-s>'] = custom_actions.multi_selection_open_split,
            }
        }

        telescope.setup{
            defaults = {
                sorting_strategy = 'ascending',
                selection_strategy = 'reset',
                scroll_strategy = 'cycle',
                layout_strategy = 'horizontal',
                layout_config = {
                    horizontal = {
                        width = 0.84,
                        height = 0.80,
                        prompt_position = 'top',
                        preview_cutoff = 120,
                        preview_width = 0.58,
                    },
                },
                winblend = 0,
                wrap_results = false,
                prompt_prefix = '󰍉 ',
                entry_prefix = '   ',
                selection_caret = '  ',
                multi_icon = '',
                initial_mode = 'insert',
                border = true,
                path_display = {},
                borderchars = { '█', '▊', '█', '🮊', '🮊', '▊', '▊', '🮊' },
                hl_result_eol = true,
                dynamic_preview_title = true,
                results_title = false,
                prompt_title = '󰍉 Prompt',
                mappings = {
                    i = {
                        ['kj'] = 'close',
                        ['<C-u>'] = false,
                        ['<C-k>'] = 'preview_scrolling_up',
                        ['<C-j>'] = 'preview_scrolling_down',
                        ['<C-h>'] = 'preview_scrolling_left',
                        ['<C-l>'] = 'preview_scrolling_right',
                    },
                },
                history = false,
                preview = {
                    check_mime_type = true,
                    treesitter = true,
                    msg_bg_fillchar = '░',
                    hide_on_startup = false,
                    ls_short = false,
                },
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--hidden',
                    '--smart-case',
                    '--glob', '!.git',
                    '--glob', '!LICENSE',
                    '--glob', '!node_modules',
                    '--glob', '!.venv',
                    '--glob', '!__pycache__',
                },
                color_devicons = true,
                file_ignore_patterns = nil,
                file_previewer = function(...)
                    local file_previewer = previewers.vim_buffer_cat.new(...)
                    file_previewer._dyn_title_fn = dynamic_title_with_icon
                    return file_previewer
                end,
                grep_previewer = function(...)
                    local grep_previewer = previewers.vim_buffer_vimgrep.new(...)
                    grep_previewer._dyn_title_fn = dynamic_title_with_icon
                    return grep_previewer
                end,
                qflist_previewer = function(...)
                    local qflist_previewer = previewers.vim_buffer_qflist.new(...)
                    qflist_previewer._dyn_title_fn = dynamic_title_with_icon
                    return qflist_previewer
                end,
            },
            pickers = {
                find_files = {
                    find_command = {
                        'rg',
                        '--files',
                        '--hidden',
                        '--glob', '!.git',
                        '--glob', '!node_modules',
                        '--glob', '!.venv',
                        '--glob', '!__pycache__',
                    },
                    follow = false,
                    hidden = true,
                    mappings = multi_selection_mappings,
                    prompt_title = '󰈙 Find Files',
                },
                buffers = {
                    ignore_current_buffer = false,
                    mappings = multi_selection_mappings,
                    prompt_title = ' Buffers',
                    disable_coordinates = true,
                },
                spell_suggest = {
                    layout_config = {
                        width = 0.35,
                        height = 0.35,
                    },
                    prompt_title = '󰓆 Spelling Suggestions',
                },
                man_pages = {
                    sections = { "ALL" },
                    prompt_title = '  Man',
                    preview_title = '  Man Preview'
                },
                quickfix = {
                    show_line = true,
                    trim_text = false,
                    mappings = multi_selection_mappings,
                    prompt_title = '󰉹 Quickfix'
                },
                loclist = {
                    show_line = true,
                    trim_text = false,
                    mappings = multi_selection_mappings,
                    prompt_title = '󰆤 Loclist'
                },
                lsp_definitions = {
                    show_line = true,
                    trim_text = false,
                    mappings = multi_selection_mappings,
                    prompt_title = '  LSP Definitions'
                },
                lsp_type_definitions = {
                    show_line = true,
                    trim_text = false,
                    mappings = multi_selection_mappings,
                    prompt_title = '  LSP Type Definitions'
                },
                lsp_references = {
                    include_declaration = false,
                    include_current_line = true,
                    show_line = true,
                    trim_text = false,
                    mappings = multi_selection_mappings,
                    prompt_title = '  LSP References'
                },
                lsp_implementations = {
                    show_line = true,
                    trim_text = false,
                    mappings = multi_selection_mappings,
                    prompt_title = '  LSP Implementations'
                },
                live_grep = {
                    hidden = true,
                    show_line = false,
                    mappings = multi_selection_mappings,
                    prompt_title = '󰍉 Live Grep',
                },
                oldfiles = { mappings = multi_selection_mappings, prompt_title = '  Oldfiles' },
                git_status = { mappings = multi_selection_mappings, prompt_title = '󰊢 Git Status', preview_title = '󰊢 Git File Diff Preview' },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case',
                },
                ['ui-select'] = {
                    layout_config = {
                        width = 0.35,
                        height = 0.35,
                    },
                },
                helpgrep = {
                    ignore_paths = {},
                    mappings = {},
                    default_grep = function(opts)
                        opts.prompt_title = ' Help Grep'
                        return builtin.live_grep(opts)
                    end,
                },
                file_browser = {
                    prompt_title = '󰉋 File Browser',
                    results_title = false,
                    cwd_to_path = false,
                    grouped = true,
                    files = true,
                    add_dirs = true,
                    depth = 1,
                    auto_depth = false,
                    select_buffer = true,
                    hidden = true,
                    respect_gitignore = false,
                    no_ignore = true,
                    follow_symlinks = false,
                    hide_parent_dir = true,
                    collapse_dirs = false,
                    prompt_path = true,
                    quiet = false,
                    use_ui_input = true,
                    dir_icon = '󰉋',
                    dir_icon_hl = 'Directory',
                    display_stat = { date = true, size = true, mode = true },
                    use_fd = true,
                    git_status = true,
                    create_from_prompt = true,
                    theme = nil,
                    hijack_netrw = true,
                    mappings = {
                        i = {
                            ['<A-c>'] = fb_actions.create_from_prompt,
                            ['<S-CR>'] = fb_actions.create,
                            ['<C-w>'] = { '<Cmd>normal db<CR>', type = 'command' },
                        },
                        n = {
                            ['d'] = false,
                            ['b'] = false,
                        },
                    },
                },
            }
        }

        telescope.load_extension('fzf')
        telescope.load_extension('helpgrep')
        telescope.load_extension('file_browser')
        telescope.load_extension('ui-select')

        local orig_vim_ui_select = vim.ui.select
        vim.ui.select = function(items, opts, on_choice)
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

            orig_vim_ui_select(items, opts, on_choice)
        end

        local telescope_augroup = vim.api.nvim_create_augroup('PCTelescopeScrollbar', { clear = true })
        local scrollbar_show = require('scrollbar.utils').show

        vim.api.nvim_create_autocmd('User', {
            group = telescope_augroup,
            pattern = 'TelescopePreviewerLoaded',
            callback = function(e)
                vim.api.nvim_buf_attach(e.buf, false, {
                    on_lines = function()
                        vim.api.nvim_buf_call(e.buf, scrollbar_show)
                        return true
                    end,
                })
            end,
        })

        vim.api.nvim_create_autocmd('FileType', {
            group = telescope_augroup,
            pattern = 'TelescopePrompt',
            callback = function(e)
                local picker = action_state.get_current_picker(e.buf)
                vim.api.nvim_buf_attach(picker.results_bufnr, false, {
                    on_lines = function()
                        vim.api.nvim_buf_call(picker.results_bufnr, scrollbar_show)
                    end,
                })
            end,
        })
    end,
}
