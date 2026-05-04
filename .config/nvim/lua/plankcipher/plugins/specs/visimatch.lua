return {
    'wurli/visimatch.nvim',
    event = 'VeryLazy',
    opts = {
        hl_group = 'VisiMatch',
        chars_lower_limit = 2,
        lines_upper_limit = 50,
        strict_spacing = true,
        buffers = 'current',
        case_insensitive = false,
    }
}
