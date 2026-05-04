vim.cmd.filetype({'plugin', 'indent', 'off'})
vim.cmd.filetype({'off'})
vim.cmd.filetype({'plugin', 'on'})

local g = vim.g

g.mapleader = ' '

g.editorconfig = true
g.matchparen_disable_cursor_hl = 0

g.asciidoc_folding = 1
g.asciidoc_foldnested = 1
g.asciidoc_fold_under_title = 1

g.rustc_makeprg_no_percent = 0
g.rust_conceal = 0
g.rust_conceal_mod_path = 0
g.rust_conceal_pub = 0
g.rust_recommended_style = 0
g.rust_fold = 0
g.rust_bang_comment_leader = 1
g.rustfmt_autosave = 0
g.rustfmt_autosave_if_config_present = 0
g.rustfmt_fail_silently = 0
g.rustfmt_options = ''
g.cargo_shell_command_runner = 'terminal'

g.arduino_recommended_style = 0
g.html_expr_folding = 0
g['idris2#allow_tabchar'] = 0
g.markdown_folding = 0
g.org_folding = 0
g.plsql_fold = 0
g.query_lint_on = { 'InsertLeave', 'TextChanged' }
g.qf_disable_statusline = 1
g.rst_style = 0
g.typst_folding = 0
g.sql_type_default = 'mysql'
