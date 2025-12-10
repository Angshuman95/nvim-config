return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        modes = {
            preview_float = {
                mode = 'diagnostics',
                preview = {
                    type = 'float',
                    relative = 'editor',
                    border = 'rounded',
                    title = 'Preview',
                    title_pos = 'center',
                    position = { 0, -2 },
                    size = { width = 0.3, height = 0.3 },
                    zindex = 200,
                },
            },
        },
    },

    keys = {
        {
            '<leader>xx',
            '<cmd>Trouble diagnostics toggle<CR>',
            desc = 'Diagnostics (Trouble)',
        },
        {
            '<leader>xX',
            '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
            desc = 'Buffer Diagnostics (Trouble)',
        },
        {
            '<leader>cs',
            '<cmd>Trouble symbols toggle focus=false<CR>',
            desc = 'Symbols (Trouble)',
        },
        {
            '<leader>cl',
            '<cmd>Trouble lsp toggle focus=false win.position=right<CR>',
            desc = 'LSP Definitions / references / ... (Trouble)',
        },
        {
            '<leader>xl',
            '<cmd>Trouble loclist toggle<CR>',
            desc = 'Location List (Trouble)',
        },
        {
            '<leader>xq',
            '<cmd>Trouble qflist toggle<CR>',
            desc = 'Quickfix List (Trouble)',
        },
    },
    cmd = 'Trouble',
}
