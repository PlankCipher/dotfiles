return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
  config = function()
    vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

    local base = '#1d1b2c'

    require('rose-pine').setup({
      variant = 'moon',
      dark_variant = 'moon',
      dim_inactive_windows = false,
      extend_background_behind_borders = false,

      enable = {
        transparency = false,
        terminal = false,
        migrations = false,
      },

      styles = {
        bold = true,
        italic = false,
        transparency = false,
      },

      groups = {
        background_nc = base,

        border = 'highlight_high',
        link = 'iris',

        error = 'love',
        warn = 'gold',
        info = 'pine',
        hint = 'foam',

        git_add = '#8ec07c',
        git_change = 'pine',
        git_delete = 'love',
        git_dirty = 'love',
        git_ignore = 'muted',
        git_merge = 'gold',
        git_rename = 'pine',
        git_stage = 'gold',
        git_text = 'rose',
      },

      highlight_groups = {
        Normal = {fg = 'text', bg = base, inherit = false},
        NormalNC = {link = 'Normal', inherit = false},

        ErrorMsg = {fg = base, bg = 'love', bold = true, inherit = false},
        ModeMsg = {fg = 'gold', inherit = false},
        MatchParen = {fg = 'text', bg = 'highlight_high', bold = true, inherit = false},
        VertSplit = {fg = 'subtle', inherit = false},
        WinSeparator = {link = 'VertSplit', inherit = false},
        Visual = {bg = 'highlight_high', inherit = false},

        ColorColumn = {bg = 'overlay', inherit = false},
        CursorLine = {bg = 'overlay', inherit = false},
        CursorLineNr = {fg = 'gold', inherit = false},
        LineNr = {link = 'NonText', inherit = false},
        qfLineNr = {fg = 'gold', inherit = false},

        Search = {fg = base, bg = 'gold', inherit = false},
        IncSearch = {fg = base, bg = 'love', inherit = false},
        CurSearch = {link = 'IncSearch', inherit = false},

        NonText = {fg = 'highlight_high', inherit = false},
        TrailingWhitespace = {fg = '#ffffff', bg = '#ff0000', bold = true, inherit = false},

        FloatBorder = {fg = 'text', bg = 'none', inherit = false},
        NormalFloat = {fg = 'text', bg = 'none', inherit = false},
        Pmenu = {fg = 'text', bg = 'surface', inherit = false},
        PmenuSel = {fg = base, bg = 'rose', inherit = false},

        Character = {fg = 'iris', inherit = false},
        Comment = {fg = 'subtle', inherit = false},
        Conditional = {link = 'Keyword', inherit = false},
        PreProc = {fg = 'rose', inherit = false},
        Constant = {fg = 'foam', inherit = false},
        Define = {link = 'PreProc', inherit = false},
        Delimiter = {fg = 'love', inherit = false},
        Function = {fg = 'pine', inherit = false},
        Include = {link = 'PreProc', inherit = false},
        Keyword = {fg = 'love', inherit = false},
        Macro = {fg = 'foam', inherit = false},
        Operator = {fg = 'love', inherit = false},
        Todo = {fg = base, bg='iris', bold = true, inherit = false},
        Type = {fg = 'gold', inherit = false},
        Label = {fg = 'gold', inherit = false},
        Title = {fg = 'text', inherit = false},

        ['@annotation'] = {link = 'PreProc', inherit = false},
        ['@attribute'] = {link = 'PreProc', inherit = false},
        ['@boolean'] = {link = 'Boolean', inherit = false},
        ['@character'] = {link = 'Character', inherit = false},
        ['@character.special'] = {link = 'SpecialChar', inherit = false},
        ['@class'] = {link = 'Type', inherit = false},
        ['@comment'] = {link = 'Comment', inherit = false},
        ['@conditional'] = {link = 'Conditional', inherit = false},
        ['@constant'] = {link = 'Constant', inherit = false},
        ['@constant.builtin'] = {link = 'Include', inherit = false},
        ['@constant.comment'] = {link = 'Macro', inherit = false},
        ['@constant.macro'] = {link = 'Macro', inherit = false},
        ['@constructor'] = {fg = 'love', inherit = false},
        ['@constructor.tsx'] = {link = '@constructor', inherit = false},
        ['@debug'] = {link = 'Debug', inherit = false},
        ['@define'] = {link = 'Define', inherit = false},
        ['@error'] = {fg = 'love', inherit = false},
        ['@exception'] = {link = 'Exception', inherit = false},
        ['@field'] = {link = '@property', inherit = false},
        ['@float'] = {link = 'Number', inherit = false},
        ['@function'] = {link = 'Function', inherit = false},
        ['@function.builtin'] = {link = 'Include', inherit = false},
        ['@function.call'] = {link = 'Function', inherit = false},
        ['@function.macro']  = {link = 'Macro', inherit = false},
        ['@include'] = {link = 'Include', inherit = false},
        ['@interface'] = {link = 'Type', inherit = false},
        ['@keyword'] = {link = 'Keyword', inherit = false},
        ['@keyword.gitcommit'] = {fg = 'rose', inherit = false},
        ['@keyword.coroutine'] = {link = 'Keyword', inherit = false},
        ['@keyword.function'] = {link = 'Keyword', inherit = false},
        ['@keyword.operator'] = {link = 'Keyword', inherit = false},
        ['@keyword.return'] = {link = 'Keyword', inherit = false},
        ['@label'] = {link = 'Label', inherit = false},
        ['@label.json'] = {link = '@property', inherit = false},
        ['@macro'] = {link = 'Macro', inherit = false},
        ['@method'] = {link = 'Function', inherit = false},
        ['@method.call'] = {link = 'Function', inherit = false},
        ['@namespace'] = {link = 'Include', inherit = false},
        ['@namespace.builtin'] = {link = 'Include', inherit = false},
        ['@number'] = {link = 'Number', inherit = false},
        ['@operator'] = {link = 'Operator', inherit = false},
        ['@parameter'] = {fg = 'iris', inherit = false},
        ['@parameter.bash'] = {fg = 'text', inherit = false},
        ['@parameter.builtin'] = {link = 'Include', inherit = false},
        ['@parameter.reference'] = {link = '@parameter', inherit = false},
        ['@preproc'] = {link = 'PreProc', inherit = false},
        ['@property'] = {fg = 'foam', inherit = false},
        ['@property.css'] = {fg = 'rose', inherit = false},
        ['@punctuation'] = {link = 'Delimiter', inherit = false},
        ['@punctuation.bracket'] = {link = 'Delimiter', inherit = false},
        ['@punctuation.delimiter'] = {link = 'Delimiter', inherit = false},
        ['@punctuation.special'] = {link = 'Delimiter', inherit = false},
        ['@punctuation.special.markdown'] = {link = 'Delimiter', inherit = false},
        ['@punctuation.special.gitcommit'] = {fg = 'gold', bold = true, inherit = false},
        ['@regexp'] = {fg = 'love', inherit = false},
        ['@repeat'] = {link = 'Keyword', inherit = false},
        ['@storageclass'] = {link = 'Type', inherit = false},
        ['@string'] = {link = 'String', inherit = false},
        ['@string.documentation'] = {link = 'SpecialChar', inherit = false},
        ['@string.escape'] = {fg = 'love', inherit = false},
        ['@string.regex'] = {link = '@regexp', inherit = false},
        ['@string.special'] = {link = 'SpecialChar', inherit = false},
        ['@symbol'] = {link = 'Identifier', inherit = false},
        ['@tag'] = {link = 'Tag', inherit = false},
        ['@tag.attribute'] = {link = 'Identifier', inherit = false},
        ['@tag.delimiter'] = {link = 'Delimiter', inherit = false},
        ['@tag.delimiter.tsx'] = {link = 'Delimiter', inherit = false},
        ['@tag.tsx'] = {link = 'Tag', inherit = false},
        ['@text'] = {fg = 'text', inherit = false},
        ['@text.danger'] = {link = 'ErrorMsg', inherit = false},
        ['@text.diff.add'] = {fg = 'gold', inherit = false},
        ['@text.diff.delete'] = {fg = 'love', inherit = false},
        ['@text.emphasis'] = {italic = true, inherit = false},
        ['@text.environment'] = {link = 'PreProc', inherit = false},
        ['@text.environment.name'] = {link = 'Type', inherit = false},
        ['@text.literal'] = {link = 'String', inherit = false},
        ['@text.literal.markdown_inline'] = {link = 'String', inherit = false},
        ['@text.math'] = {link = 'Special', inherit = false},
        ['@text.note'] = {link = 'Todo', inherit = false},
        ['@text.reference'] = {fg = 'rose', inherit = false},
        ['@text.strike'] = {strikethrough = true, inherit = false},
        ['@text.strong'] = {bold = true, inherit = false},
        ['@text.title'] = {link = 'Title', inherit = false},
        ['@text.todo'] = {link = 'Todo', inherit = false},
        ['@text.todo.checked'] = {link = 'Todo', inherit = false},
        ['@text.todo.unchecked'] = {link = '@text.danger', inherit = false},
        ['@text.underline'] = {underline = true, inherit = false},
        ['@text.uri'] = {fg = 'iris', underline = true, inherit = false},
        ['@text.warning'] = {fg = base, bg='gold', bold = true, inherit = false},
        ['@todo'] = {link = 'Todo', inherit = false},
        ['@type'] = {link = 'Type', inherit = false},
        ['@type.css'] = {link = 'Tag', inherit = false},
        ['@type.builtin'] = {link = 'Type', inherit = false},
        ['@type.definition'] = {link = 'Typedef', inherit = false},
        ['@type.qualifier'] = {link = 'Keyword', inherit = false},
        ['@variable'] = {fg = 'text', inherit = false},
        ['@variable.builtin'] = {link = 'Include', inherit = false},

        CmpItemAbbr = {fg = 'text', inherit = false},
        CmpItemAbbrMatch =  {fg = 'love', inherit = false},
        CmpItemAbbrMatchFuzzy =  {link = 'CmpItemAbbrMatch', inherit = false},
        CmpItemKind = {link = 'Keyword', inherit = false},
        CmpItemMenu = {fg = 'subtle', inherit = false},
        cmp_ghost_text = {fg = 'subtle', bg = '#000000', inherit = false},

        CmpItemKindArray = {link = '@type', inherit = false},
        CmpItemKindBoolean = {link = '@boolean', inherit = false},
        CmpItemKindClass = {link = '@type', inherit = false},
        CmpItemKindColor = {link = '@constant', inherit = false},
        CmpItemKindConstant = {link = '@constant', inherit = false},
        CmpItemKindConstructor = {link = '@constructor', inherit = false},
        CmpItemKindEnum = {link = '@type', inherit = false},
        CmpItemKindEnumMember = {link = '@constant', inherit = false},
        CmpItemKindEvent = {link = '@type', inherit = false},
        CmpItemKindField = {link = '@field', inherit = false},
        CmpItemKindFile = {link = '@include', inherit = false},
        CmpItemKindFolder = {link = '@include', inherit = false},
        CmpItemKindFunction = {link = '@function', inherit = false},
        CmpItemKindInterface = {link = '@type', inherit = false},
        CmpItemKindKey = {link = '@keyword', inherit = false},
        CmpItemKindKeyword = {link = '@keyword', inherit = false},
        CmpItemKindMethod = {link = '@method', inherit = false},
        CmpItemKindModule = {link = '@include', inherit = false},
        CmpItemKindNamespace = {link = '@namespace', inherit = false},
        CmpItemKindNull = {link = '@constant', inherit = false},
        CmpItemKindNumber = {link = '@number', inherit = false},
        CmpItemKindObject = {link = '@storageclass', inherit = false},
        CmpItemKindOperator = {link = '@operator', inherit = false},
        CmpItemKindPackage = {link = '@include', inherit = false},
        CmpItemKindProperty = {link = '@property', inherit = false},
        CmpItemKindReference = {link = '@parameter.reference', inherit = false},
        CmpItemKindSnippet = {link = '@constant', inherit = false},
        CmpItemKindString = {link = '@string', inherit = false},
        CmpItemKindStruct = {link = '@type', inherit = false},
        CmpItemKindText = {link = '@string', inherit = false},
        CmpItemKindTypeParameter = {link = '@parameter', inherit = false},
        CmpItemKindUnit = {link = '@constant', inherit = false},
        CmpItemKindValue = {link = '@constant', inherit = false},
        CmpItemKindVariable = {link = '@field', inherit = false},

        TreesitterContext = {bg = 'overlay', inherit = false},
        TreesitterContextLineNumber = {bg = 'overlay', inherit = false},
        TreesitterContextBottom = {sp = 'muted', underline = true, inherit = false},

        DiagnosticError = {fg = 'love', inherit = false},
        DiagnosticWarn = {fg = 'gold', inherit = false},
        DiagnosticInfo = {fg = 'pine', inherit = false},
        DiagnosticHint = {fg = 'foam', inherit = false},

        DiagnosticVirtualTextError = {fg = 'love', bg = '#482d41', inherit = false},
        DiagnosticVirtualTextWarn = {fg = 'gold', bg = '#4b3e3c', inherit = false},
        DiagnosticVirtualTextInfo = {fg = 'pine', bg = '#243348', inherit = false},
        DiagnosticVirtualTextHint = {fg = 'foam', bg = '#384150', inherit = false},

        DiagnosticUnderlineError = {sp = 'love', underline = true, inherit = false},
        DiagnosticUnderlineWarn = {sp = 'gold', underline = true, inherit = false},
        DiagnosticUnderlineInfo = {sp = 'pine', underline = true, inherit = false},
        DiagnosticUnderlineHint = {sp = 'foam', underline = true, inherit = false},

        DiagnosticLineNrError = {fg = 'love', inherit = false},
        DiagnosticLineNrWarn = {fg = 'gold', inherit = false},
        DiagnosticLineNrInfo = {fg = 'pine', inherit = false},
        DiagnosticLineNrHint = {fg = 'foam', inherit = false},

        LspSignatureActiveParameter = {bg = 'highlight_med', bold = true, inherit = false},
        LspCodeActionSign = {fg = 'gold', inherit = false},
        LspReferenceRead = {fg = '#fbf1c7', bg = '#66542a', inherit = false},
        LspReferenceText = {fg = '#fbf1c7', bg = '#66542a', inherit = false},
        LspReferenceWrite = {fg = '#fbf1c7', bg = '#66542a', inherit = false},

        TelescopeNormal = {fg = 'text', bg = 'surface', inherit = false},
        TelescopeBorder = {fg = 'surface', bg = 'none', inherit = false},
        TelescopeSelection = {bg = 'highlight_med', inherit = false},
        TelescopeSelectionCaret = {fg = 'gold', bg = 'highlight_med', inherit = false},
        TelescopeMultiIcon = {fg = 'gold', inherit = false},
        TelescopeMultiSelection = {fg = 'gold', inherit = false},
        TelescopePreviewTitle = {fg = base, bg = 'rose', bold = true, inherit = false},
        TelescopePreviewMessage = {fg = 'text', inherit = false},
        TelescopePreviewMessageFillchar = {fg = 'subtle', inherit = false},
        TelescopePromptNormal = {fg = 'text', bg = 'overlay', inherit = false},
        TelescopePromptBorder = {fg = 'overlay', bg = 'none', inherit = false},
        TelescopePromptTitle = {fg = base, bg = 'rose', bold = true, inherit = false},
        TelescopePromptPrefix = {fg = 'gold', inherit = false},
        TelescopePromptCounter = {fg = 'subtle', inherit = false},
        TelescopeMatching = {fg = 'love', inherit = false},

        lualine_section_separator = {fg = 'text', bg = 'highlight_med', inherit = false},
        lualine_section_border = {fg = 'highlight_med', bg = 'surface', inherit = false},
        lualine_section_border_bg_none = {fg = 'highlight_med', bg = 'none', inherit = false},
        lualine_section_border_active = {fg = 'subtle', bg = 'surface', inherit = false},
        lualine_section_border_active_bg_none = {fg = 'subtle', bg = 'none', inherit = false},
        lualine_buffers_active = {fg = base, bg = 'subtle', bold = true, inherit = false},
        lualine_buffers_modified = {fg = 'love', bg = 'highlight_med', inherit = false},
        lualine_buffers_hidden_border = {fg = 'rose', bg = 'surface', inherit = false},
        lualine_buffers_hidden = {fg = base, bg = 'rose', inherit = false},
        lualine_lsp_border = {fg = 'iris', bg = 'surface', inherit = false},
        lualine_lsp_icon = {fg = base, bg = 'iris', inherit = false},
        lualine_lsp_clients = {fg = 'iris', bg = 'highlight_med', inherit = false},
        lualine_git_border = {fg = 'rose', bg = 'surface', inherit = false},
        lualine_git_icon = {fg = base, bg = 'rose', inherit = false},
        lualine_git_branch = {fg = 'rose', bg = 'highlight_med', inherit = false},
        lualine_encoding_border = {fg = 'iris', bg = 'surface', inherit = false},
        lualine_encoding_icon = {fg = base, bg = 'iris', inherit = false},
        lualine_encoding_type = {fg = 'iris', bg = 'highlight_med', inherit = false},
        lualine_fileformat_border_unix = {fg = 'gold', bg = 'surface', inherit = false},
        lualine_fileformat_icon_unix = {fg = base, bg = 'gold', inherit = false},
        lualine_fileformat_type_unix = {fg = 'gold', bg = 'highlight_med', inherit = false},
        lualine_fileformat_border_non_unix = {fg = 'love', bg = 'surface', inherit = false},
        lualine_fileformat_icon_non_unix = {fg = base, bg = 'love', inherit = false},
        lualine_fileformat_type_non_unix = {fg = 'love', bg = 'highlight_med', inherit = false},
        lualine_progress_border = {fg = 'love', bg = 'surface', inherit = false},
        lualine_progress_icon = {fg = base, bg = 'love', inherit = false},
        lualine_progress_progress = {fg = 'love', bg = 'highlight_med', inherit = false},

        DiffAdd = {fg = '#8ec07c', inherit = false},
        DiffChange = {fg = 'pine', inherit = false},
        DiffDelete = {fg = 'love', inherit = false},
        DiffText = {fg = 'rose', inherit = false},

        VM_Cursor = {fg = base, bg = 'pine', inherit = false},
        VM_Extend = {fg = base, bg = 'foam', inherit = false},
        VM_Insert = {fg = base, bg = 'text', inherit = false},
        VM_Mono = {fg = base, bg = 'love', inherit = false},

        SpellBad = {undercurl = true, sp = 'love', inherit = false},
        SpellCap = {undercurl = true, sp = 'love', inherit = false},
        SpellLocal = {undercurl = true, sp = 'love', inherit = false},
        SpellRare = {undercurl = true, sp = 'love', inherit = false},

        LazyButtonActive = {fg = base, bg = 'text'},
      }
    })

    vim.cmd.colorscheme('rose-pine')

    vim.g.terminal_color_0 = '#1d1b2c'
    vim.g.terminal_color_1 = '#eb6f92'
    vim.g.terminal_color_2 = '#76b360'
    vim.g.terminal_color_3 = '#f6c177'
    vim.g.terminal_color_4 = '#3e8fb0'
    vim.g.terminal_color_5 = '#c4a7e7'
    vim.g.terminal_color_6 = '#9ccfd8'
    vim.g.terminal_color_7 = '#e0def4'
    vim.g.terminal_color_8 = '#908caa'
    vim.g.terminal_color_9 = '#ef8faa'
    vim.g.terminal_color_10 = '#8bbf78'
    vim.g.terminal_color_11 = '#f8d19b'
    vim.g.terminal_color_12 = '#52a1c2'
    vim.g.terminal_color_13 = '#d7c3ef'
    vim.g.terminal_color_14 = '#b6dce2'
    vim.g.terminal_color_15 = '#f8f7fc'

    vim.fn.sign_define('LspCodeAction', {text = '', texthl = 'LspCodeActionSign'})

    vim.api.nvim_cmd({cmd = 'match', args = {'TrailingWhitespace', [[/\s\+$/]]}}, {})

    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = '*',
      callback = function(event)
        if vim.api.nvim_get_option_value('ft', {buf = event.buf}) == 'help' or
           string.sub(event.file, 1, 7) == 'term://' or
           event.file == '' or
           vim.api.nvim_get_option_value('ft', {buf = event.buf}) == '' then
          vim.api.nvim_cmd({cmd = 'match', args = {'none'}}, {})
        else
          for _, match in ipairs(vim.fn.getmatches()) do
            if match.group == 'TrailingWhitespace' then
              return
            end
          end

          vim.api.nvim_cmd({cmd = 'match', args = {'TrailingWhitespace', [[/\s\+$/]]}}, {})
        end
      end,
    })

    vim.api.nvim_create_autocmd('WinEnter', {
      pattern = '*',
      callback = function(event)
        if event.file ~= '' and
          vim.api.nvim_get_option_value('ft', {buf = event.buf}) ~= 'help' then
          for _, match in ipairs(vim.fn.getmatches()) do
            if match.group == 'TrailingWhitespace' then
              return
            end
          end

          vim.api.nvim_cmd({cmd = 'match', args = {'TrailingWhitespace', [[/\s\+$/]]}}, {})
        end
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = {'TelescopePrompt', 'lazy'},
      command = 'match none',
    })

    vim.api.nvim_create_autocmd('TermEnter', {
      pattern = '*',
      command = 'match none',
    })

    vim.api.nvim_create_autocmd('TextYankPost', {
      pattern = '*',
      callback = function(event)
        vim.highlight.on_yank({higroup = 'IncSearch', timeout = 100})
      end,
    })

    local orig_visual_hl = { bg = '#56526e' }
    local paste_hl = { bg = '#8ec07c', fg = '#1d1b2c' }

    vim.keymap.set({'n', 'v'}, 'p', function()
      vim.api.nvim_set_hl(0, 'Visual', paste_hl)

      vim.api.nvim_cmd({cmd = 'normal', bang = true, args = {'pma`[v`]l'}}, {})

      vim.defer_fn(function()
        vim.api.nvim_input('<Esc>`a')
        vim.api.nvim_set_hl(0, 'Visual', orig_visual_hl)
      end, 100)
    end, { noremap = true })

    vim.keymap.set({'n', 'v'}, 'P', function()
      vim.api.nvim_set_hl(0, 'Visual', paste_hl)

      vim.api.nvim_cmd({cmd = 'normal', bang = true, args = {'Pma`[v`]l'}}, {})

      vim.defer_fn(function()
        vim.api.nvim_input('<Esc>`a')
        vim.api.nvim_set_hl(0, 'Visual', orig_visual_hl)
      end, 100)
    end, { noremap = true })
  end,
}
