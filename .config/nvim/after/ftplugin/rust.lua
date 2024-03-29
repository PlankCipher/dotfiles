vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- local lspconfig = require('lspconfig')
--
-- function code_action_listener()
--   local params = vim.lsp.util.make_range_params()
--
--   local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
--   params.context = context
--
--   vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, result, ctx, config)
--     vim.fn.sign_unplace('LspSigns', {buffer = vim.api.nvim_buf_get_name(0)})
--
--     if err or not result or vim.tbl_isempty(result) then
--       return
--     end
--
--     local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
--     vim.fn.sign_place(0, 'LspSigns', 'LspCodeAction', vim.api.nvim_buf_get_name(0), {lnum = row})
--   end)
-- end
--
-- local on_attach = function(client, bufnr)
--   if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
--     vim.api.nvim_create_augroup('lsp_document_highlight', {
--       clear = false
--     })
--     vim.api.nvim_clear_autocmds({
--       buffer = bufnr,
--       group = 'lsp_document_highlight',
--     })
--     vim.api.nvim_create_autocmd('CursorHold', {
--       group = 'lsp_document_highlight',
--       buffer = bufnr,
--       callback = vim.lsp.buf.document_highlight,
--     })
--     vim.api.nvim_create_autocmd('CursorMoved', {
--       group = 'lsp_document_highlight',
--       buffer = bufnr,
--       callback = vim.lsp.buf.clear_references,
--     })
--   end
--
--   if client.supports_method(vim.lsp.protocol.Methods.textDocument_codeAction) then
--     vim.api.nvim_create_augroup('lsp_code_action_sign', {
--       clear = false
--     })
--     vim.api.nvim_clear_autocmds({
--       buffer = bufnr,
--       group = 'lsp_code_action_sign',
--     })
--     vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
--       group = 'lsp_code_action_sign',
--       buffer = bufnr,
--       callback = code_action_listener,
--     })
--   end
-- end
--
-- local on_init = function(client, _)
--   client.server_capabilities.semanticTokensProvider = nil
-- end
--
-- local lsp_flags = {
--   debounce_text_changes = 100,
-- }
--
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
--
-- local rust_analyzer_config = {
--   on_attach = on_attach,
--   on_init = on_init,
--   flags = lsp_flags,
--   capabilities = capabilities,
--   settings = {
--     ['rust-analyzer'] = {
--       completion = {
--         fullFunctionSignatures = {
--           enable = true,
--         },
--       },
--       rustfmt = {
--         extraArgs = {
--           '--config-path', os.getenv('HOME') .. '/.config/nvim/lua/plankcipher/plugins/lazy/plugins/formatting/rustfmt.toml',
--         },
--       },
--     },
--   },
-- }
--
-- local current_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
-- local cargo_root_dir_cmd = 'cd ' .. current_dir .. ' && cargo locate-project &> /dev/null'
-- local exit_code = os.execute(cargo_root_dir_cmd)
--
-- if exit_code ~= 0 then
--   rust_analyzer_config.init_options = {
--     detachedFiles = {
--       vim.api.nvim_buf_get_name(0),
--     },
--   }
--
--   rust_analyzer_config.root_dir = function()
--     return vim.fs.dirname(vim.api.nvim_buf_get_name(0))
--   end
-- end
--
-- lspconfig.rust_analyzer.setup(rust_analyzer_config)
