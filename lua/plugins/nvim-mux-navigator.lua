return {
    'numToStr/Navigator.nvim',
    config = function()
        require('Navigator').setup({
            auto_save = 'all',
            disable_on_zoom = false,
            mux = 'auto',
        })

        local opts = { noremap = true, silent = true }
        local keymap = vim.keymap.set

        keymap({ 'n', 't' }, '<C-h>', '<cmd>NavigatorLeft<CR>', opts)
        keymap({ 'n', 't' }, '<C-j>', '<cmd>NavigatorDown<CR>', opts)
        keymap({ 'n', 't' }, '<C-k>', '<cmd>NavigatorUp<CR>', opts)
        keymap({ 'n', 't' }, '<C-l>', '<cmd>NavigatorRight<CR>', opts)
    end,
    event = 'VimEnter',
}
