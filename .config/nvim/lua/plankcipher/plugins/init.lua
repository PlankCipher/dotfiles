local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.o.rtp = lazypath .. ',' .. vim.o.rtp

require('lazy').setup({
    defaults = { version = false },
    spec = {
        -- {
        --     'stevearc/profile.nvim',
        --     lazy = false,
        --     config = function()
        --         local profiler = require('profile')
        --
        --         profiler.start('*')
        --
        --         vim.api.nvim_create_autocmd('User', {
        --             group = vim.api.nvim_create_augroup('PCStartupProfiler', { clear = true }),
        --             pattern = 'VeryLazy',
        --             callback = function()
        --                 profiler.stop()
        --                 local filename = 'profile.json'
        --                 profiler.export(filename)
        --                 vim.notify(string.format('Wrote %s', filename))
        --             end,
        --         })
        --     end,
        -- },
        { import = 'plankcipher.plugins.specs' },
        { import = 'plankcipher.plugins.specs.conform' },
    },
    lockfile = vim.fn.stdpath('data') .. '/lazy-lock.json',
    git = { throttle = { enabled = false } },
    dev = {
        path = '',
        patterns = {},
        fallback = false,
    },
    install = {
        missing = true,
        colorscheme = { 'rose-pine-moon' },
    },
    ui = {
        size = { width = 0.6, height = 0.6 },
        wrap = true,
        border = 'none',
        backdrop = 100,
        title = nil,
        pills = true,
    },
    headless = {
        process = true,
        log = true,
        task = true,
        colors = true,
    },
    checker = { enabled = false },
    change_detection = { enabled = false },
    performance = {
        rtp = {
            disabled_plugins = {
                'shada',
                'netrwPlugin',
                'gzip',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
    readme = { enabled = false },
    profiling = {
        loader = false,
        require = false,
    },
})
