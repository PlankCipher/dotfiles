local M = {}

M.config = {
    banner      = {},
    quotes      = {},
    gap         = 0,
    buffer_opts = {
        fillchars      = vim.tbl_extend('force', vim.opt_local.fillchars:get(), { eob = ' ' }),
        signcolumn     = 'no',
        number         = false,
        relativenumber = false,
        colorcolumn    = '',
        list           = false,
        cursorline     = false,
        spell          = false,
        showtabline    = 0,
    },
}

M.state = {
    opts_old_values     = {},
    quote               = {},
    buf                 = nil,
    win                 = nil,
    augroup             = nil,
    disable_open_event  = false,
    disable_close_event = false,
    open                = false,
}

local save_opts = function()
    local opts_old_values = {}
    for opt_name, _ in pairs(M.config.buffer_opts) do
        opts_old_values[opt_name] = vim.opt_local[opt_name]:get()
    end
    return opts_old_values
end

local set_opts = function()
    for opt_name, new_value in pairs(M.config.buffer_opts) do
        vim.opt_local[opt_name] = new_value
    end
end

local restore_opts = function()
    for opt_name, old_value in pairs(M.state.opts_old_values) do
        vim.opt_local[opt_name] = old_value
    end
end

local create_dashboard_buf = function()
    local dashboard_buf = vim.api.nvim_create_buf(true, true)
    vim.bo[dashboard_buf].filetype = 'dashboard'
    vim.bo[dashboard_buf].modifiable = false
    vim.api.nvim_buf_set_name(dashboard_buf, 'send help plz')
    return dashboard_buf
end

local other_buffers_exist = function()
    local bufs = vim.tbl_filter(function(b)
        return b ~= M.state.buf and
               vim.api.nvim_buf_get_name(b) ~= '' and
               vim.fn.buflisted(b) == 1
    end,
    vim.api.nvim_list_bufs())

    return #bufs ~= 0
end

local delete_the_unnamed_buffer = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_name(buf) == '' and
           vim.bo[buf].filetype == '' then
            vim.api.nvim_buf_delete(buf, {})
        end
    end
end

local center_line_horz = function(line)
    local win_width    = vim.api.nvim_win_get_width(M.state.win)
    local horz_padding = math.floor((win_width / 2) - (vim.api.nvim_strwidth(line) / 2))
    line = string.rep(' ', horz_padding) .. line
    return line
end

