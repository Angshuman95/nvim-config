return {
    'mistweaverco/kulala.nvim',
    ft = { 'http' },
    config = function()
        require('kulala').setup({
            winbar = true,
        })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'http',
            callback = function(ev)
                vim.keymap.set(
                    'n',
                    '<CR>',
                    "<cmd>lua require('kulala').run()<CR>",
                    {
                        buffer = ev.buf,
                        noremap = true,
                        silent = true,
                        desc = 'Execute the request',
                    }
                )

                vim.keymap.set(
                    'n',
                    '[',
                    "<cmd>lua require('kulala').jump_prev()<CR>",
                    {
                        buffer = ev.buf,
                        noremap = true,
                        silent = true,
                        desc = 'Jump to previous request',
                    }
                )

                vim.keymap.set(
                    'n',
                    ']',
                    "<cmd>lua require('kulala').jump_next()<CR>",
                    {
                        buffer = ev.buf,
                        noremap = true,
                        silent = true,
                        desc = 'Jump to next request',
                    }
                )

                vim.keymap.set(
                    'n',
                    '<leader>i',
                    "<cmd>lua require('kulala').inspect()<CR>",
                    {
                        buffer = ev.buf,
                        noremap = true,
                        silent = true,
                        desc = 'Inspect current request',
                    }
                )

                vim.keymap.set(
                    'n',
                    '<leader>t',
                    "<cmd>lua require('kulala').toggle_view()<CR>",
                    {
                        buffer = ev.buf,
                        noremap = true,
                        silent = true,
                        desc = 'Toggle view',
                    }
                )

                vim.keymap.set(
                    'n',
                    '<leader>co',
                    "<cmd>lua require('kulala').copy()<CR>",
                    {
                        buffer = ev.buf,
                        noremap = true,
                        silent = true,
                        desc = 'Copy current request as curl',
                    }
                )

                vim.keymap.set(
                    'n',
                    '<leader>ci',
                    "<cmd>lua require('kulala').from_curl()<CR>",
                    {
                        buffer = ev.buf,
                        noremap = true,
                        silent = true,
                        desc = 'Paste curl from clipboard as http request',
                    }
                )
            end,
        })
    end,
}
