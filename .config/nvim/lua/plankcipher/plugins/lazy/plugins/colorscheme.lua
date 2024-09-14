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
        legacy_highlights = false,
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
        ok = '#8ec07c',
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
        CurSearch = {fg = base, bg = 'love', inherit = false},

        NonText = {fg = 'highlight_high', inherit = false},
        TrailingWhitespace = {fg = '#ffffff', bg = '#ff0000', bold = true, inherit = false},

        FloatBorder = {fg = 'text', bg = 'none', inherit = false},
        NormalFloat = {fg = 'text', bg = 'none', inherit = false},
        Pmenu = {fg = 'text', bg = 'surface', inherit = false},
        PmenuSel = {bg = 'highlight_med', inherit = false},

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
        Documentation = {fg = 'pine', inherit = false},

        ['@annotation'] = {link = 'PreProc', inherit = false},
        ['@attribute'] = {link = 'PreProc', inherit = false},
        ['@attribute.builtin'] = {link = 'Include', inherit = false},
        ['@boolean'] = {link = 'Boolean', inherit = false},
        ['@character'] = {link = 'Character', inherit = false},
        ['@character.special'] = {link = 'SpecialChar', inherit = false},
        ['@class'] = {link = 'Type', inherit = false},
        ['@comment'] = {link = 'Comment', inherit = false},
        ['@keyword.conditional'] = {link = 'Conditional', inherit = false},
        ['@keyword.conditional.ternary'] = {link = 'Conditional', inherit = false},
        ['@constant'] = {link = 'Constant', inherit = false},
        ['@constant.builtin'] = {link = 'Include', inherit = false},
        ['@constant.comment'] = {link = 'Macro', inherit = false},
        ['@constant.macro'] = {link = 'Macro', inherit = false},
        ['@constructor'] = {fg = 'love', inherit = false},
        ['@constructor.tsx'] = {link = '@constructor', inherit = false},
        ['@keyword.debug'] = {link = 'Debug', inherit = false},
        ['@keyword.directive.define'] = {link = 'Define', inherit = false},
        ['@error'] = {fg = 'love', inherit = false},
        ['@keyword.exception'] = {link = 'Exception', inherit = false},
        ['@variable.member'] = {link = '@property', inherit = false},
        ['@number.float'] = {link = 'Number', inherit = false},
        ['@function'] = {link = 'Function', inherit = false},
        ['@function.builtin'] = {link = 'Include', inherit = false},
        ['@function.call'] = {link = 'Function', inherit = false},
        ['@function.macro']  = {link = 'Macro', inherit = false},
        ['@keyword.import'] = {link = 'Include', inherit = false},
        ['@interface'] = {link = 'Type', inherit = false},
        ['@keyword'] = {link = 'Keyword', inherit = false},
        ['@keyword.type'] = {link = 'Keyword', inherit = false},
        ['@keyword.gitcommit'] = {fg = 'rose', inherit = false},
        ['@keyword.coroutine'] = {link = 'Keyword', inherit = false},
        ['@keyword.function'] = {link = 'Keyword', inherit = false},
        ['@keyword.operator'] = {link = 'Keyword', inherit = false},
        ['@keyword.return'] = {link = 'Keyword', inherit = false},
        ['@label'] = {link = 'Label', inherit = false},
        ['@label.json'] = {link = '@property', inherit = false},
        ['@macro'] = {link = 'Macro', inherit = false},
        ['@function.method'] = {link = 'Function', inherit = false},
        ['@function.method.call'] = {link = 'Function', inherit = false},
        ['@module'] = {link = 'Include', inherit = false},
        ['@module.builtin'] = {link = 'Include', inherit = false},
        ['@number'] = {link = 'Number', inherit = false},
        ['@operator'] = {link = 'Operator', inherit = false},
        ['@variable.parameter'] = {fg = 'iris', inherit = false},
        ['@variable.parameter.bash'] = {fg = 'text', inherit = false},
        ['@variable.parameter.builtin'] = {link = 'Include', inherit = false},
        ['@variable.parameter.reference'] = {link = '@variable.parameter', inherit = false},
        ['@keyword.directive'] = {link = 'PreProc', inherit = false},
        ['@property'] = {fg = 'foam', inherit = false},
        ['@property.css'] = {fg = 'rose', inherit = false},
        ['@punctuation'] = {link = 'Delimiter', inherit = false},
        ['@punctuation.special'] = {link = 'Delimiter', inherit = false},
        ['@punctuation.bracket'] = {link = 'Delimiter', inherit = false},
        ['@punctuation.delimiter'] = {link = 'Delimiter', inherit = false},
        ['@punctuation.delimiter.jsdoc'] = {link = 'Documentation', inherit = false},
        ['@markup.list'] = {link = 'Delimiter', inherit = false},
        ['@markup.quote'] = {fg = 'foam', inherit = false},
        ['@markup.list.markdown'] = {link = 'Delimiter', inherit = false},
        ['@markup.list.gitcommit'] = {fg = 'gold', bold = true, inherit = false},
        ['@punctuation.special.gitcommit'] = {fg = 'gold', bold = true, inherit = false},
        ['@regexp'] = {fg = 'love', inherit = false},
        ['@keyword.repeat'] = {link = 'Keyword', inherit = false},
        ['@string'] = {link = 'String', inherit = false},
        ['@string.documentation'] = {link = 'Documentation', inherit = false},
        ['@comment.documentation'] = {link = 'Documentation', inherit = false},
        ['@string.escape'] = {fg = 'love', inherit = false},
        ['@string.regexp'] = {link = '@regexp', inherit = false},
        ['@markup.link.label'] = {link = 'SpecialChar', inherit = false},
        ['@string.special'] = {link = 'SpecialChar', inherit = false},
        ['@string.special.symbol'] = {link = 'Identifier', inherit = false},
        ['@markup.link.label.symbol'] = {link = 'Identifier', inherit = false},
        ['@tag'] = {link = 'Tag', inherit = false},
        ['@tag.builtin'] = {link = 'Tag', inherit = false},
        ['@tag.attribute'] = {link = 'Identifier', inherit = false},
        ['@tag.delimiter'] = {link = 'Delimiter', inherit = false},
        ['@tag.delimiter.tsx'] = {link = 'Delimiter', inherit = false},
        ['@tag.tsx'] = {link = 'Tag', inherit = false},
        ['@diff.plus'] = {fg = '#8ec07c', inherit = false},
        ['@diff.minus'] = {fg = 'love', inherit = false},
        ['@diff.delta'] = {fg = 'pine', inherit = false},
        ['@text'] = {fg = 'text', inherit = false},
        ['@markup.emphasis'] = {italic = true, inherit = false},
        ['@markup.environment'] = {link = 'PreProc', inherit = false},
        ['@markup.environment.name'] = {link = 'Type', inherit = false},
        ['@markup.math'] = {link = 'Special', inherit = false},
        ['@markup.strike'] = {strikethrough = true, inherit = false},
        ['@markup.strikethrough'] = {strikethrough = true, inherit = false},
        ['@markup.strong'] = {bold = true, inherit = false},
        ['@markup.italic'] = {italic = true, inherit = false},
        ['@markup.underline'] = {underline = true, inherit = false},
        ['@markup.raw'] = {link = 'String', inherit = false},
        ['@markup.raw.block'] = {link = 'String', inherit = false},
        ['@markup.raw.delimiter'] = {link = 'Delimiter', inherit = false},
        ['@markup.raw.markdown_inline'] = {link = 'String', inherit = false},
        ['@markup.link'] = {fg = 'rose', inherit = false},
        ['@markup.heading'] = {link = 'Title', inherit = false},
        ['@markup.heading.1'] = {fg = 'iris', inherit = false},
        ['@markup.heading.2'] = {fg = 'foam', inherit = false},
        ['@markup.heading.3'] = {fg = 'rose', inherit = false},
        ['@markup.heading.4'] = {fg = 'gold', inherit = false},
        ['@markup.heading.5'] = {fg = 'pine', inherit = false},
        ['@markup.heading.6'] = {fg = 'foam', inherit = false},
        ['@comment.error'] = {link = 'ErrorMsg', inherit = false},
        ['@comment.note'] = {link = 'Todo', inherit = false},
        ['@comment.todo'] = {link = 'Todo', inherit = false},
        ['@markup.list.checked'] = {link = 'Todo', inherit = false},
        ['@markup.list.unchecked'] = {link = '@comment.error', inherit = false},
        ['@comment.warning'] = {fg = base, bg='gold', bold = true, inherit = false},
        ['@comment.hint'] = {fg = base, bg = 'foam', inherit = false},
        ['@comment.info'] = {fg = 'text', bg = 'pine', inherit = false},
        ['@string.special.url'] = {fg = 'iris', underline = true, inherit = false},
        ['@string.special.path'] = {fg = 'iris', underline = true, inherit = false},
        ['@markup.link.label'] = {fg = 'foam', underline = true, inherit = false},
        ['@markup.link.url'] = {fg = 'iris', underline = true, inherit = false},
        ['@todo'] = {link = 'Todo', inherit = false},
        ['@type'] = {link = 'Type', inherit = false},
        ['@type.css'] = {link = 'Tag', inherit = false},
        ['@type.builtin'] = {link = 'Type', inherit = false},
        ['@type.definition'] = {link = 'Typedef', inherit = false},
        ['@keyword.modifier'] = {link = 'Keyword', inherit = false},
        ['@variable'] = {fg = 'text', inherit = false},
        ['@variable.builtin'] = {link = 'Include', inherit = false},

        CmpItemAbbr = {fg = 'text', inherit = false},
        CmpItemAbbrMatch =  {fg = 'love', inherit = false},
        CmpItemAbbrMatchFuzzy =  {link = 'CmpItemAbbrMatch', inherit = false},
        CmpItemKind = {fg = 'base', bg = 'love', italic = true, inherit = false},
        CmpItemMenu = {fg = 'base', bg = 'subtle', italic = true, inherit = false},
        cmp_ghost_text = {fg = 'subtle', bg = '#000000', inherit = false},

        CmpItemKindArray = {fg = 'base', bg = 'gold', italic = true, inherit = false},
        CmpItemKindBoolean = {fg = 'base', bg = 'rose', italic = true, inherit = false},
        CmpItemKindClass = {fg = 'base', bg = 'gold', italic = true, inherit = false},
        CmpItemKindColor = {fg = 'base', bg = 'foam', italic = true, inherit = false},
        CmpItemKindConstant = {fg = 'base', bg = 'foam', italic = true, inherit = false},
        CmpItemKindConstructor = {fg = 'base', bg = 'love', italic = true, inherit = false},
        CmpItemKindEnum = {fg = 'base', bg = 'gold', italic = true, inherit = false},
        CmpItemKindEnumMember = {fg = 'base', bg = 'foam', italic = true, inherit = false},
        CmpItemKindEvent = {fg = 'base', bg = 'gold', italic = true, inherit = false},
        CmpItemKindField = {fg = 'base', bg = 'foam', italic = true, inherit = false},
        CmpItemKindFile = {fg = 'base', bg = 'rose', italic = true, inherit = false},
        CmpItemKindFolder = {fg = 'base', bg = 'rose', italic = true, inherit = false},
        CmpItemKindFunction = {fg = 'base', bg = 'pine', italic = true, inherit = false},
        CmpItemKindInterface = {fg = 'base', bg = 'gold', italic = true, inherit = false},
        CmpItemKindKey = {fg = 'base', bg = 'love', italic = true, inherit = false},
        CmpItemKindKeyword = {fg = 'base', bg = 'love', italic = true, inherit = false},
        CmpItemKindMethod = {fg = 'base', bg = 'pine', italic = true, inherit = false},
        CmpItemKindModule = {fg = 'base', bg = 'rose', italic = true, inherit = false},
        CmpItemKindNamespace = {fg = 'base', bg = 'rose', italic = true, inherit = false},
        CmpItemKindNull = {fg = 'base', bg = 'foam', italic = true, inherit = false},
        CmpItemKindNumber = {fg = 'base', bg = 'gold', italic = true, inherit = false},
        CmpItemKindObject = {fg = 'base', bg = 'love', italic = true, inherit = false},
        CmpItemKindOperator = {fg = 'base', bg = 'love', italic = true, inherit = false},
        CmpItemKindPackage = {fg = 'base', bg = 'rose', italic = true, inherit = false},
        CmpItemKindProperty = {fg = 'base', bg = 'foam', italic = true, inherit = false},
        CmpItemKindReference = {fg = 'base', bg = 'iris', italic = true, inherit = false},
        CmpItemKindSnippet = {fg = 'base', bg = 'foam', italic = true, inherit = false},
        CmpItemKindString = {fg = 'base', bg = 'gold', italic = true, inherit = false},
        CmpItemKindStruct = {fg = 'base', bg = 'gold', italic = true, inherit = false},
        CmpItemKindText = {fg = 'base', bg = 'gold', italic = true, inherit = false},
        CmpItemKindTypeParameter = {fg = 'base', bg = 'iris', italic = true, inherit = false},
        CmpItemKindUnit = {fg = 'base', bg = 'foam', italic = true, inherit = false},
        CmpItemKindValue = {fg = 'base', bg = 'foam', italic = true, inherit = false},
        CmpItemKindVariable = {fg = 'base', bg = 'foam', italic = true, inherit = false},

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
        vim.highlight.on_yank({higroup = 'Search', timeout = 100})
      end,
    })
  end,
}
