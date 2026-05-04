return {
    dir = '~/.config/nvim/lua/plankcipher/plugins/local/rose_pine_moon',
    lazy = false,
    priority = 1000,
    config = function()
        require('rose_pine_moon').setup()
        vim.cmd.colorscheme('rose-pine-moon')
    end,
}
