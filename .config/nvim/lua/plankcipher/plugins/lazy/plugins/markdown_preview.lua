return {
  'iamcco/markdown-preview.nvim',
  build = 'cd app && yarn install',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  keys = {
    { '<leader>om', '<cmd>MarkdownPreviewToggle<cr>', ft = 'markdown' }
  },
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
    vim.g.mkdp_auto_close = 0
  end,
}
