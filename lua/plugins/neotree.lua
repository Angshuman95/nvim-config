return {
    {
        's1n7ax/nvim-window-picker',
        name = 'window-picker',
        event = 'VeryLazy',
        version = '2.*',
        config = function()
            require('window-picker').setup()
        end,
    },
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
            's1n7ax/nvim-window-picker',
        },
        cmd = { 'Neotree' },
        keys = {
            {
                '<leader>e',
                '<cmd>Neotree<CR>',
                silent = true,
            },
        },
        opts = {
            filesystem = {
                follow_current_file = { enabled = true },
            },
            window = {
                mappings = {
                    ['l'] = 'open',
                    ['h'] = 'close_node',
                    ['Y'] = {
                        function(state)
                            local node = state.tree:get_node()
                            local path = node:get_id()
                            vim.fn.setreg('+', path, 'c')
                        end,
                        desc = 'Copy Path to Clipboard',
                    },
                    ['O'] = {
                        function(state)
                            require('lazy.util').open(
                                state.tree:get_node().path,
                                { system = true }
                            )
                        end,
                        desc = 'Open with System Application',
                    },
                },
            },
        },
    },
}
