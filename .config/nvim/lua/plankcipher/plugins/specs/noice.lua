return {
    'folke/noice.nvim',
    dependencies = {
        'MunifTanjim/nui.nvim',
        {
            'rcarriga/nvim-notify',
            opts = function()
                local orig_setwinvar = vim.fn.setwinvar
                vim.fn.setwinvar = function(win, var, val)
                    if string.find(val, ':Notify', 1, true) then
                        val = 'Normal:NotifyBackground,FloatBorder:NotifyBorder,CursorLine:None,Search:None,ErrorMsg:None'
                    end
                    return orig_setwinvar(win, var, val)
                end

                return {
                    level = nil,
                    timeout = 5 * 1000,
                    minimum_width = 50,
                    max_width = 75,
                    max_height = 75,
                    render = 'wrapped-default',
                    stages = 'slide',
                    background_colour = 'NotifyBackground',
                    icons = {
                        ERROR = '',
                        WARN = '',
                        INFO = '',
                        DEBUG = '',
                        TRACE = '✎',
                    },
                    time_formats = {
                        notification = '',
                        notification_history = '%FT%T'
                    },
                    on_open = function(win)
                        vim.api.nvim_win_set_config(win, {
                            border = require('plankcipher.utils').float_win_opts.border,
                        })
                    end,
                    fps = 40,
                    top_down = true,
                }
            end,
        }
    },
    event = 'VeryLazy',
    opts = function()
        local noice_setup_augroup = vim.api.nvim_create_augroup('PCNoiceSetup', { clear = true })

        vim.api.nvim_create_autocmd('QuickFixCmdPre', {
            group = noice_setup_augroup,
            pattern = 'make',
            callback = function()
                require('noice').disable()
            end,
        })

        vim.api.nvim_create_autocmd('QuickFixCmdPost', {
            group = noice_setup_augroup,
            pattern = 'make',
            callback = function()
                vim.fn.getchar()
                vim.fn.feedkeys(' ', 't')
                require('noice').enable()
            end,
        })

        local border = { '█', 'NoiceCmdlinePopupBorderChar' }

        return {
            cmdline = {
                enabled = true,
                view = 'cmdline_popup',
                opts = {},
                format = {
                    cmdline     = { pattern = '^:',              icon = '', title = '  Command ', lang = 'vim' },
                    search_down = { pattern = '^/',              icon = '󰍉', title = ' 󰍉 Search ',  lang = 'regex', kind = 'search' },
                    search_up   = { pattern = '^%?',             icon = '󰍉', title = ' 󰍉 Search ',  lang = 'regex', kind = 'search' },
                    filter      = { pattern = '^:%s*!',          icon = '$', title = '   Filter ', lang = 'bash' },
                    help        = { pattern = '^:%s*he?l?p?%s+', icon = '', title = '  Help ' },
                    lua         = { pattern = { '^:%s*lua%s+', '^:%s*=%s*' }, icon = '', lang = 'lua', title = '  Lua ' },
                    input       = { view = 'cmdline_input', icon = '󰥻 ' },

                    IncRename   = { pattern = '^:%s*IncRename%s+', icon = ' ', title = '', view = 'inc_rename' },
                },
            },
            messages = {
                enabled = true,
                view = 'notify',
                view_error = 'notify',
                view_warn = 'notify',
                view_history = 'messages',
                view_search = false,
            },
            popupmenu = { enabled = false },
            commands = {
                all = {
                    view = 'split',
                    opts = { enter = true, format = 'details' },
                    filter = {},
                },
            },
            notify = {
                enabled = true,
                view = 'notify',
            },
            lsp = {
                progress = {
                    enabled = true,
                    format = 'lsp_progress',
                    format_done = 'lsp_progress_done',
                    view = 'mini',
                },
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = false,
                    ['vim.lsp.util.stylize_markdown'] = false,
                    ['cmp.entry.get_documentation'] = false,
                },
                hover = { enabled = false },
                signature = { enabled = false },
                message = {
                    enabled = true,
                    view = 'notify',
                },
            },
            markdown = {
                hover = {},
                highlights = {},
            },
            presets = {
                bottom_search = false,
                command_palette = false,
                long_message_to_split = false,
                inc_rename = false,
                lsp_doc_border = false,
            },
            views = {
                cmdline_popup = {
                    backend = 'popup',
                    border = {
                        padding = { 0, 1 },
                        style = {
                            border, border, border, border, border, border, border, border
                        },
                        text = { top_align = 'center' },
                    },
                    relative = 'editor',
                    position = { row = '50%', col = '50%' },
                    size = { width = 65, height = 1 },
                },
                cmdline_input = {
                    view = 'cmdline_popup',
                    border = {
                        padding = { 0, 1 },
                        style = {
                            border, border, border, border, border, border, border, border
                        },
                        text = { top_align = 'center' },
                    },
                },
                inc_rename = {
                    view = 'cmdline_popup',
                    relative = 'cursor',
                    position = { row = 2, col = -3 },
                    size = { width = 30, height = 1 },
                },
                messages = {
                    view = 'split',
                    enter = true,
                },
                split = {
                    backend = 'split',
                    enter = false,
                    relative = 'editor',
                    position = 'bottom',
                    size = '30',
                    close = { keys = { 'q' } },
                },
                notify = {
                    backend = { 'notify' },
                    format = 'notify',
                    timeout = 5 * 1000,
                    replace = false,
                    hide_from_history = false,
                    merge = false,
                },
                mini = {
                    backend = 'mini',
                    relative = 'editor',
                    position = { row = -1, col = '100%' },
                    size = {
                        width = 'auto',
                        height = 'auto',
                        max_height = 25,
                    },
                    align = 'message-right',
                    timeout = 5 * 1000,
                    reverse = true,
                    focusable = false,
                    border = { style = 'none' },
                    win_options = { winblend = 0 },
                },
                confirm = {
                    backend = 'popup',
                    relative = 'editor',
                    focusable = false,
                    align = 'center',
                    enter = false,
                    format = { '{message}' },
                    position = { row = '50%', col = '50%' },
                    size = { width = 'auto', height = 'auto' },
                    border = {
                        padding = { 0, 1 },
                        style = {
                            border, border, border, border, border, border, border, border
                        },
                        text = { top = { {' 󰙁 Confirm ', 'NoiceCmdlinePopupBorder'} }, top_align = 'center' },
                    },
                },
            },
            format = {
                lsp_progress = {
                    {
                        '{progress} ',
                        key = 'progress.percentage',
                        contents = { { '{data.progress.message} ' } },
                    },
                    '({data.progress.percentage}%) ',
                    { '{spinner} ', hl_group = 'NoiceLspProgressSpinner' },
                    { '{data.progress.title} ', hl_group = 'NoiceLspProgressTitle' },
                    { '{data.progress.client} ', hl_group = 'NoiceLspProgressClient' },
                },
                lsp_progress_done = {
                    { ' ', hl_group = 'NoiceLspProgressSpinnerDone' },
                    { '{data.progress.title} ', hl_group = 'NoiceLspProgressTitle' },
                    { '{data.progress.client} ', hl_group = 'NoiceLspProgressClient' },
                },
            },
            routes = {
                {
                    filter = {
                        event = 'msg_show',
                        any = {
                            { find = '%d+L, %d+B' },
                            { find = '; after #%d+' },
                            { find = '; before #%d+' },
                            { find = '1 line less' },
                            { find = '%d+ fewer lines' },
                            { find = '1 more line' },
                            { find = '%d+ more lines' },
                            { find = '%d+ lines? yanked' },
                            { find = '%d+ lines? moved' },
                            { find = '%d+ lines? indented' },
                            { find = '%d+ lines? to indent' },
                            { find = '[<>]ed %d+ time' },
                        },
                    },
                    view = 'mini',
                },
                {
                    filter = {
                        event = 'msg_show',
                        any = {
                            {
                                kind = {
                                    'shell_cmd',
                                    'shell_err',
                                    'shell_out',
                                    'shell_ret',
                                }
                            },
                        }
                    },
                    view = 'mini',
                    opts = {
                        reverse = false,
                        timeout = 10 * 1000,
                    },
                },
            },
        }
    end,
}
