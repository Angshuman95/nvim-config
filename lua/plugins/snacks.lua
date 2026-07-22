return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        lazygit = { enabled = true },
        picker = { enabled = true },
        statuscolumn = { enabled = true },
        terminal = { enabled = true, win = { style = 'terminal' } },
    },
    keys = {
        {
            '<leader>b',
            function()
                Snacks.picker.buffers()
            end,
            silent = true,
        },
        {
            '<leader>sp',
            function()
                Snacks.picker()
            end,
            silent = true,
        },
        {
            '<leader>sD',
            function()
                Snacks.picker.diagnostics()
            end,
            silent = true,
            noremap = true,
        },
        {
            '<leader>sd',
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            silent = true,
        },
        {
            '<leader>ss',
            function()
                Snacks.picker.lsp_symbols()
            end,
            silent = true,
        },
        {
            '<leader>td',
            function()
                Snacks.picker.todo_comments()
            end,
            silent = true,
        },
        {
            '<leader>gl',
            function()
                Snacks.lazygit()
            end,
            silent = true,
        },
        {
            '<c-\\>',
            function()
                Snacks.terminal()
            end,
            silent = true,
        },
    },
}