local insert_text_with_highlight = function(cur_line, lines, highlight)
    lines = vim.iter(lines)
               :map(function(l) return #l > 0 and center_line_horz(l) or l end)
               :totable()
    vim.api.nvim_buf_set_lines(M.state.buf, cur_line, cur_line + #lines, false, lines)

    vim.hl.range(
        M.state.buf,
        vim.api.nvim_create_namespace('pc_dashboard'), highlight,
        { cur_line, 0 }, { cur_line + #lines - 1, 0 },
        { regtype = 'V' }
    )

    return cur_line + #lines
end

local position_banner_and_message = function()
    vim.bo[M.state.buf].modifiable = true
    vim.api.nvim_buf_set_lines(M.state.buf, 0, -1, false, {})

    local cur_line = 0

    local win_height     = vim.api.nvim_win_get_height(M.state.win)
    local content_height = #M.config.banner + M.config.gap + #M.state.quote + 1 + 1
    local padding_height = math.floor((win_height / 2) - (content_height / 2))
    local padding = {}; for _ = 1, padding_height do table.insert(padding, '') end
    cur_line = insert_text_with_highlight(cur_line, padding, 'Normal')

    cur_line = insert_text_with_highlight(cur_line, M.config.banner, 'DashboardBanner')

    local gap = {}; for _ = 1, M.config.gap do table.insert(gap, '') end
    cur_line = insert_text_with_highlight(cur_line, gap, 'Normal')

    cur_line = insert_text_with_highlight(cur_line, M.state.quote, 'DashboardQuote')

    local stats = require('lazy').stats()
    local startuptime = math.floor(stats.startuptime * 100 + 0.5) / 100
    local loaded, total = stats.loaded, stats.count
    local startup_summary = string.format('%d/%d - %dms', loaded, total, startuptime)
    cur_line = insert_text_with_highlight(cur_line, { '', startup_summary }, 'DashboardStartupSummary')

    vim.api.nvim_win_set_cursor(
        M.state.win,
        { cur_line, #(vim.api.nvim_buf_get_lines(M.state.buf, -2, -1, true)[1]) }
    )

    vim.bo[M.state.buf].modifiable = false
end

local open_handler = function(_)
    if M.state.disable_open_event then return end

    if other_buffers_exist() then
        M.state.disable_close_event = true
        if vim.fn.bufnr(vim.fn.getreg('#')) == M.state.buf then
            vim.cmd.bnext()
        else
            vim.cmd.edit({ '#' })
        end
        M.state.disable_close_event = false
        return
    end

    if M.state.open then return end

    delete_the_unnamed_buffer()

    set_opts()

    M.state.win   = vim.api.nvim_get_current_win()
    M.state.quote = M.config.quotes[math.random(1, #M.config.quotes)]

    position_banner_and_message()

    M.state.open = true
end

local close_handler = function(_)
    if M.state.disable_close_event then return end
    if not M.state.open            then return end

    local initial_win = vim.api.nvim_get_current_win()

    vim.api.nvim_set_current_win(M.state.win)
    restore_opts()
    vim.api.nvim_set_current_win(initial_win)

    M.state.open = false
end

local leave_handler = function(_)
    if vim.api.nvim_get_current_win() ~= M.state.win then
        restore_opts()
    end
end

local create_autocmds
local delete_handler = function(_)
    vim.schedule(function()
        M.state.buf                 = create_dashboard_buf()
        M.state.disable_open_event  = false
        M.state.disable_close_event = false
        M.state.open                = false

        vim.api.nvim_clear_autocmds({ group = M.state.augroup })
        create_autocmds()

        vim.api.nvim_set_current_buf(M.state.buf)
    end)
end

local resize_handler = function(e)
    local win = tonumber(e.match)
    if win and win == M.state.win and
       vim.api.nvim_win_get_buf(win) == M.state.buf then
        position_banner_and_message()
    end
end

local create_autocmd = function(events, callback)
    vim.api.nvim_create_autocmd(events, {
        group    = M.state.augroup,
        buffer   = M.state.buf,
        callback = callback,
    })
end

create_autocmds = function()
    create_autocmd({ 'BufWinEnter', 'TermLeave' }, open_handler)
    create_autocmd({ 'BufWinLeave'              }, close_handler)
    create_autocmd({ 'BufLeave'                 }, leave_handler)
    create_autocmd({ 'BufWipeout'               }, delete_handler)
    create_autocmd({ 'WinResized'               }, resize_handler)
end

local switch_buf_skip_dashboard = function(command)
    M.state.disable_open_event  = true
    M.state.disable_close_event = true

    vim.cmd[command]()
    if vim.api.nvim_get_current_buf() == M.state.buf and
       other_buffers_exist() then
        vim.cmd[command]()
    end

    M.state.disable_open_event  = false
    M.state.disable_close_event = false
end

M.bprevious = function() switch_buf_skip_dashboard('bprevious') end
M.bnext     = function() switch_buf_skip_dashboard('bnext')     end

M.setup = function(opts)
    math.randomseed(os.time())

    M.config = vim.tbl_deep_extend('force', M.config, opts or {})

    M.state.opts_old_values = save_opts()
    M.state.buf             = create_dashboard_buf()
    M.state.augroup         = vim.api.nvim_create_augroup('Dashboard', { clear = true })

    create_autocmds()

    if vim.fn.argc() == 0 then vim.schedule(open_handler) end
end

return M
