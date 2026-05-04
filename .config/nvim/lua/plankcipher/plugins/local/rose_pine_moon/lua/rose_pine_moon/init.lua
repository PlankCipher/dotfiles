local M = {}

M.setup = function()
    vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

    vim.api.nvim_create_autocmd('TextYankPost', {
        pattern = '*',
        callback = function()
            vim.hl.on_yank({ higroup = 'Search', timeout = 100 })
        end,
    })

    local highlight_trailing_whitespace = function()
        for _, match in ipairs(vim.fn.getmatches()) do
            if match.group == 'TrailingWhitespace' then
                return
            end
        end

        vim.cmd.match({ 'TrailingWhitespace', [[/\s\+$/]] })
    end

    vim.api.nvim_create_autocmd('BufEnter', {
        pattern = '*',
        callback = function(event)
            if vim.bo.ft == 'help' or
                string.sub(event.file, 1, 7) == 'term://' or
                event.file == '' or
                vim.bo.ft == '' then
                vim.cmd.match({ 'none' })
            else
                highlight_trailing_whitespace()
            end
        end,
    })

    vim.api.nvim_create_autocmd('WinEnter', {
        pattern = '*',
        callback = function(event)
            if event.file ~= '' and
                vim.bo.ft ~= 'help' then
                highlight_trailing_whitespace()
            end
        end,
    })

    vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'TelescopePrompt', 'lazy' },
        command = 'match none',
    })

    vim.api.nvim_create_autocmd('TermEnter', {
        pattern = '*',
        command = 'match none',
    })

    highlight_trailing_whitespace()
end

return M
