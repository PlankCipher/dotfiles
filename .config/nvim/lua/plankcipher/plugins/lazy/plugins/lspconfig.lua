return {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')

    function merge_tables(a, b)
      local result = {}

      for key, value in pairs(a) do
        result[key] = value
      end

      for key, value in pairs(b) do
        result[key] = value
      end

      return result
    end

    function code_action_listener()
      local current_row, _ = unpack(vim.api.nvim_win_get_cursor(0))

      local params = vim.lsp.util.make_range_params()
      params.context = {
        diagnostics = vim.diagnostic.get(0, { lnum = current_row }),
      }

      vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, result, ctx, config)
        vim.fn.sign_unplace('LspSigns', {buffer = vim.api.nvim_buf_get_name(0)})

        if err or not result or vim.tbl_isempty(result) then
          return
        end

        vim.fn.sign_place(0, 'LspSigns', 'LspCodeAction', vim.api.nvim_buf_get_name(0), { lnum = current_row })
      end)
    end

    local on_attach = function(client, bufnr)
      if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        vim.api.nvim_create_augroup('lsp_document_highlight', {
          clear = false
        })
        vim.api.nvim_clear_autocmds({
          buffer = bufnr,
          group = 'lsp_document_highlight',
        })
        vim.api.nvim_create_autocmd('CursorHold', {
          group = 'lsp_document_highlight',
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
          group = 'lsp_document_highlight',
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end

      if client.supports_method(vim.lsp.protocol.Methods.textDocument_codeAction) then
        vim.api.nvim_create_augroup('lsp_code_action_sign', {
          clear = false
        })
        vim.api.nvim_clear_autocmds({
          buffer = bufnr,
          group = 'lsp_code_action_sign',
        })
        vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
          group = 'lsp_code_action_sign',
          buffer = bufnr,
          callback = code_action_listener,
        })
      end
    end

    local on_init = function(client, _)
      client.server_capabilities.semanticTokensProvider = nil
    end

    local lsp_flags = {
      debounce_text_changes = 100,
    }

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local base_config = {
      on_attach = on_attach,
      on_init = on_init,
      flags = lsp_flags,
      capabilities = capabilities,
    }

    local servers = {
      html = base_config,
      cssls = base_config,
      emmet_ls = base_config,
      tsserver = base_config,
      clangd = base_config,
      pyright = base_config,

      eslint = merge_tables(base_config, {
        settings = {
          packageManager = 'yarn',
        },
      }),

      phpactor = merge_tables(base_config, {
        init_options = {
          ['language_server.diagnostic_sleep_time'] = 100,
        },
      }),

      rust_analyzer = merge_tables(base_config, {
        settings = {
          ['rust-analyzer'] = {
            completion = {
              fullFunctionSignatures = {
                enable = true,
              },
            },
            rustfmt = {
              extraArgs = {
                '+nightly',
                '--config-path', os.getenv('HOME') .. '/.config/nvim/lua/plankcipher/plugins/lazy/plugins/formatting/rustfmt.toml',
              },
            },
          },
        },
      }),
    }

    for server, config in pairs(servers) do
      lspconfig[server].setup(config)
    end

    vim.diagnostic.config({
      virtual_text = {
        source = true,
        prefix = '󰓛',
      },
      signs = {
        numhl = {
          [vim.diagnostic.severity.ERROR] = 'DiagnosticLineNrError',
          [vim.diagnostic.severity.WARN] = 'DiagnosticLineNrWarn',
          [vim.diagnostic.severity.INFO] = 'DiagnosticLineNrInfo',
          [vim.diagnostic.severity.HINT] = 'DiagnosticLineNrHint',
        },
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.INFO] = '',
          [vim.diagnostic.severity.HINT] = '',
        },
      },
      float = {
        source = true,
        border = 'rounded',
      },
      update_in_insert = true,
      severity_sort = true,
    })

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or 'rounded'
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    local opts = {noremap=true, silent=true}

    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.jump({count=-1, float=true}) end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.jump({count=1, float=true}) end, opts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gh', '<cmd>ClangdSwitchSourceHeader<cr>', opts)
  end,
}
