return {
    'stevearc/conform.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
        local conform = require('conform')

        local conform_augroup = vim.api.nvim_create_augroup('PCConform', { clear = true })

        local enable_format_on_save = function()
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = conform_augroup,
                pattern = '*',
                callback = function(args)
                    conform.format({
                        bufnr = args.buf,
                        async = false,
                        dry_run = false,
                        undojoin = false,
                    })
                end,
            })
        end

        local disable_format_on_save = function()
            vim.api.nvim_clear_autocmds({ group = conform_augroup })
        end

        vim.keymap.set('n', '<leader>tf', function()
            if #(vim.api.nvim_get_autocmds({ group = conform_augroup })) == 0 then
                enable_format_on_save()
                print('format-on-save enabled')
            else
                disable_format_on_save()
                print('format-on-save disabled')
            end
        end)

        enable_format_on_save()

        conform.setup({
            formatters_by_ft = {
                html            = { 'prettierd'          },
                css             = { 'prettierd'          },
                javascript      = { 'prettierd'          },
                javascriptreact = { 'prettierd'          },
                typescript      = { 'prettierd'          },
                typescriptreact = { 'prettierd'          },
                json            = { 'prettierd'          },
                markdown        = { 'prettierd'          },
                python          = { 'yapf'               },
                php             = { 'php_cs_fixer'       },
                rust            = { 'rustfmt'            },
                c               = { lsp_format = 'first' },
                cpp             = { lsp_format = 'first' },

                ['*']           = { 'trim_whitespace', 'trim_newlines' },
            },
            formatters = {
                yapf = {
                    append_args = {
                        '--style',
                        vim.fn.stdpath('config') .. '/lua/plankcipher/plugins/specs/conform/.style.yapf',
                    },
                },

                php_cs_fixer = {
                    append_args = {
                        '--config',
                        vim.fn.stdpath('config') .. '/lua/plankcipher/plugins/specs/conform/.php-cs-fixer.php',
                    },
                },

                rustfmt = {
                    default_edition = '2024',
                    nightly = true,
                    append_args = {
                        '--config-path',
                        vim.fn.stdpath('config') .. '/lua/plankcipher/plugins/specs/conform/rustfmt.toml',
                    },
                },
            },
            default_format_opts = {
                lsp_format = 'never',
                quiet = false,
                stop_after_first = false,
            },
            log_level = vim.log.levels.OFF,
            format_on_save = nil,
            format_after_save = nil,
            notify_on_error = true,
            notify_no_formatters = false,
        })
    end,
}
