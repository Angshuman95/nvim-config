return {
    'MagicDuck/grug-far.nvim',
    config = function()
        require('grug-far').setup()
        vim.keymap.set(
            'n',
            '<leader>sr',
            '<cmd>GrugFar<CR>',
            { desc = 'Search and replace' }
        )
    end,
    cmd = 'GrugFar',
    keys = {
        {
            '<leader>sr',
            '<cmd>GrugFar<CR>',

            silent = true,
        },
    },
}
