vim.lsp.log.set_level(vim.log.levels.OFF)

vim.fn.sign_define('LspCodeActionBulb', { text = '', texthl = 'LspCodeActionSign' })
local code_action_listener = function(bufnr)
    local lnum, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local params = vim.lsp.util.make_range_params(0, 'utf-8')
    params.context = {
        diagnostics = vim.lsp.diagnostic.from(vim.diagnostic.get(0, { lnum = lnum - 1 })),
    }

    vim.lsp.buf_request_all(0, 'textDocument/codeAction', params, function(responses)
        vim.fn.sign_unplace('LspSigns', { buffer = bufnr })

        for _, resp in pairs(responses) do
            if resp.result and not vim.tbl_isempty(resp.result) then
                vim.fn.sign_place(0, 'LspSigns', 'LspCodeActionBulb', bufnr, { lnum = lnum })
                break
            end
        end
    end)
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('PCLspAttachHandler', { clear = true }),
    pattern = '*',
    callback = function(e)
        local client_id = e.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        if not client then return end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local document_highlight_augroup = vim.api.nvim_create_augroup('PCLspDocumentHighlight', {
                clear = false
            })
            vim.api.nvim_clear_autocmds({
                group = document_highlight_augroup,
                buffer = e.buf,
            })
            vim.api.nvim_create_autocmd('CursorHold', {
                group = document_highlight_augroup,
                buffer = e.buf,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd('CursorMoved', {
                group = document_highlight_augroup,
                buffer = e.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeAction) then
            local code_action_augroup = vim.api.nvim_create_augroup('PCLspCodeActionSign', {
                clear = false
            })
            vim.api.nvim_clear_autocmds({
                group = code_action_augroup,
                buffer = e.buf,
            })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                group = code_action_augroup,
                buffer = e.buf,
                callback = function() code_action_listener(e.buf) end,
            })
        end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentColor) then
            vim.lsp.document_color.enable(true, { client_id = client_id }, { style = '󱓻 ' })
        end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_linkedEditingRange) then
            vim.lsp.linked_editing_range.enable(true, { client_id = client_id })
        end

        local all = { bufnr = nil, client_id = nil }
        vim.lsp.codelens.enable(false, all)
        vim.lsp.inlay_hint.enable(false, all)
        vim.lsp.inline_completion.enable(false, all)
        vim.lsp.on_type_formatting.enable(false, all)
        vim.lsp.semantic_tokens.enable(false, all)
    end,
})

local orig_open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(...)
    local bufnr, winid = orig_open_floating_preview(...)
    vim.wo[winid].winhighlight = require('plankcipher.utils').float_win_opts.winhighlight
    return bufnr, winid
end
