return {
    'kylechui/nvim-surround',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
        highlight = { duration = 0 },
        move_cursor = 'sticky',
    },
}
