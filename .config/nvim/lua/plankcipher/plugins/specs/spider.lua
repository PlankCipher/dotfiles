return {
    'chrisgrieser/nvim-spider',
    keys = {
        {
            'w',
            function() require("spider").motion("w") end,
            mode = { 'n', 'o', 'v' },
        },
        {
            'e',
            function() require("spider").motion("e") end,
            mode = { 'n', 'o', 'v' },
        },
        {
            'b',
            function() require("spider").motion("b") end,
            mode = { 'n', 'o', 'v' },
        },
    },
    config = function()
        vim.keymap.set('n', 'cw', 'ce', { remap = true })

        require('spider').setup({
            skipInsignificantPunctuation = false,
            subwordMovement = true,
            consistentOperatorPending = false,
            customPatterns = {},
        })
    end,
}
