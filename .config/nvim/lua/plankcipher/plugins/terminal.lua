vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.opt_local.spell = false
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false

    vim.api.nvim_cmd({cmd = 'startinsert'}, {})

    vim.b.close_on_0_status = vim.g.close_on_0_status
    vim.g.close_on_0_status = nil
  end,
})

vim.api.nvim_create_autocmd('TermClose', {
  pattern = '*',
  callback = function(event)
    if vim.v.event.status == 0 and vim.b.close_on_0_status then
      vim.api.nvim_buf_delete(event.buf, {})
      vim.api.nvim_cmd({cmd = 'match', args = {'TrailingWhitespace', [[/\s\+$/]]}}, {})
    end
  end,
})
