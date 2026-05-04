local c = require('rose_pine_moon.colors')

vim.cmd.highlight('clear')
vim.g.colors_name = 'rose-pine-moon'
vim.o.background = 'dark'

vim.g.terminal_color_0  = c.terminal_0
vim.g.terminal_color_1  = c.terminal_1
vim.g.terminal_color_2  = c.terminal_2
vim.g.terminal_color_3  = c.terminal_3
vim.g.terminal_color_4  = c.terminal_4
vim.g.terminal_color_5  = c.terminal_5
vim.g.terminal_color_6  = c.terminal_6
vim.g.terminal_color_7  = c.terminal_7
vim.g.terminal_color_8  = c.terminal_8
vim.g.terminal_color_9  = c.terminal_9
vim.g.terminal_color_10 = c.terminal_10
vim.g.terminal_color_11 = c.terminal_11
vim.g.terminal_color_12 = c.terminal_12
vim.g.terminal_color_13 = c.terminal_13
vim.g.terminal_color_14 = c.terminal_14
vim.g.terminal_color_15 = c.terminal_15

local fg_type            = c.gold
local fg_string          = fg_type
local fg_number          = fg_type
local fg_float           = fg_type
local fg_structure       = fg_type
local fg_typedef         = fg_type

local fg_builtin         = c.rose
local fg_boolean         = fg_builtin

local fg_pre_proc        = fg_builtin
local fg_pre_condit      = fg_pre_proc
local fg_include         = fg_pre_proc
local fg_define          = fg_pre_proc

local fg_macro           = c.foam
local fg_constant        = c.foam

local fg_character       = c.iris
local fg_special         = c.foam
local fg_special_char    = fg_special
local fg_regex           = c.love

local fg_identifier      = c.text
local fg_function        = c.pine
local fg_statement       = c.pine
local fg_label           = c.gold
local fg_property        = c.foam
local fg_parameter       = c.iris
local fg_operator        = c.love
local fg_delimiter       = fg_operator
local fg_keyword         = c.love
local fg_repeat          = fg_keyword
local fg_exception       = fg_keyword
local fg_storage_class   = fg_keyword
local fg_conditional     = fg_keyword
local fg_constructor     = fg_keyword
local fg_debug           = fg_keyword
local fg_tag             = c.iris
local fg_url             = c.iris

local fg_comment         = c.subtle
local fg_documentation   = c.pine
local fg_special_comment = fg_tag

local fg_error = c.love
local fg_warn  = c.gold
local fg_info  = c.pine
local fg_hint  = c.foam
local fg_ok    = c.moss

local bg_error = c.blend_with_base(fg_error)
local bg_warn  = c.blend_with_base(fg_warn)
local bg_info  = c.blend_with_base(fg_info)
local bg_hint  = c.blend_with_base(fg_hint)
local bg_ok    = c.blend_with_base(fg_ok)

local fg_non_text = c.highlight_high

local fg_added     = c.moss
local fg_changed   = c.pine
local fg_removed   = c.love
local fg_untracked = c.subtle

local bg_statusline_fill   = c.surface
local bg_statusline        = c.overlay
local bg_statusline_active = c.highlight_high

