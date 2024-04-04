return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('trouble').setup({
            mode = 'document_diagnostics',
        })
        -- Lua
        vim.keymap.set(
            'n',
            '<leader>w',
            '<cmd>TroubleToggle<cr>',
            { silent = true, noremap = true }
        )
        vim.keymap.set(
            'n',
            '<leader>ww',
            '<cmd>TroubleToggle workspace_diagnostics<cr>',
            { silent = true, noremap = true }
        )
        vim.keymap.set(
            'n',
            '<leader>wd',
            '<cmd>TroubleToggle document_diagnostics<cr>',
            { silent = true, noremap = true }
        )
        vim.keymap.set(
            'n',
            '<leader>wl',
            '<cmd>TroubleToggle loclist<cr>',
            { silent = true, noremap = true }
        )
        vim.keymap.set(
            'n',
            '<leader>wq',
            '<cmd>TroubleToggle quickfix<cr>',
            { silent = true, noremap = true }
        )
        vim.keymap.set(
            'n',
            'gR',
            '<cmd>TroubleToggle lsp_references<cr>',
            { silent = true, noremap = true }
        )
    end,
}
