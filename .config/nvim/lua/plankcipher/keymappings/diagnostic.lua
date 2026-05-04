vim.keymap.set('n', '<leader>q', function() vim.diagnostic.setloclist({ open = true }) end)

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

local jump_and_open_diag = function(count)
    vim.diagnostic.jump({
        count = count,
        on_jump = function(_, _) vim.schedule(vim.diagnostic.open_float) end
    })
end

vim.keymap.set('n', '[d', function() jump_and_open_diag(-1) end)
vim.keymap.set('n', ']d', function() jump_and_open_diag(1) end)
