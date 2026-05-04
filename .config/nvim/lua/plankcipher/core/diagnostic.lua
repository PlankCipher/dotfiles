local utils = require('plankcipher.utils')

local severity = vim.diagnostic.severity

vim.diagnostic.config({
    underline = true,
    virtual_text = {
        current_line = nil,
        source = true,
        spacing = utils.virt_text_opts.margin,
        prefix = function(_, idx, _)
            return (idx == 1 and string.rep(' ', utils.virt_text_opts.padding) or '') .. ''
        end,
        suffix = string.rep(' ', utils.virt_text_opts.padding),
    },
    virtual_lines = false,
    signs = {
        text = {
            [severity.ERROR] = '',
            [severity.WARN]  = '',
            [severity.INFO]  = '',
            [severity.HINT]  = '',
        },
        numhl = {
            [severity.ERROR] = 'DiagnosticLineNrError',
            [severity.WARN]  = 'DiagnosticLineNrWarn',
            [severity.INFO]  = 'DiagnosticLineNrInfo',
            [severity.HINT]  = 'DiagnosticLineNrHint',
        },
    },
    float = vim.tbl_deep_extend('force', utils.float_win_opts, {
        scope = 'cursor',
        header = '',
        source = true,
        prefix = function(diag, _, _)
            local prefix = ' '
            local hl_groups = {
                [severity.ERROR] = 'DiagnosticFloatingError',
                [severity.WARN]  = 'DiagnosticFloatingWarn',
                [severity.INFO]  = 'DiagnosticFloatingInfo',
                [severity.HINT]  = 'DiagnosticFloatingHint',
            }
            return prefix, hl_groups[diag.severity]
        end,
        suffix = function(diag, _, _)
            return string.format(' [%s]', diag.code), 'Comment'
        end,
    }),
    status = nil,
    update_in_insert = true,
    severity_sort = true,
    jump = { wrap = true },
})

vim.diagnostic.enable()
