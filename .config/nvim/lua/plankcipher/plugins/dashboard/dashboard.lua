local dashboard_open = false

function open_dashboard()
  dashboard_open = true

  vim.opt.showtabline = 0
  vim.opt.fillchars:append({eob = ' '})
  vim.opt.signcolumn = 'no'
  vim.opt.number = false
  vim.opt.relativenumber = false
  vim.opt.colorcolumn = ''
  vim.opt.list = false
  vim.opt.cursorline = false
  vim.opt.spell = false

  local initial_win = vim.api.nvim_get_current_win()
  local initial_buf = vim.api.nvim_get_current_buf()
  local dashboard_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(initial_win, dashboard_buf)
  vim.api.nvim_buf_delete(initial_buf, {})

  local messages = {
    {
      'Sometimes all I wanna do is head west on 20',
      "in a car I can't afford, with a plan I don't have.",
      'Just me, my music, and the road...',
    },
    {
      'Even a broken clock gets tha chance to be right twice a day',
    },
    {
      'Shitty software everywhere',
    },
    {
      "(( ) => {...})();",
    },
    {
      'Do not go gentle into that good night',
    },
    {
      'Saving people. Hunting things. The family business.',
    },
    {
      "There ain't no me if there ain't no you",
    },
    {
      'What the faculty have you done lately?',
    },
    {
      'Kiss me, I love it.',
    },
    {
      'for he is a friend to none, that is a friend to all',
    },
  }

  math.randomseed(('' .. os.time()):reverse())
  local message_lines = messages[math.random(1, #messages)]

  local term_art_width = 60
  local term_art_height = 21
  local gap = 3
  local entire_height = term_art_height + gap + #message_lines

  local initial_win_width = vim.api.nvim_win_get_width(0)
  local initial_win_height = vim.api.nvim_win_get_height(0)

  local opts = {
    relative = 'win',
    width = term_art_width,
    height = term_art_height,
    col = math.floor((initial_win_width / 2) - (term_art_width / 2)),
    row = math.floor((initial_win_height / 2) - (entire_height / 2)),
    style = 'minimal',
    focusable = false,
  }
  local term_art_win = vim.api.nvim_open_win(0, false, opts)

  vim.api.nvim_set_current_win(term_art_win)
  vim.api.nvim_cmd({cmd = 'te', args = {'cat', '|', '~/.config/nvim/lua/plankcipher/plugins/dashboard/this_is_fine.sh'}}, {})
  vim.api.nvim_set_option_value('buflisted', false, {buf = vim.api.nvim_win_get_buf(0)})
  vim.api.nvim_set_option_value('winblend', 0, {scope = 'local', win = term_art_win})
  vim.api.nvim_set_current_win(initial_win)

  local message_vert_padding = {}
  local message_start_row = math.floor((initial_win_height / 2) + (entire_height / 2)) - #message_lines
  for i = 1, message_start_row do
    table.insert(message_vert_padding, '')
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, true, message_vert_padding)

  for i, line in ipairs(message_lines) do
    local message_horz_padding = math.floor((initial_win_width / 2) - (#line / 2))
    for _ = 1, message_horz_padding do
      line = ' ' .. line
    end
    vim.api.nvim_buf_set_lines(0, message_start_row + i, message_start_row + i, false, {line})
  end

  for i, line in ipairs(message_lines) do
    vim.api.nvim_buf_add_highlight(0, -1, 'Comment', message_start_row + i - 1, 0, -1)
  end

  vim.api.nvim_cmd({cmd = 'stopinsert', args = {}}, {})
  vim.opt_local.modifiable = false
  vim.opt_local.filetype = 'dashboard'
  vim.api.nvim_buf_set_name(0, 'send help')

  return term_art_win, dashboard_buf
end

local term_art_win, buf = nil, nil
if #vim.fn.argv() == 0 then
  term_art_win, buf = open_dashboard()
end

vim.api.nvim_create_augroup('Dashboard', {clear = false})

vim.api.nvim_create_autocmd('BufAdd', {
  group = 'Dashboard',
  pattern = '*',
  callback = function(e)
    if dashboard_open then
      vim.opt.showtabline = 2
      vim.opt.fillchars:append({eob = '~'})
      vim.opt.signcolumn = 'yes'
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.colorcolumn = '80'
      vim.opt.list = true
      vim.opt.cursorline = true
      vim.opt.spell = true

      vim.schedule(function()
        vim.api.nvim_buf_delete(vim.api.nvim_win_get_buf(term_art_win), {force = true})
        vim.api.nvim_buf_delete(buf, {})
      end)

      dashboard_open = false
    end
  end
})

vim.api.nvim_create_autocmd({ 'BufDelete', 'TermLeave' }, {
  group = 'Dashboard',
  pattern = '*',
  callback = function()
    for _, buf_handle in ipairs(vim.api.nvim_list_bufs()) do
      if vim.fn.buflisted(buf_handle) == 1 and
         vim.api.nvim_buf_get_name(buf_handle) == '' and
         vim.api.nvim_get_option_value('ft', {buf = buf_handle}) == '' and
         not dashboard_open then
        term_art_win, buf = open_dashboard()
      end
    end
  end,
})
