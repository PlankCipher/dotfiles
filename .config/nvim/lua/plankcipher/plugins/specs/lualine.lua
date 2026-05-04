return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = function()
        local utils = require('plankcipher.utils')
        local c = require('rose_pine_moon.colors')

        local rose_pine_theme = {
            normal = {
                a = { bg = c.overlay, fg = c.text                         },
                b = { bg = c.overlay, fg = c.text                         },
                c = { bg = c.base,    fg = c.muted, gui = 'strikethrough' },
            },
            insert = {
                a = { bg = c.overlay, fg = c.text                         },
                b = { bg = c.overlay, fg = c.text                         },
                c = { bg = c.base,    fg = c.muted, gui = 'strikethrough' },
            },
            visual = {
                a = { bg = c.overlay, fg = c.text                         },
                b = { bg = c.overlay, fg = c.text                         },
                c = { bg = c.base,    fg = c.muted, gui = 'strikethrough' },
            },
            replace = {
                a = { bg = c.overlay, fg = c.text                         },
                b = { bg = c.overlay, fg = c.text                         },
                c = { bg = c.base,    fg = c.muted, gui = 'strikethrough' },
            },
            command = {
                a = { bg = c.overlay, fg = c.text                         },
                b = { bg = c.overlay, fg = c.text                         },
                c = { bg = c.base,    fg = c.muted, gui = 'strikethrough' },
            },
            inactive = {
                a = { bg = c.overlay, fg = c.text                         },
                b = { bg = c.overlay, fg = c.text                         },
                c = { bg = c.base,    fg = c.muted, gui = 'strikethrough' },
            },
        }

        return {
            options = {
                theme = rose_pine_theme,
                component_separators = { left = '', right = ''},
                section_separators   = { left = '', right = ''},
                disabled_filetypes = { statusline = {}, winbar = {} },
                ignore_focus = {},
                always_divide_middle = false,
                always_show_tabline = true,
                globalstatus = true,
                refresh = {
                    statusline = vim.o.updatetime,
                    tabline = vim.o.updatetime,
                    winbar = vim.o.updatetime,
                },

                icons_enabled = false,
                padding = { left = 0, right = 0 },
            },

            winbar = {},
            inactive_winbar = {},
            extensions = {},

            sections = {
                lualine_a = {},

                lualine_b = {
                    { '%#lualine_c_normal#  ' },

                    {
                        'filename',

                        file_status = true,
                        shorting_target = 40,
                        newfile_status = true,
                        path = 1,
                        symbols = {
                            modified = '',
                            readonly = '󰈡',
                            unnamed  = '[No Name]',
                            newfile  = '󰐕',
                        },

                        fmt = function(str)
                            local filename = vim.fs.basename(vim.api.nvim_buf_get_name(0))
                            local filetype = vim.bo.filetype

                            local icon, icon_color = utils.get_icon_color(filename, filetype)

                            local prev_icon_color = vim.api.nvim_get_hl(0, { name = 'LualineFilenameIcon', link = false }).bg
                            if not prev_icon_color or
                                (prev_icon_color and
                                string.format('#%06x', prev_icon_color) ~= icon_color) then
                                local l = utils.luminance(icon_color)
                                vim.api.nvim_set_hl(0, 'LualineFilenameIcon', {
                                    fg = l < 0.6 and c.text or c.base,
                                    bg = icon_color,
                                    italic = true,
                                })
                            end

                            return string.format('%%#LualineFilenameIcon# %s %%#lualine_b_normal# %s ', icon, str)
                        end
                    },

                    {
                        function()
                            local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
                            if #buf_clients == 0 then return '' end

                            local names = vim.iter(buf_clients)
                                :map(function(cl) return cl.name end)
                                :totable()
                            names = vim.fn.uniq(names)
                            local names_str = table.concat(names, ', ')

                            return string.format('%%#lualine_c_normal#  %%#LualineLspIcon# 󰒓 %%#LualineLspClients# %s ', names_str)
                        end,
                    },
                    {
                        'diagnostics',

                        sources = { 'nvim_diagnostic' },
                        always_visible = false,
                        sections = { 'error', 'warn', 'info', 'hint' },
                        colored = true,
                        diagnostics_color = {
                            error = 'LualineDiagnosticError',
                            warn  = 'LualineDiagnosticWarn',
                            info  = 'LualineDiagnosticInfo',
                            hint  = 'LualineDiagnosticHint',
                        },
                        symbols = {
                            error = ' ',
                            warn  = ' ',
                            info  = ' ',
                            hint  = ' ',
                        },
                        update_in_insert = true,

                        fmt = function(str) if #str > 0 then return str .. ' ' end end,
                    },

                    {
                        'branch',

                        fmt = function(str)
                            if #str > 0 then
                                return string.format('%%#lualine_c_normal#  %%#LualineBranchIcon#  %%#LualineBranch# %s ', str)
                            end
                        end,
                    },
                    {
                        'diff',

                        symbols = { added = '󰌴 ', modified = '󱅄 ', removed = '󱅁 ' },
                        colored = true,
                        diff_color = {
                            added    = 'LuaLineDiffAdd',
                            modified = 'LuaLineDiffChange',
                            removed  = 'LuaLineDiffDelete',
                        },

                        fmt = function(str) if #str > 0 then return str .. ' ' end end,
                    },

                    {
                        require('noice').api.statusline.mode.get,
                        cond = require('noice').api.statusline.mode.has,

                        fmt = function(str)
                            return string.format(
                                '%%#lualine_c_normal#  %%#LualineShowmodeIcon# 󰍢 %%#LualineShowmode# %s ', str
                            )
                        end
                    }
                },

                lualine_c = {},
                lualine_x = {},

                lualine_y = {
                    {
                        function()
                            local mode = vim.fn.mode()

                            if not string.find('vV', mode, 1, true) then return '' end

                            local vline, vcol = vim.fn.line('v'), vim.fn.col('v')
                            local cline, ccol = vim.fn.line('.'), vim.fn.col('.')
                            local wordcount = vim.fn.wordcount()

                            local lines = math.abs(cline - vline) + 1
                            local cols  = math.abs(ccol - vcol)   + 1
                            local chars = wordcount.visual_chars
                            local bytes = wordcount.visual_bytes
                            local words = wordcount.visual_words

                            local res = ''

                            if mode == '' then
                                res = string.format('%dx%d ', lines, cols)
                            end

                            if chars == bytes then
                                res = res .. string.format('%dL %dC %dW', lines, chars, words)
                            else
                                res = res .. string.format('%dL %dC %dB %dW', lines, chars, bytes, words)
                            end

                            return '%#LualineVisualIcon# 󰩬 %#LualineVisual# ' .. res .. ' %#lualine_c_normal#  '
                        end,
                    },

                    {
                        'encoding',

                        show_bomb = true,

                        fmt = function(str)
                            if #str > 0 then
                                return '%#LualineEncodingIcon#  %#LualineEncoding# ' .. str .. ' '
                            end
                        end,
                    },
                    {
                        'fileformat',

                        symbols = {
                            unix = ' unix',
                            dos = ' dos',
                            mac = ' mac',
                        },

                        fmt = function(str)
                            local variant = str:find('unix') and 'Unix' or 'NonUnix'
                            local hl = string.format('%%#LualineFileformat%s#', variant)
                            local icon_hl = string.format('%%#LualineFileformatIcon%s#', variant)

                            if #vim.bo.fileencoding > 0 then
                                str = string.format('%%#LualineSectionSeparator#%s %s ', hl, str)
                            else
                                local icon_end, _ = string.find(str, ' ', 1, true)
                                local icon = str:sub(1, icon_end - 1)
                                local text = str:sub(icon_end + 1, -1)
                                str = string.format(
                                    '%s %s %s %s ',
                                    icon_hl,
                                    icon,
                                    hl,
                                    text
                                )
                            end

                            if #vim.bo.filetype > 0 then
                                str = str .. '%#LualineSectionSeparator#%#lualine_b_normal# '
                            end

                            return str
                        end,
                    },
                    {
                        'filetype',

                        colored = true,
                        icons_enabled = true,
                        icon_only = false,
                        icon = { align = 'left' },

                        fmt = function(str) if #str > 0 then return str .. ' ' end end,
                    },

                    {
                        '%#lualine_c_normal#  %#LualineProgressIcon#  %#LualineProgress# %P %l/%L '
                    },

                    { '%#lualine_c_normal#  ' },
                },

                lualine_z = {},
            },

            tabline = {
                lualine_a = {},
                lualine_b = {},

                lualine_c = {
                    {
                        function()
                            local LEFT_MORE_DISPLAY      = '%#LualineBufferMoreIcon#  󰄽  %#lualine_c_normal# '
                            local LEFT_MORE_DISPLAY_LEN  = 6

                            local RIGHT_MORE_DISPLAY     = '%#LualineBufferMoreIcon#  󰄾  '
                            local RIGHT_MORE_DISPLAY_LEN = 5

                            local MODIFIED_DISPLAY       = ' '
                            local MODIFIED_DISPLAY_LEN   = 2

                            local MARGIN_DISPLAY         = '%#lualine_c_normal#  '
                            local MARGIN_DISPLAY_LEN     = 2

                            local MAX_LEN         = vim.o.columns - MARGIN_DISPLAY_LEN - MARGIN_DISPLAY_LEN
                            local BUF_DISPLAY_LEN = 20 + 1
                            local MAX_BUFS_NUM    = math.floor(MAX_LEN / BUF_DISPLAY_LEN)
                            local SUB_WIN_LEN     = math.floor((MAX_BUFS_NUM - 1) / 2)

                            local buf_display = function(bufnr)
                                local filename = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
                                local active   = bufnr == vim.api.nvim_get_current_buf()
                                local modified = vim.bo[bufnr].modified

                                local filetype = vim.bo[bufnr].filetype
                                local icon, icon_color = utils.get_icon_color(filename, filetype)
                                local icon_hl = 'LualineBufferIcon' .. icon_color:sub(2, -1)
                                vim.api.nvim_set_hl(0, icon_hl, {
                                    bg = c.overlay,
                                    fg = icon_color,
                                })

                                local name = filename
                                local title_len = 1 + 1 + #name
                                local max_title_len =
                                BUF_DISPLAY_LEN - 1 - 1 - (modified and MODIFIED_DISPLAY_LEN or 0) - 1

                                local padding = string.rep(' ', math.floor((max_title_len - title_len) / 2))

                                local name_len = title_len - 1 - 1
                                local max_name_len = max_title_len - 1 - 1
                                if name_len > max_name_len then
                                    name = string.sub(name, 1, max_name_len - 1)
                                    name = name .. '…'
                                end

                                return string.format(
                                    '%%#%s#▍%s%s%%#%s# %s%s %s%%#lualine_c_normal# ',
                                    active and icon_hl or 'LualineBuffer',
                                    padding,
                                    icon,
                                    active and 'LualineBufferActive' or 'LualineBuffer',
                                    name,
                                    padding,
                                    modified and MODIFIED_DISPLAY or ''
                                )
                            end

                            local is_buf_included = function(b)
                                if vim.bo[b].filetype == 'help'                        then return false end
                                if vim.bo[b].filetype == 'qf'                          then return false end
                                if vim.bo[b].filetype == 'dashboard'                   then return false end
                                if vim.fs.basename(vim.api.nvim_buf_get_name(b)) == '' then return false end
                                if vim.fn.buflisted(b) ~= 1                            then return false end

                                return true
                            end

                            local bufs = vim.tbl_filter(is_buf_included, vim.api.nvim_list_bufs())

                            local cur_buf_index = 1
                            for i, bufnr in ipairs(bufs) do
                                if bufnr == vim.api.nvim_get_current_buf() then
                                    cur_buf_index = i
                                    break
                                end
                            end

                            local lo1 = math.max(1, cur_buf_index - SUB_WIN_LEN)
                            local hi1 = math.min(cur_buf_index + SUB_WIN_LEN, #bufs)
                            local lo2 = (hi1 - cur_buf_index == SUB_WIN_LEN) and lo1 or lo1 - (SUB_WIN_LEN - (hi1 - cur_buf_index))
                            local hi2 = (cur_buf_index - lo1 == SUB_WIN_LEN) and hi1 or hi1 + (SUB_WIN_LEN - (cur_buf_index - lo1))
                            local lo  = math.max(lo2, 1)
                            local hi  = math.min(hi2, #bufs)

                            local rem_len = MAX_LEN - ((hi - lo + 1) * BUF_DISPLAY_LEN)
                            rem_len = rem_len - (lo > 1     and LEFT_MORE_DISPLAY_LEN  or 0)
                            rem_len = rem_len - (hi < #bufs and RIGHT_MORE_DISPLAY_LEN or 0)

                            if rem_len < 0 then
                                if hi == cur_buf_index then
                                    lo = lo + 1
                                else
                                    hi = hi - 1
                                end
                            end

                            local bufs_to_display = { unpack(bufs, lo, hi) }

                            local res = ''

                            if lo > 1     then res = res .. LEFT_MORE_DISPLAY  end

                            for _, bufnr in ipairs(bufs_to_display) do
                                res = res .. buf_display(bufnr)
                            end

                            if hi < #bufs then res = res .. RIGHT_MORE_DISPLAY end

                            res = MARGIN_DISPLAY .. res .. MARGIN_DISPLAY

                            return res
                        end
                    },
                },

                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        }
    end,
}
