return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
        signs = {
            add          = { text = '▌', show_count = false },
            change       = { text = '▌', show_count = false },
            delete       = { text = '▌', show_count = false },
            topdelete    = { text = '▌', show_count = false },
            changedelete = { text = '▌', show_count = false },
            untracked    = { text = '▌', show_count = false },
        },

        signs_staged = {
            add          = { text = '▌', show_count = false },
            change       = { text = '▌', show_count = false },
            delete       = { text = '▌', show_count = false },
            topdelete    = { text = '▌', show_count = false },
            changedelete = { text = '▌', show_count = false },
            untracked    = { text = '▌', show_count = false },
        },
        signs_staged_enable = true,

        signcolumn = true,
        numhl      = true,
        linehl     = false,
        culhl      = false,

        watch_gitdir = {
            enable = true,
            follow_files = true
        },

        diff_opts = {
            ignore_blank_lines = false,
            ignore_whitespace_change = false,
            ignore_whitespace = false,
            ignore_whitespace_change_at_eol = false,
        },

        auto_attach = true,
        attach_to_untracked = false,
        update_debounce = 100,
        current_line_blame = false,
        trouble = false,
        gh = false,
    },
}
