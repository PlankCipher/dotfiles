return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
        vim.lsp.config('*', {
            exit_timeout = 3 * 1000,
            flags = {
                allow_incremental_sync = true,
                debounce_text_changes = 100,
            },
            trace = 'off',
        })

        local ts_ls_inlay_hints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
        }
        vim.lsp.config('ts_ls', {
            settings = {
                typescript = { inlayHints = ts_ls_inlay_hints },
                javascript = { inlayHints = ts_ls_inlay_hints },
            },
        })

        vim.lsp.config('eslint', {
            settings = {
                packageManager = 'yarn',
            },
        })

        vim.lsp.config('phpactor', {
            init_options = {
                ['language_server.diagnostic_sleep_time'] = 100,
                ['language_server_worse_reflection.inlay_hints.enable'] = true,
                ['language_server_worse_reflection.inlay_hints.types']  = true,
                ['language_server_worse_reflection.inlay_hints.params'] = true,
            },
        })

        vim.lsp.config('rust_analyzer', {
            settings = {
                ['rust-analyzer'] = {
                    completion = {
                        fullFunctionSignatures = {
                            enable = true,
                        },
                    },
                    inlayHints = {
                        maxLength = 99,
                        typeHints = {
                            enable = true,
                            hideClosureInitialization = false,
                            hideClosureParameter = false,
                            hideInferredTypes = false,
                            hideNamedConstructor = false,
                        },
                        parameterHints = { enable = true },
                        lifetimeElisionHints = { enable = false },
                        impliedDynTraitHints = { enable = false },
                        implicitSizedBoundHints = { enable = false },
                        implicitDrops = { enable = false },
                        genericParameterHints = {
                            type = { enable = true },
                            lifetime = { enable = false },
                            const = { enable = true },
                        },
                        expressionAdjustmentHints = { enable = false },
                        closureReturnTypeHints = { enable = true },
                        closureCaptureHints = { enable = false },
                        closingBraceHints = { enable = false },
                        chainingHints = { enable = true },
                    },
                },
            },
        })

        vim.lsp.config('lua_ls', {
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if path ~= vim.fn.stdpath('config') and
                       (vim.uv.fs_stat(path .. '/.luarc.json') or
                       vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        version = 'LuaJIT',
                        path = { 'lua/?.lua', 'lua/?/init.lua' },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = { vim.env.VIMRUNTIME },
                    },
                })
            end,
            settings = {
                Lua = {
                    hint = {
                        enable = true,
                        arrayIndex = 'Disable',
                        await = true,
                        awaitPropagate = true,
                        paramName = 'All',
                        paramType = true,
                        semicolon = 'Disable',
                        setType = true,
                    },
                },
            },
        })

        vim.lsp.enable({
            'html', 'cssls', 'emmet_ls', 'ts_ls', 'clangd',
            'pyright', 'eslint', 'phpactor', 'rust_analyzer',
            'lua_ls',
        })
    end,
}
