local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--single-branch',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {import = 'plankcipher.plugins.lazy.plugins'},
  {import = 'plankcipher.plugins.lazy.plugins.formatting'},
}, {
  lockfile = vim.fn.stdpath('data') .. '/lazy/lazy-lock.json',
  ui = {
    size = { width = 0.84, height = 0.8 },
    border = 'rounded',
    pills = true,
  },
  checker = {
    enabled = false,
    check_pinned = false,
    notify = true,
  },
  change_detection = {
    enabled = false,
    notify = true,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
