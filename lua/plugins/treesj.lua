return {
    'Wansmer/treesj',
    keys = {
        {
            '<leader>j',
            function()
                require('treesj').toggle()
            end,
            desc = 'Toggle block (Treesj)',
        },
    },
    opts = {
        use_default_keymaps = false,
    },
}
