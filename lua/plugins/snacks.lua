return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        picker = { enabled = true },
        indent = { enabled = true },
        statuscolumn = { enabled = true },
        terminal = { enabled = true, win = { style = 'terminal' } },
        scratch = { enabled = true },
        scroll = { enabled = true },
    },
    keys = {
        {
            '<leader>f',
            function()
                Snacks.picker.files()
            end,
            silent = true,
        },
        {
            '<leader>b',
            function()
                Snacks.picker.buffers()
            end,
            silent = true,
        },
        {
            '<leader>st',
            function()
                Snacks.picker.grep()
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
            '<leader>sS',
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            silent = true,
        },
        {
            '<leader>sm',
            function()
                Snacks.picker.marks()
            end,
            silent = true,
        },
        {
            '<leader>sj',
            function()
                Snacks.picker.jumps()
            end,
            silent = true,
        },
        {
            '<leader>sq',
            function()
                Snacks.picker.qflist()
            end,
            silent = true,
        },
        {
            '<leader>.',
            function()
                Snacks.scratch()
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
