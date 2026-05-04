return {
    'smjonas/inc-rename.nvim',
    keys = {
        {
            '<leader>cr',
            function()
                local saved_iskeyword = vim.bo.iskeyword

                vim.bo.iskeyword = vim.bo.iskeyword .. ',_'
                local cword = vim.fn.expand('<cword>')

                vim.bo.iskeyword = saved_iskeyword

                return ':IncRename ' .. cword
            end,
            expr = true
        },
    },
    opts = {
        cmd_name = 'IncRename',
        hl_group = 'Substitute',
        preview_empty_name = true,
        show_message = true,
        save_in_cmdline_history = false,
        input_buffer_type = nil,
        post_hook = nil,
    }
}
