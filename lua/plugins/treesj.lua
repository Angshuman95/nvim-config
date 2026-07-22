return {
    'Wansmer/treesj',
    keys = {
        {
            '<leader>gm',
            function()
                require('treesj').toggle()
            end,
            desc = 'Toggle block (Treesj)',
        },
        {
            '<leader>gs',
            function()
                require('treesj').split()
            end,
            desc = 'Split block (Treesj)',
        },
        {
            '<leader>gj',
            function()
                require('treesj').join()
            end,
            desc = 'Join block (Treesj)',
        },
    },
    opts = {
        use_default_keymaps = false,
    },
}