local highlights = {
    Normal    = { bg = c.base, fg = c.text },
    NormalNC  = { link = 'Normal' },
    Visual    = { bg = c.overlay },
    VisualNOS = { link = 'Visual' },

    Cursor     = { fg = '#ffffff', bg = '#6e6a86' },
    TermCursor = { link = 'Cursor' },
    lCursor    = { fg = '#ffffff', bg = '#ff0000' },
    CursorIM   = { link = 'lCursor' },
    CursorLine = { bg = c.surface },

    LineNr       = { link = 'NonText' },
    LineNrAbove  = { link = 'LineNr' },
    LineNrBelow  = { link = 'LineNr' },
    CursorLineNr = { fg = c.gold },

    SignColumn     = { bg = 'none', fg = c.text },
    CursorLineSign = { link = 'SignColumn' },

    Folded         = { bg = c.surface, fg = fg_comment },
    FoldColumn     = { fg = fg_comment },
    CursorLineFold = { link = 'FoldColumn' },

    ColorColumn  = { bg = c.surface },
    CursorColumn = { link = 'CursorLine' },

    Search     = { bg = c.gold, fg = c.base },
    CurSearch  = { bg = c.love, fg = c.base },
    IncSearch  = { link = 'CurSearch' },
    Substitute = { link = 'IncSearch' },

    NonText            = { fg = fg_non_text },
    Whitespace         = { link = 'NonText' },
    EndOfBuffer        = { link = 'NonText' },
    TrailingWhitespace = { fg = '#ffffff', bg = '#ff0000', bold = true },
    WinSeparator       = { fg = c.muted },
    SpecialKey         = { fg = c.foam },
    Conceal            = { bg = 'none' },
    Directory          = { fg = c.pine },
    MatchParen         = { bg = c.overlay, fg = c.text, bold = true },

    OkMsg        = { fg = c.moss },
    WarningMsg   = { fg = c.gold },
    ErrorMsg     = { bg = c.love, fg = c.base, bold = true },
    StderrMsg    = { link = 'ErrorMsg' },
    StdoutMsg    = { },
    ModeMsg      = { fg = c.gold },
    MoreMsg      = { link = 'Question' },
    MsgArea      = { link = 'Normal' },
    MsgSeparator = { link = 'StatusLine' },
    Question     = { fg = c.gold },

    FloatShadow        = { },
    FloatShadowThrough = { },
    FloatTitle         = { link = 'Title' },
    FloatFooter        = { link = 'FloatTitle' },
    Title              = { fg = c.foam, bold = true },

    NormalFloat = { bg = 'none', fg = c.text },
    FloatBorder = { link = 'WinSeparator' },
    FloatSel    = { link = 'CursorLine' },

    NoBorderNormalFloat = { bg = c.surface, fg = c.text },
    NoBorderFloatBorder = { bg = 'none', fg = c.surface },
    NoBorderFloatSel    = { bg = c.overlay },

    ComplMatchIns        = { fg = c.love },
    ComplHint            = { bg = '#000000', fg = c.subtle },
    ComplHintMore        = { bg = '#000000', fg = c.foam },
    PreInsert            = { link = 'Normal' },
    SnippetTabstop       = { link = 'Visual' },
    SnippetTabstopActive = { link = 'Visual' },

    Pmenu              = { link = 'NoBorderNormalFloat' },
    PmenuKind          = { link = 'Pmenu' },
    PmenuExtra         = { link = 'Pmenu' },
    PmenuSel           = { link = 'NoBorderFloatSel' },
    PmenuKindSel       = { link = 'PmenuSel' },
    PmenuExtraSel      = { link = 'PmenuSel' },
    PmenuSbar          = { link = 'Pmenu' },
    PmenuThumb         = { link = 'PmenuSel' },
    PmenuMatch         = { link = 'ComplMatchIns' },
    PmenuMatchSel      = { link = 'PmenuMatch' },
    PmenuBorder        = { link = 'FloatBorder' },
    PmenuShadow        = { },
    PmenuShadowThrough = { },
    WildMenu           = { link = 'PmenuSel' },

    QuickFixLine = { bg = c.surface, bold = true },

    SpellBad   = { undercurl = true, sp = c.love },
    SpellCap   = { undercurl = true, sp = c.love },
    SpellLocal = { undercurl = true, sp = c.love },
    SpellRare  = { undercurl = true, sp = c.love },

    StatusLine       = { bg = bg_statusline_fill, fg = c.text },
    StatusLineNC     = { link = 'StatusLine' },
    StatusLineTerm   = { link = 'StatusLine' },
    StatusLineTermNC = { link = 'StatusLine' },
    TabLineFill      = { link = 'StatusLine' },
    TabLine          = { bg = bg_statusline, fg = c.text },
    TabLineSel       = { bg = bg_statusline_active, fg = c.text, bold = true },
    WinBar           = { link = 'StatusLine' },
    WinBarNC         = { link = 'WinBar' },

    NvimInternalError = { link = 'ErrorMsg' },

    Bold   = { bold = true },
    Italic = { italic = true },

    Type           = { fg = fg_type },
    String         = { fg = fg_string },
    Number         = { fg = fg_number },
    Float          = { fg = fg_float },
    Structure      = { fg = fg_structure },
    Typedef        = { fg = fg_typedef },

    Builtin        = { fg = fg_builtin },
    Boolean        = { fg = fg_boolean },

    PreProc        = { fg = fg_pre_proc },
    PreCondit      = { fg = fg_pre_condit },
    Include        = { fg = fg_include },
    Define         = { fg = fg_define },

    Macro          = { fg = fg_macro },
    Constant       = { fg = fg_constant },

    Character      = { fg = fg_character },
    Special        = { fg = fg_special },
    SpecialChar    = { fg = fg_special_char },
    Regex          = { fg = fg_regex },

    Identifier     = { fg = fg_identifier },
    Function       = { fg = fg_function },
    Statement      = { fg = fg_statement },
    Label          = { fg = fg_label },
    Property       = { fg = fg_property },
    Parameter      = { fg = fg_parameter },
    Operator       = { fg = fg_operator },
    Delimiter      = { fg = fg_delimiter },
    Keyword        = { fg = fg_keyword },
    Repeat         = { fg = fg_repeat },
    Exception      = { fg = fg_exception },
    StorageClass   = { fg = fg_storage_class },
    Conditional    = { fg = fg_conditional },
    Constructor    = { fg = fg_constructor },
    Debug          = { fg = fg_debug },
    Tag            = { fg = fg_tag },
    Url            = { fg = fg_url },

    Comment        = { fg = fg_comment },
    Documentation  = { fg = fg_documentation },
    SpecialComment = { fg = fg_special_comment },
    Underlined     = { fg = fg_url, underline = true },

    Todo           = { bg = c.iris, fg = c.base, bold = true },
    CommentError   = { bg = c.love, fg = c.base, bold = true },
    CommentWarning = { bg = c.gold, fg = c.base, bold = true },
    CommentTodo    = { link = 'Todo' },

    Error = { link = 'ErrorMsg' },

    Added       = { fg = fg_added },
    Changed     = { fg = fg_changed },
    Removed     = { fg = fg_removed },
    Untracked   = { fg = fg_untracked },

    DiffAdd     = { bg = c.blend_with_base(fg_added) },
    DiffChange  = { bg = c.blend_with_base(fg_changed) },
    DiffDelete  = { bg = c.blend_with_base(fg_removed) },
    DiffText    = { bg = fg_changed, fg = '#ffffff', bold = true },
    DiffTextAdd = { bg = fg_added, fg = '#ffffff', bold = true },

    MarkupStrong        = { bold = true },
    MarkupItalic        = { italic = true },
    MarkupStrikethrough = { strikethrough = true },
    MarkupUnderline     = { underline = true },
    MarkupQuote         = { fg = c.foam },
    MarkupLinkLabel     = { fg = c.foam },
    MarkupRaw           = { fg = c.gold },
    MarkupListChecked   = { link = 'CommentTodo' },
    MarkupListUnChecked = { link = 'CommentError' },
    MarkupHeading       = { link = 'Title' },
    MarkupHeading1      = { fg = c.iris },
    MarkupHeading2      = { fg = c.foam },
    MarkupHeading3      = { fg = c.rose },
    MarkupHeading4      = { fg = c.gold },
    MarkupHeading5      = { fg = c.pine },
    MarkupHeading6      = { fg = c.foam },

    ['@variable']                    = { link = 'Identifier' },
    ['@variable.builtin']            = { link = 'Builtin' },
    ['@variable.parameter']          = { link = 'Parameter' },
    ['@variable.parameter.builtin']  = { link = 'Builtin' },
    ['@variable.member']             = { link = 'Property' },

    ['@constant']                    = { link = 'Constant' },
    ['@constant.builtin']            = { link = 'Builtin' },
    ['@constant.macro']              = { link = 'Macro' },

    ['@module']                      = { link = 'Include' },
    ['@module.builtin']              = { link = 'Builtin' },
    ['@label']                       = { link = 'Label' },

    ['@string']                      = { link = 'String' },
    ['@string.documentation']        = { link = 'Documentation' },
    ['@string.regexp']               = { link = 'Regex' },
    ['@string.escape']               = { link = 'Regex' },
    ['@string.special']              = { link = 'SpecialChar' },
    ['@string.special.symbol']       = { link = 'Identifier' },
    ['@string.special.url']          = { link = 'Url' },
    ['@string.special.path']         = { link = 'Url' },

    ['@character']                   = { link = 'Character' },
    ['@character.special']           = { link = 'SpecialChar' },

    ['@boolean']                     = { link = 'Boolean' },
    ['@number']                      = { link = 'Number' },
    ['@number.float']                = { link = 'Float' },

    ['@type']                        = { link = 'Type' },
    ['@type.builtin']                = { link = 'Type' },
    ['@type.definition']             = { link = 'Typedef' },

    ['@attribute']                   = { link = 'PreProc' },
    ['@attribute.builtin']           = { link = 'Builtin' },
    ['@property']                    = { link = 'Property' },

    ['@function']                    = { link = 'Function' },
    ['@function.builtin']            = { link = 'Builtin' },
    ['@function.call']               = { link = 'Function' },
    ['@function.macro']              = { link = 'Macro' },

    ['@function.method']             = { link = 'Function' },
    ['@function.method.call']        = { link = 'Function' },

    ['@constructor']                 = { link = 'Constructor' },
    ['@operator']                    = { link = 'Operator' },

    ['@keyword']                     = { link = 'Keyword' },
    ['@keyword.coroutine']           = { link = 'Keyword' },
    ['@keyword.function']            = { link = 'Keyword' },
    ['@keyword.operator']            = { link = 'Keyword' },
    ['@keyword.import']              = { link = 'Include' },
    ['@keyword.type']                = { link = 'Keyword' },
    ['@keyword.modifier']            = { link = 'Keyword' },
    ['@keyword.repeat']              = { link = 'Repeat' },
    ['@keyword.return']              = { link = 'Keyword' },
    ['@keyword.debug']               = { link = 'Debug' },
    ['@keyword.exception']           = { link = 'Exception' },

    ['@keyword.conditional']         = { link = 'Conditional' },
    ['@keyword.conditional.ternary'] = { link = 'Operator' },

    ['@keyword.directive']           = { link = 'PreProc' },
    ['@keyword.directive.define']    = { link = 'Define' },

    ['@punctuation.delimiter']       = { link = 'Delimiter' },
    ['@punctuation.bracket']         = { link = 'Delimiter' },
    ['@punctuation.special']         = { link = 'Delimiter' },

    ['@comment']                     = { link = 'Comment' },
    ['@comment.documentation']       = { link = 'Documentation' },

    ['@comment.error']               = { link = 'CommentError' },
    ['@comment.warning']             = { link = 'CommentWarning' },
    ['@comment.todo']                = { link = 'CommentTodo' },
    ['@comment.note']                = { link = 'CommentTodo' },

    ['@markup.strong']               = { link = 'MarkupStrong' },
    ['@markup.italic']               = { link = 'MarkupItalic' },
    ['@markup.strikethrough']        = { link = 'MarkupStrikethrough' },
    ['@markup.underline']            = { link = 'MarkupUnderline' },

    ['@markup.heading']              = { link = 'MarkupHeading' },
    ['@markup.heading.1']            = { link = 'MarkupHeading1' },
    ['@markup.heading.2']            = { link = 'MarkupHeading2' },
    ['@markup.heading.3']            = { link = 'MarkupHeading3' },
    ['@markup.heading.4']            = { link = 'MarkupHeading4' },
    ['@markup.heading.5']            = { link = 'MarkupHeading5' },
    ['@markup.heading.6']            = { link = 'MarkupHeading6' },

    ['@markup.quote']                = { link = 'MarkupQuote' },
    ['@markup.math']                 = { link = 'MarkupQuote' },

    ['@markup.link']                 = { link = 'Url' },
    ['@markup.link.label']           = { link = 'MarkupLinkLabel' },
    ['@markup.link.url']             = { link = 'Url' },

    ['@markup.raw']                  = { link = 'MarkupRaw' },
    ['@markup.raw.block']            = { link = 'MarkupRaw' },

    ['@markup.list']                 = { link = 'Delimiter' },
    ['@markup.list.checked']         = { link = 'MarkupListChecked' },
    ['@markup.list.unchecked']       = { link = 'MarkupListUnchecked' },

    ['@diff.plus']                   = { link = 'Added' },
    ['@diff.minus']                  = { link = 'Removed' },
    ['@diff.delta']                  = { link = 'Changed' },

    ['@tag']                         = { link = 'Tag' },
    ['@tag.builtin']                 = { link = 'Tag' },
    ['@tag.attribute']               = { link = 'Identifier' },
    ['@tag.delimiter']               = { link = 'Delimiter' },

    LazyNormal       = { link = 'NoBorderNormalFloat' },
    LazyButton       = { link = 'TabLine' },
    LazyButtonActive = { link = 'TabLineSel' },
    LazySpecial      = { fg = c.pine, bold = true },

    ScrollbarHandle = { fg = c.overlay },

    HlSearchNear     = { link = 'CurSearch' },
    HlSearchLens     = { link = 'NonText' },
    HlSearchLensNear = { bg = c.blend_with_base(c.gold), fg = c.gold },

    InclineNormal   = { bg = bg_statusline, fg = c.text },
    InclineNormalNC = { link = 'InclineNormal' },

    TelescopeTitle                  = { bg = c.rose, fg = c.base, bold = true },
    TelescopeNormal                 = { link = 'NoBorderNormalFloat' },
    TelescopeBorder                 = { link = 'NoBorderFloatBorder' },
    TelescopePromptNormal           = { bg = c.overlay, fg = c.text },
    TelescopePromptBorder           = { bg = c.none, fg = c.overlay },
    TelescopePromptTitle            = { link = 'TelescopeTitle' },
    TelescopePreviewNormal          = { link = 'TelescopeNormal' },
    TelescopePreviewBorder          = { link = 'TelescopeBorder' },
    TelescopePreviewTitle           = { link = 'TelescopeTitle' },
    TelescopeResultsNormal          = { link = 'TelescopeNormal' },
    TelescopeResultsBorder          = { link = 'TelescopeBorder' },
    TelescopeResultsTitle           = { link = 'TelescopeTitle' },

    TelescopePromptPrefix           = { fg = c.gold },
    TelescopePromptCounter          = { fg = c.subtle },
    TelescopeResultsLineNr          = { fg = c.gold },
    TelescopeMatching               = { link = 'ComplMatchIns' },
    TelescopeSelection              = { link = 'NoBorderFloatSel' },
    TelescopeSelectionCaret         = { bg = c.overlay, fg = c.gold },
    TelescopeMultiIcon              = { link = 'TelescopeMatching' },
    TelescopeMultiSelection         = { link = 'TelescopeMatching' },
    TelescopePreviewMessage         = { fg = c.text },
    TelescopePreviewMessageFillchar = { link = 'NonText' },
    TelescopePreviewLine            = { link = 'TelescopeSelection' },

    TelescopeResultsDiffChange      = { link = 'Changed' },
    TelescopeResultsDiffAdd         = { link = 'Added' },
    TelescopeResultsDiffUntracked   = { link = 'Untracked' },
    TelescopeResultsDiffDelete      = { link = 'Removed' },

    TelescopePreviewUser            = { link = 'Constant' },
    TelescopePreviewDirectory       = { link = 'Directory' },
    TelescopePreviewLink            = { link = 'Url' },
    TelescopePreviewSocket          = { link = 'Url' },
    TelescopePreviewPipe            = { link = 'Url' },
    TelescopePreviewRead            = { fg = c.gold },
    TelescopePreviewWrite           = { fg = c.rose },
    TelescopePreviewExecute         = { fg = c.love },
    TelescopePreviewHyphen          = { link = 'Comment' },
    TelescopePreviewSize            = { link = 'Number' },
    TelescopePreviewDate            = { fg = c.iris },

    TelescopeResultsComment         = { link = 'Comment' },
    TelescopeResultsNumber          = { link = 'Number' },
    TelescopeResultsIdentifier      = { link = 'Identifier' },
    TelescopeResultsVariable        = { link = 'Identifier' },
    TelescopeResultsStruct          = { link = 'Structure' },
    TelescopeResultsOperator        = { link = 'Operator' },
    TelescopeResultsMethod          = { link = 'Function' },
    TelescopeResultsFunction        = { link = 'Function' },
    TelescopeResultsField           = { link = 'Property' },
    TelescopeResultsConstant        = { link = 'Constant' },
    TelescopeResultsClass           = { link = 'Type' },
    TelescopePreviewGroup           = { link = 'Constant' },
    TelescopeResultsSpecialComment  = { link = 'Documentation' },
    TelescopePreviewSticky          = { link = 'Keyword' },
    TelescopePreviewBlock           = { link = 'Constant' },
    TelescopePreviewCharDev         = { link = 'Character' },

    TreesitterContext                 = { bg = c.surface },
    TreesitterContextLineNumber       = { bg = c.surface, fg = fg_non_text },
    TreesitterContextSeparator        = { bg = c.surface, fg = c.muted },
    TreesitterContextBottom           = { sp = c.muted, underline = true },
    TreesitterContextLineNumberBottom = { link = 'TreesitterContextBottom' },

    LspReferenceText            = { link = 'Visual' },
    LspReferenceRead            = { link = 'LspReferenceText' },
    LspReferenceWrite           = { link = 'LspReferenceText' },
    LspReferenceTarget          = { link = 'LspReferenceText' },
    LspInlayHint                = { bg = c.blend_with_base(fg_non_text), fg = fg_non_text },
    LspCodeLens                 = { link = 'LspInlayHint' },
    LspCodeLensSeparator        = { link = 'LspCodeLens' },
    LspSignatureActiveParameter = { bg = c.overlay, bold = true },

    ['@lsp.type.class']         = {},
    ['@lsp.type.comment']       = {},
    ['@lsp.type.decorator']     = {},
    ['@lsp.type.enum']          = {},
    ['@lsp.type.enumMember']    = {},
    ['@lsp.type.event']         = {},
    ['@lsp.type.function']      = {},
    ['@lsp.type.interface']     = {},
    ['@lsp.type.keyword']       = {},
    ['@lsp.type.macro']         = {},
    ['@lsp.type.method']        = {},
    ['@lsp.type.modifier']      = {},
    ['@lsp.type.namespace']     = {},
    ['@lsp.type.number']        = {},
    ['@lsp.type.operator']      = {},
    ['@lsp.type.parameter']     = {},
    ['@lsp.type.property']      = {},
    ['@lsp.type.regexp']        = {},
    ['@lsp.type.string']        = {},
    ['@lsp.type.struct']        = {},
    ['@lsp.type.type']          = {},
    ['@lsp.type.typeParameter'] = {},
    ['@lsp.type.variable']      = {},
    ['@lsp.mod.abstract']       = {},
    ['@lsp.mod.async']          = {},
    ['@lsp.mod.declaration']    = {},
    ['@lsp.mod.defaultLibrary'] = {},
    ['@lsp.mod.definition']     = {},
    ['@lsp.mod.deprecated']     = {},
    ['@lsp.mod.documentation']  = {},
    ['@lsp.mod.modification']   = {},
    ['@lsp.mod.readonly']       = {},
    ['@lsp.mod.static']         = {},

    LspCodeActionSign = { fg = c.gold },

    DiagnosticError             = { fg = fg_error },
    DiagnosticWarn              = { fg = fg_warn },
    DiagnosticInfo              = { fg = fg_info },
    DiagnosticHint              = { fg = fg_hint },
    DiagnosticOk                = { fg = fg_ok },

    DiagnosticVirtualTextError  = { bg = bg_error, fg = fg_error },
    DiagnosticVirtualTextWarn   = { bg = bg_warn, fg = fg_warn },
    DiagnosticVirtualTextInfo   = { bg = bg_info, fg = fg_info },
    DiagnosticVirtualTextHint   = { bg = bg_hint, fg = fg_hint },
    DiagnosticVirtualTextOk     = { bg = bg_ok, fg = fg_ok },

    DiagnosticVirtualLinesError = { link = 'DiagnosticVirtualTextError' },
    DiagnosticVirtualLinesWarn  = { link = 'DiagnosticVirtualTextWarn'  },
    DiagnosticVirtualLinesInfo  = { link = 'DiagnosticVirtualTextInfo'  },
    DiagnosticVirtualLinesHint  = { link = 'DiagnosticVirtualTextHint'  },
    DiagnosticVirtualLinesOk    = { link = 'DiagnosticVirtualTextOk'    },

    DiagnosticUnderlineError    = { sp = fg_error, underline = true },
    DiagnosticUnderlineWarn     = { sp = fg_warn, underline = true },
    DiagnosticUnderlineInfo     = { sp = fg_info, underline = true },
    DiagnosticUnderlineHint     = { sp = fg_hint, underline = true },
    DiagnosticUnderlineOk       = { sp = fg_ok, underline = true },

    DiagnosticFloatingError     = { link = 'DiagnosticError' },
    DiagnosticFloatingWarn      = { link = 'DiagnosticWarn'  },
    DiagnosticFloatingInfo      = { link = 'DiagnosticInfo'  },
    DiagnosticFloatingHint      = { link = 'DiagnosticHint'  },
    DiagnosticFloatingOk        = { link = 'DiagnosticOk'    },

    DiagnosticSignError         = { link = 'DiagnosticError' },
    DiagnosticSignWarn          = { link = 'DiagnosticWarn'  },
    DiagnosticSignInfo          = { link = 'DiagnosticInfo'  },
    DiagnosticSignHint          = { link = 'DiagnosticHint'  },
    DiagnosticSignOk            = { link = 'DiagnosticOk'    },

    DiagnosticLineNrError       = { link = 'DiagnosticError' },
    DiagnosticLineNrWarn        = { link = 'DiagnosticWarn'  },
    DiagnosticLineNrInfo        = { link = 'DiagnosticInfo'  },
    DiagnosticLineNrHint        = { link = 'DiagnosticHint'  },
    DiagnosticLineNrOk          = { link = 'DiagnosticOk'    },

    DiagnosticDeprecated        = { fg = fg_comment, strikethrough = true },
    DiagnosticUnnecessary       = { fg = fg_comment },

    BlinkCmpGhostText                    = { link = 'ComplHint' },

    BlinkCmpMenu                         = { link = 'NoBorderNormalFloat' },
    BlinkCmpMenuBorder                   = { link = 'NoBorderFloatBorder' },
    BlinkCmpMenuSelection                = { link = 'NoBorderFloatSel' },
    BlinkCmpScrollBarGutter              = { link = 'BlinkCmpMenu' },
    BlinkCmpScrollBarThumb               = { link = 'BlinkCmpMenuSelection' },

    BlinkCmpKind                         = { bg = c.blend_with_base(c.love),         fg = c.love,         italic = true },
    BlinkCmpKindClass                    = { bg = c.blend_with_base(fg_type),        fg = fg_type,        italic = true },
    BlinkCmpKindColor                    = { bg = c.blend_with_base(fg_constant),    fg = fg_constant,    italic = true },
    BlinkCmpKindConstant                 = { bg = c.blend_with_base(fg_constant),    fg = fg_constant,    italic = true },
    BlinkCmpKindConstructor              = { bg = c.blend_with_base(fg_constructor), fg = fg_constructor, italic = true },
    BlinkCmpKindEnum                     = { bg = c.blend_with_base(fg_type),        fg = fg_type,        italic = true },
    BlinkCmpKindEnumMember               = { bg = c.blend_with_base(fg_property),    fg = fg_property,    italic = true },
    BlinkCmpKindEvent                    = { bg = c.blend_with_base(fg_type),        fg = fg_type,        italic = true },
    BlinkCmpKindField                    = { bg = c.blend_with_base(fg_property),    fg = fg_property,    italic = true },
    BlinkCmpKindFile                     = { bg = c.blend_with_base(fg_builtin),     fg = fg_builtin,     italic = true },
    BlinkCmpKindFolder                   = { bg = c.blend_with_base(fg_builtin),     fg = fg_builtin,     italic = true },
    BlinkCmpKindFunction                 = { bg = c.blend_with_base(fg_function),    fg = fg_function,    italic = true },
    BlinkCmpKindInterface                = { bg = c.blend_with_base(fg_type),        fg = fg_type,        italic = true },
    BlinkCmpKindKeyword                  = { bg = c.blend_with_base(fg_keyword),     fg = fg_keyword,     italic = true },
    BlinkCmpKindMethod                   = { bg = c.blend_with_base(fg_function),    fg = fg_function,    italic = true },
    BlinkCmpKindModule                   = { bg = c.blend_with_base(fg_include),     fg = fg_include,     italic = true },
    BlinkCmpKindOperator                 = { bg = c.blend_with_base(fg_operator),    fg = fg_operator,    italic = true },
    BlinkCmpKindProperty                 = { bg = c.blend_with_base(fg_property),    fg = fg_property,    italic = true },
    BlinkCmpKindReference                = { bg = c.blend_with_base(fg_url),         fg = fg_url,         italic = true },
    BlinkCmpKindSnippet                  = { bg = c.blend_with_base(fg_special),     fg = fg_special,     italic = true },
    BlinkCmpKindStruct                   = { bg = c.blend_with_base(fg_structure),   fg = fg_structure,   italic = true },
    BlinkCmpKindText                     = { bg = c.blend_with_base(fg_string),      fg = fg_string,      italic = true },
    BlinkCmpKindTypeParameter            = { bg = c.blend_with_base(fg_parameter),   fg = fg_parameter,   italic = true },
    BlinkCmpKindUnit                     = { bg = c.blend_with_base(fg_constant),    fg = fg_constant,    italic = true },
    BlinkCmpKindValue                    = { bg = c.blend_with_base(fg_constant),    fg = fg_constant,    italic = true },
    BlinkCmpKindVariable                 = { bg = c.blend_with_base(fg_constant),    fg = fg_constant,    italic = true },

    BlinkCmpLabel                        = { fg = c.text },
    BlinkCmpLabelMatch                   = { link = 'ComplMatchIns' },
    BlinkCmpLabelDeprecated              = { link = 'DiagnosticDeprecated' },
    BlinkCmpLabelDetail                  = { link = 'DiagnosticUnnecessary' },
    BlinkCmpLabelDescription             = { link = 'BlinkCmpLabelDetail' },

    BlinkCmpSource                       = { bg = c.blend_with_base(c.iris), fg = c.iris, italic = true },
    BlinkCmpSourceIcon                   = { link = 'BlinkCmpSource' },

    BlinkCmpDoc                          = { link = 'BlinkCmpMenu' },
    BlinkCmpDocBorder                    = { link = 'BlinkCmpMenuBorder' },
    BlinkCmpDocCursorLine                = { link = 'BlinkCmpMenuSelection' },
    BlinkCmpDocSeparator                 = { link = 'WinSeparator' },

    BlinkCmpSignatureHelp                = { link = 'BlinkCmpMenu' },
    BlinkCmpSignatureHelpBorder          = { link = 'BlinkCmpMenuBorder' },
    BlinkCmpSignatureHelpActiveParameter = { link = 'LspSignatureActiveParameter' },

    DashboardBanner         = { fg = c.iris },
    DashboardQuote          = { link = 'Comment' },
    DashboardStartupSummary = { fg = fg_non_text, italic = true },

    NoiceCmdline                      = { link = 'MsgArea' },

    NoiceCmdlineIcon                  = { link = 'TelescopePromptPrefix' },
    NoiceCmdlineIconCalculator        = { link = 'NoiceCmdlineIcon'      },
    NoiceCmdlineIconCmdline           = { link = 'NoiceCmdlineIcon'      },
    NoiceCmdlineIconFilter            = { link = 'NoiceCmdlineIcon'      },
    NoiceCmdlineIconHelp              = { link = 'NoiceCmdlineIcon'      },
    NoiceCmdlineIconIncRename         = { link = 'NoiceCmdlineIcon'      },
    NoiceCmdlineIconInput             = { link = 'NoiceCmdlineIcon'      },
    NoiceCmdlineIconLua               = { link = 'NoiceCmdlineIcon'      },
    NoiceCmdlineIconSearch            = { link = 'NoiceCmdlineIcon'      },

    NoiceCmdlinePopup                 = { link = 'NoBorderNormalFloat'     },
    NoiceCmdlinePopupBorderChar       = { link = 'NoBorderFloatBorder'     },
    NoiceCmdlinePopupBorder           = { link = 'TelescopeTitle'          },
    NoiceCmdlinePopupBorderCalculator = { link = 'NoiceCmdlinePopupBorder' },
    NoiceCmdlinePopupBorderCmdline    = { link = 'NoiceCmdlinePopupBorder' },
    NoiceCmdlinePopupBorderFilter     = { link = 'NoiceCmdlinePopupBorder' },
    NoiceCmdlinePopupBorderHelp       = { link = 'NoiceCmdlinePopupBorder' },
    NoiceCmdlinePopupBorderIncRename  = { link = 'NoiceCmdlinePopupBorder' },
    NoiceCmdlinePopupBorderInput      = { link = 'NoiceCmdlinePopupBorder' },
    NoiceCmdlinePopupBorderLua        = { link = 'NoiceCmdlinePopupBorder' },
    NoiceCmdlinePopupBorderSearch     = { link = 'NoiceCmdlinePopupBorder' },
    NoiceCmdlinePopupTitle            = { link = 'NoiceCmdlinePopupBorder' },

    NoiceCmdlinePrompt                = { link = 'NoiceCmdlineIcon' },

    NoiceConfirm                      = { link = 'NoBorderNormalFloat' },
    NoiceConfirmBorder                = { link = 'NoBorderFloatBorder' },

    NoiceCursor                       = { link = 'Cursor' },

    NoiceFormatConfirm                = { link = 'LazyButton' },
    NoiceFormatConfirmDefault         = { link = 'LazyButtonActive' },
    NoiceFormatDate                   = { fg = c.iris },
    NoiceFormatEvent                  = { fg = c.gold },
    NoiceFormatKind                   = { fg = c.foam },
    NoiceFormatLevelError             = { fg = fg_error },
    NoiceFormatLevelWarn              = { fg = fg_warn },
    NoiceFormatLevelInfo              = { fg = fg_info },
    NoiceFormatLevelDebug             = { fg = fg_hint },
    NoiceFormatLevelTrace             = { fg = fg_hint },
    NoiceFormatLevelOff               = { fg = fg_comment },
    NoiceFormatProgressDone           = { bg = c.moss, fg = c.base },
    NoiceFormatProgressTodo           = { bg = c.surface, fg = c.text },
    NoiceFormatTitle                  = { link = 'Title' },

    NoiceLspProgressSpinner           = { fg = c.gold },
    NoiceLspProgressSpinnerDone       = { fg = c.moss },
    NoiceLspProgressTitle             = { fg = fg_comment },
    NoiceLspProgressClient            = { fg = c.foam, bold = true },

    NoiceMini                         = { link = 'Normal' },

    NoicePopup                        = { link = 'NoiceCmdlinePopup' },
    NoicePopupBorder                  = { link = 'NoiceCmdlinePopupBorderChar' },

    NoiceSplit                        = { link = 'Normal' },
    NoiceSplitBorder                  = { link = 'WinSeparator' },

    NoiceVirtualText                  = { link = 'HlSearchLensNear' },

    NotifyBackground  = { link = 'NoBorderNormalFloat' },
    NotifyBorder      = { link = 'NoBorderFloatBorder' },

    NotifyERRORBorder = { link = 'WinSeparator' },
    NotifyWARNBorder  = { link = 'WinSeparator' },
    NotifyINFOBorder  = { link = 'WinSeparator' },
    NotifyDEBUGBorder = { link = 'WinSeparator' },
    NotifyTRACEBorder = { link = 'WinSeparator' },

    NotifyERRORIcon   = { fg = fg_error },
    NotifyWARNIcon    = { fg = fg_warn  },
    NotifyINFOIcon    = { fg = fg_info  },
    NotifyDEBUGIcon   = { fg = fg_hint  },
    NotifyTRACEIcon   = { fg = fg_ok    },

    NotifyERRORTitle  = { link = 'NotifyERRORIcon' },
    NotifyWARNTitle   = { link = 'NotifyWARNIcon'  },
    NotifyINFOTitle   = { link = 'NotifyINFOIcon'  },
    NotifyDEBUGTitle  = { link = 'NotifyDEBUGIcon' },
    NotifyTRACETitle  = { link = 'NotifyTRACEIcon' },

    NotifyERRORBody   = { link = 'Normal' },
    NotifyWARNBody    = { link = 'Normal' },
    NotifyINFOBody    = { link = 'Normal' },
    NotifyDEBUGBody   = { link = 'Normal' },
    NotifyTRACEBody   = { link = 'Normal' },

    NvimSurroundHighlight = { link = 'Search' },

    GitSignsAdd                  = { link = 'Added' },
    GitSignsChange               = { link = 'Changed' },
    GitSignsDelete               = { link = 'Removed' },
    GitSignsUntracked            = { link = 'Untracked' },
    GitSignsChangedelete         = { link = 'GitSignsChange' },
    GitSignsTopdelete            = { link = 'GitSignsDelete' },

    GitSignsAddNr                = { link = 'GitSignsAdd' },
    GitSignsChangeNr             = { link = 'GitSignsChange' },
    GitSignsDeleteNr             = { link = 'GitSignsDelete' },
    GitSignsUntrackedNr          = { link = 'GitSignsUntracked' },
    GitSignsChangedeleteNr       = { link = 'GitSignsChangedelete' },
    GitSignsTopdeleteNr          = { link = 'GitSignsTopdelete' },

    GitSignsStagedAdd            = { fg = c.blend_with_base(fg_added) },
    GitSignsStagedChange         = { fg = c.blend_with_base(fg_changed) },
    GitSignsStagedDelete         = { fg = c.blend_with_base(fg_removed) },
    GitSignsStagedUntracked      = { fg = c.blend_with_base(fg_untracked) },
    GitSignsStagedChangedelete   = { link = 'GitSignsStagedChange' },
    GitSignsStagedTopdelete      = { link = 'GitSignsStagedDelete' },

    GitSignsStagedAddNr          = { link = 'GitSignsStagedAdd' },
    GitSignsStagedChangeNr       = { link = 'GitSignsStagedChange' },
    GitSignsStagedDeleteNr       = { link = 'GitSignsStagedDelete' },
    GitSignsStagedUntrackedNr    = { link = 'GitSignsStagedUntracked' },
    GitSignsStagedChangedeleteNr = { link = 'GitSignsStagedChangedelete' },
    GitSignsStagedTopdeleteNr    = { link = 'GitSignsStagedTopdelete' },

    BoundaryMarker = { link = 'LspInlayHint' },

    MultipleCursorsCursor       = { bg = c.foam, fg = c.base },
    MultipleCursorsVisual       = { bg = c.pine, fg = c.base },
    MultipleCursorsLockedCursor = { link = 'MultipleCursorsCursor' },
    MultipleCursorsLockedVisual = { link = 'MultipleCursorsVisual' },

    LualineLspIcon               = { bg = c.iris,        fg = c.base, italic = true },
    LualineLspClients            = { bg = bg_statusline, fg = c.iris                },
    LualineDiagnosticError       = { bg = bg_statusline, fg = fg_error              },
    LualineDiagnosticWarn        = { bg = bg_statusline, fg = fg_warn               },
    LualineDiagnosticInfo        = { bg = bg_statusline, fg = fg_info               },
    LualineDiagnosticHint        = { bg = bg_statusline, fg = fg_hint               },
    LualineBranchIcon            = { bg = c.rose,        fg = c.base, italic = true },
    LualineBranch                = { bg = bg_statusline, fg = c.rose                },
    LualineDiffAdd               = { bg = bg_statusline, fg = fg_added              },
    LualineDiffChange            = { bg = bg_statusline, fg = fg_changed            },
    LualineDiffDelete            = { bg = bg_statusline, fg = fg_removed            },
    LualineShowmodeIcon          = { bg = c.gold,        fg = c.base, italic = true },
    LualineShowmode              = { bg = bg_statusline, fg = c.gold,               },
    LualineVisualIcon            = { bg = c.foam,        fg = c.base, italic = true },
    LualineVisual                = { bg = bg_statusline, fg = c.foam                },
    LualineEncodingIcon          = { bg = c.iris,        fg = c.base, italic = true },
    LualineEncoding              = { bg = bg_statusline, fg = c.iris                },
    LualineFileformatIconUnix    = { bg = c.gold,        fg = c.base                },
    LualineFileformatIconNonUnix = { bg = c.love,        fg = c.base                },
    LualineFileformatUnix        = { bg = bg_statusline, fg = c.gold                },
    LualineFileformatNonUnix     = { bg = bg_statusline, fg = c.love                },
    LualineProgressIcon          = { bg = c.love,        fg = c.base, italic = true },
    LualineProgress              = { bg = bg_statusline, fg = c.love                },
    LualineSectionSeparator      = { bg = bg_statusline, fg = c.text                },
    LualineBuffer                = { bg = bg_statusline, fg = c.subtle              },
    LualineBufferActive          = { bg = bg_statusline, fg = c.text                },
    LualineBufferMoreIcon        = { bg = c.rose,        fg = c.base                },

    VisiMatch             = { fg = c.rose, underline = true, sp = c.rose },

    MiniCursorword        = { link = 'VisiMatch' },
    MiniCursorwordCurrent = { link = 'VisiMatch' },

    QuickFixFilePath = { fg = c.iris, bold = true       },
    QuickFixSep      = { fg = c.text, bold = true       },
    QuickFixLineCol  = { fg = c.foam, bold = true       },
    QuickFixError    = { link = 'DiagnosticError'       },
    QuickFixWarn     = { link = 'DiagnosticWarn'        },
    QuickFixInfo     = { link = 'DiagnosticInfo'        },
    QuickFixHint     = { link = 'DiagnosticHint'        },
    QuickFixNoise    = { link = 'DiagnosticUnnecessary' },
}

for group, highlight in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, highlight)
end
