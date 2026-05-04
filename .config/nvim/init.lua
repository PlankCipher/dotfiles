vim.loader.enable()

require('plankcipher.core.settings')
require('plankcipher.core.options')
require('plankcipher.core.terminal')
require('plankcipher.core.diagnostic')
require('plankcipher.core.lsp')
require('plankcipher.core.quickfix')

require('plankcipher.keymappings.movement')
require('plankcipher.keymappings.terminal')
require('plankcipher.keymappings.make_and_run')
require('plankcipher.keymappings.diagnostic')
require('plankcipher.keymappings.lsp')

require('plankcipher.plugins')
