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

        keymap({ 'n', 't' }, '<C-h>', ':NavigatorLeft<cr>', opts)
        keymap({ 'n', 't' }, '<C-j>', ':NavigatorDown<cr>', opts)
        keymap({ 'n', 't' }, '<C-k>', ':NavigatorUp<cr>', opts)
        keymap({ 'n', 't' }, '<C-l>', ':NavigatorRight<cr>', opts)
    end,
    event = 'VimEnter',
}
