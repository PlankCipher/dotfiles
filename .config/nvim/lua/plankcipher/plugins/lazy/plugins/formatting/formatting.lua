return {
  'sbdchd/neoformat',
  event = 'VeryLazy',
  config = function()
    vim.g.neoformat_try_formatprg = 0
    vim.g.neoformat_basic_format_align = 0
    vim.g.neoformat_basic_format_retab = 0
    vim.g.neoformat_basic_format_trim = 1
    vim.g.neoformat_run_all_formatters = 0
    vim.g.neoformat_only_msg_on_error = 0
    vim.g.neoformat_try_node_exe = 0

    vim.g.neoformat_enabled_html = {'prettierd'}
    vim.g.neoformat_enabled_css = {'prettierd'}
    vim.g.neoformat_enabled_javascript = {'prettierd'}
    vim.g.neoformat_enabled_javascriptreact = {'prettierd'}
    vim.g.neoformat_enabled_typescript = {'prettierd'}
    vim.g.neoformat_enabled_typescriptreact = {'prettierd'}
    vim.g.neoformat_enabled_json = {'prettierd'}
    vim.g.neoformat_enabled_markdown = {'prettierd'}

    vim.g.neoformat_python_yapf = {
      exe = 'yapf',
      args = {'--style $HOME/.config/nvim/lua/plankcipher/plugins/lazy/plugins/formatting/.style.yapf'},
      stdin = 1,
    }
    vim.g.neoformat_enabled_python = {'yapf'}

    vim.g.neoformat_php_phpcsfixer = {
      exe = 'php-cs-fixer',
      args = {'fix', '-q', '--config $HOME/.config/nvim/lua/plankcipher/plugins/lazy/plugins/formatting/.php-cs-fixer.php'},
      replace = 1,
    }
    vim.g.neoformat_enabled_php = {'phpcsfixer'}

    vim.api.nvim_create_augroup('formatting', {
      clear = false
    })

    function enable_auto_formatting()
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = 'formatting',
        pattern = {'*.html', '*.css', '*.js', '*.jsx', '*.ts', '*.tsx', '*.json', '*.md', '*.py', '*.php'},
        command = 'Neoformat',
      })

      vim.api.nvim_create_autocmd('BufWritePre', {
        group = 'formatting',
        pattern = {'*.c', '*.cpp', '*.h', '*.rs'},
        callback = function() vim.lsp.buf.format({async = false}) end,
      })
    end

    enable_auto_formatting()

    vim.keymap.set('n', '<leader>tf', function()
      if #(vim.api.nvim_get_autocmds({group = 'formatting'})) == 0 then
        enable_auto_formatting()
        print('formatting enabled')
      else
        vim.api.nvim_clear_autocmds({group = 'formatting'})
        print('formatting disabled')
      end
    end)
  end,
}
