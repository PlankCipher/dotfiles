return {
    'saghen/blink.cmp',
    dependencies = { 'saghen/blink.lib' },
    commit = '90d14caca4ae557665ab105080c27d5f289a2e30',
    build = 'cargo build --release',
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = function()
        local Color = require('blink.cmp.types').CompletionItemKind.Color
        local utils = require('plankcipher.utils')
        local c = require('rose_pine_moon.colors')

        local MIN_WIDTH = utils.float_win_opts.min_width
        local MAX_WIDTH = utils.float_win_opts.max_width
        local MAX_HEIGHT = utils.float_win_opts.max_height
        local BORDER = utils.float_win_opts.border
        local WIN_BLEND = vim.o.winblend
        local SCROLLBAR = true

        local scroll_by_4 = function(command)
            return function(cmp)
                cmp[command](4)
            end
        end

        local all_regular_bufnrs = function()
            return vim
                .iter(vim.api.nvim_list_bufs())
                :filter(function(buf) return vim.bo[buf].buftype ~= 'nofile' end)
                :totable()
        end

        vim.schedule(function()
            local docs = require('blink.cmp.completion.windows.documentation')
            local list = require('blink.cmp.completion.list')
            local menu = require('blink.cmp.completion.windows.menu')

            vim.api.nvim_create_autocmd('User', {
                pattern = 'BlinkCmpListSelect',
                callback = function(event)
                    if list.selected_item_idx == nil then
                        docs.auto_show_item(event.data.context, list.items[1])
                    end
                end,
            })

            local orig_update_position = docs.update_position
            docs.update_position = function(...)
                orig_update_position(...)

                if not docs.win:is_open() or not menu.win:is_open() then return end

                local doc_winnr = docs.win:get_win()
                if not doc_winnr then return end

                local dwin_conf = vim.api.nvim_win_get_config(doc_winnr)
                local drow, dcol, dwin, drel = dwin_conf.row, dwin_conf.col, dwin_conf.win, dwin_conf.relative

                local menu_border_size = menu.win:get_border_size()
                local menu_left, menu_top = -menu_border_size.left, -menu_border_size.top

                if dcol > menu_left then
                    dcol = dcol + 1
                elseif dcol < menu_left then
                    dcol = dcol - 1
                elseif drow > menu_top then
                    drow = drow + 1
                elseif drow < menu_top then
                    drow = drow - 1
                end

                vim.api.nvim_win_set_config(doc_winnr, {
                    relative = drel,
                    win = dwin,
                    row = drow,
                    col = dcol,
                })
            end
        end)

        return {
            keymap = {
                preset = 'none',

                ['<C-space>'] = { 'show' },

                ['<C-e>'] = { 'cancel' },
                ['<C-y>'] = { 'select_and_accept' },

                ['<C-p>'] = { 'select_prev' },
                ['<C-n>'] = { 'select_next' },

                ['<C-u>'] = { scroll_by_4('scroll_signature_up') },
                ['<C-d>'] = { scroll_by_4('scroll_signature_down') },

                ['<C-k>'] = { scroll_by_4('scroll_documentation_up') },
                ['<C-j>'] = { scroll_by_4('scroll_documentation_down') },

                ['<Tab>']   = { 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

                ['<C-S-s>'] = { 'show_signature', 'hide_signature' },
            },

            completion = {
                keyword = { range = 'prefix' },

                trigger = {
                    prefetch_on_insert = true,
                    show_in_snippet = true,
                    show_on_backspace = false,
                    show_on_backspace_in_keyword = false,
                    show_on_backspace_after_accept = false,
                    show_on_backspace_after_insert_enter = false,
                    show_on_keyword = true,
                    show_on_trigger_character = true,
                    show_on_insert = false,
                    show_on_accept_on_trigger_character = false,
                    show_on_insert_on_trigger_character = false,
                },

                list = {
                    selection = { preselect = false, auto_insert = true },
                    cycle = { from_bottom = true, from_top = true },
                },

                accept = {
                    create_undo_point = true,
                    auto_brackets = { enabled = false },
                },

                menu = {
                    enabled = true,
                    scrolloff = vim.o.scrolloff,
                    min_width = MIN_WIDTH,
                    max_height = vim.o.pumheight,
                    winblend = WIN_BLEND,
                    border = BORDER,
                    scrollbar = SCROLLBAR,
                    direction_priority = { 's', 'n' },
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    draw = {
                        snippet_indicator = '',
                        treesitter = {},

                        cursorline_priority = 10000,
                        align_to = 'label',
                        padding = 0,
                        gap = 1,

                        columns = { { 'kind_icon' }, { 'label' }, { 'source_icon' } },
                        components = {
                            kind_icon = {
                                ellipsis = false,
                                text = function(ctx)
                                    return ' ' .. ctx.kind_icon .. ' '
                                end,
                                highlight = function(ctx)
                                    local kind_hl = ctx.kind_hl

                                    if ctx.item.kind == Color then
                                        local current_hl = vim.api.nvim_get_hl(0, { name = kind_hl, link = false })
                                        local current_hl_fg_hex = string.format('#%06x', current_hl.fg)
                                        local l = utils.luminance(current_hl_fg_hex)

                                        kind_hl = 'swapped_' .. kind_hl

                                        vim.api.nvim_set_hl(0, kind_hl, {
                                            bg = current_hl.fg,
                                            fg = l < 0.6 and c.text or c.base,
                                            default = true,
                                        })
                                    end

                                    return {{ group = kind_hl, priority = 20000 }}
                                end,
                            },

                            label = {
                                width = { fill = true, max = MAX_WIDTH - 3 - 1 - 3 - 1 },
                                text = function(ctx)
                                    local label = ctx.label
                                    local detail = ctx.label_detail

                                    label = string.gsub(string.gsub(label, '^%s+', ''), '%s+$', '')
                                    detail = string.gsub(string.gsub(detail, '^%s+', ''), '%s+$', '')

                                    local ret = label

                                    if #detail > 0 then
                                        ret = ret .. detail
                                    end

                                    local curr_full_width = 3 + 1 + #ret + 1 + 3
                                    if curr_full_width < MIN_WIDTH then
                                        ret = ret .. string.rep(' ', MIN_WIDTH - curr_full_width)
                                    end

                                    return ret
                                end,
                                highlight = function(ctx)
                                    local label = ctx.label
                                    local detail = ctx.label_detail

                                    local first_char, _ = string.find(label, '[^%s]') or 1, 1

                                    label = string.gsub(string.gsub(label, '^%s+', ''), '%s+$', '')
                                    detail = string.gsub(string.gsub(detail, '^%s+', ''), '%s+$', '')

                                    local highlights = {
                                        { 0, #label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
                                    }

                                    if #detail > 0 then
                                        table.insert(highlights, { #label, #label + #detail, group = 'BlinkCmpLabelDetail' })
                                    end

                                    for _, idx in ipairs(ctx.label_matched_indices) do
                                        local leading_space_len = first_char - 1
                                        idx = idx - leading_space_len
                                        table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                                    end

                                    return highlights
                                end,
                                ellipsis = true,
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
                                highlight = function(_)
                                    return {
                                        {
                                            group = 'BlinkCmpSourceIcon',
                                            priority = 20000,
                                        },
                                    }
                                end
                            },
                        },
                    },
                },

                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    update_delay_ms = 50,
                    treesitter_highlighting = true,
                    window = {
                        min_width = MIN_WIDTH,
                        max_width = MAX_WIDTH,
                        max_height = MAX_HEIGHT,
                        border = BORDER,
                        winblend = WIN_BLEND,
                        scrollbar = SCROLLBAR,
                        direction_priority = {
                            menu_north = { 'e', 'w', 'n', 's' },
                            menu_south = { 'e', 'w', 's', 'n' },
                        },
                    },
                },

                ghost_text = {
                    enabled = true,
                    show_with_selection = false,
                    show_without_selection = true,
                    show_with_menu = true,
                    show_without_menu = false,
                },
            },

            signature = {
                enabled = true,

                trigger = {
                    enabled = true,
                    show_on_keyword = true,
                    show_on_trigger_character = true,
                    show_on_insert = true,
                    show_on_insert_on_trigger_character = true,
                },

                window = {
                    min_width = MIN_WIDTH,
                    max_width = MAX_WIDTH,
                    max_height = MAX_HEIGHT,
                    border = BORDER,
                    winblend = WIN_BLEND,
                    scrollbar = SCROLLBAR,
                    direction_priority = { 'n', 's' },
                    treesitter_highlighting = true,
                    show_documentation = true,
                },
            },

            fuzzy = {
                implementation = 'prefer_rust_with_warning',
                frecency = { enabled = false },
                use_proximity = true,
                sorts = {
                    'exact',
                    'score',
                    'sort_text',
                },
                prebuilt_binaries = {
                    download = false,
                    ignore_version_mismatch = false,
                },
            },

            sources = {
                default = { 'path', 'lsp', 'buffer' },
                min_keyword_length = 0,

                providers = {
                    path = {
                        score_offset = 999999,
                        fallbacks = { 'lsp' },
                        opts = {
                            trailing_slash = false,
                            label_trailing_slash = true,
                            show_hidden_files_by_default = true,
                            ignore_root_slash = false,
                        }
                    },

                    lsp = {
                        score_offset = 0,
                        fallbacks = {},
                        opts = { tailwind_color_icon = '󰉦' },
                    },

                    buffer = {
                        score_offset = -999999,
                        opts = {
                            get_bufnrs = all_regular_bufnrs,
                            get_search_bufnrs = all_regular_bufnrs,
                            retention_order = { 'focused', 'visible', 'recency', 'largest' },
                            use_cache = true,
                            enable_in_ex_commands = false,
                        }
                    },
                }
            },

            appearance = {
                nerd_font_variant = 'mono',
                kind_icons = {
                    Class = '󱡠',
                    Color = '󰉦',
                    Constant = '󰏿',
                    Constructor = '󰖷',
                    Enum = '',
                    EnumMember = '',
                    Event = '',
                    Field = '󰜢',
                    File = '󰈙',
                    Folder = '󰉋',
                    Function = '󰊕',
                    Interface = '󱡠',
                    Keyword = '󰌋',
                    Method = '󰊕',
                    Module = '',
                    Operator = '󱓉',
                    Property = '󰜢',
                    Reference = '',
                    Snippet = '',
                    Struct = '󱡠',
                    Text = '󰉿',
                    TypeParameter = '',
                    Unit = '󰑭',
                    Value = '󰎠',
                    Variable = '󰀫',
                },
            },

            cmdline = {
                enabled = true,

                keymap = {
                    preset = 'inherit',

                    ['<C-u>'] = false,
                    ['<C-e>'] = { 'cancel', 'fallback' },
                    ['<C-p>'] = { 'select_prev', 'fallback' },
                    ['<C-n>'] = { 'select_next', 'fallback' },
                    ['<Tab>'] = { 'select_and_accept', 'fallback' },
                },

                sources = function()
                    local type = vim.fn.getcmdtype()
                    if type == '/' or type == '?' then return { 'buffer' } end
                    if type == ':' or type == '@' then return { 'cmdline', 'buffer' } end
                    return {}
                end,

                completion = {
                    list = { selection = { preselect = false, auto_insert = true } },
                    menu = { auto_show = true },
                    ghost_text = { enabled = true },
                }
            },

            term = { enabled = false },
        }
    end,
}
