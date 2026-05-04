return {
    'chrisgrieser/nvim-lsp-endhints',
    event = 'LspAttach',
    opts = function()
        local utils = require('plankcipher.utils')

        return {
            autoEnableHints = true,

            icons = {
                type = '󰜁 ',
                parameter = '󰖷 ',
                offspec = ' ',
                unknown = ' ',
            },

            label = {
                truncateAtChars = 30,
                padding = utils.virt_text_opts.padding,
                marginLeft = utils.virt_text_opts.margin,
                sameKindSeparator = ', ',
            },

            extmark = {
                priority = 50,
            },

            hintFormatFunc = nil,
        }
    end,
}
