return {
    'mistweaverco/kulala.nvim',
    ft = { 'http' },
    config = function()
        require('kulala').setup({
            winbar = true,
        })

        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            '<CR>',
            "<cmd>lua require('kulala').run()<CR>",
            { noremap = true, silent = true, desc = 'Execute the request' }
        )
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            '[',
            "<cmd>lua require('kulala').jump_prev()<CR>",
            { noremap = true, silent = true, desc = 'Jump to previous request' }
        )
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            ']',
            "<cmd>lua require('kulala').jump_next()<CR>",
            { noremap = true, silent = true, desc = 'Jump to next request' }
        )
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            '<leader>i',
            "<cmd>lua require('kulala').inspect()<CR>",
            { noremap = true, silent = true, desc = 'Inspect current request' }
        )
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            '<leader>t',
            "<cmd>lua require('kulala').toggle_view()<CR>",
            { noremap = true, silent = true, desc = 'Toggle view' }
        )
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            '<leader>co',
            "<cmd>lua require('kulala').copy()<CR>",
            {
                noremap = true,
                silent = true,
                desc = 'Copy current request as curl',
            }
        )
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            '<leader>ci',
            "<cmd>lua require('kulala').from_curl()<CR>",
            {
                noremap = true,
                silent = true,
                desc = 'Paste curl from clipboard as http request',
            }
        )
    end,
}
