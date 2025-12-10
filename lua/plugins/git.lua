local opts = { noremap = true, silent = true }
local map = vim.keymap.set

return {
    {
        'tpope/vim-fugitive',
        cmd = 'Git',
        keys = {
            {
                '<leader>gg',
                '<cmd>Git<CR>',
                noremap = true,
                silent = true
            },
            {
                '<leader>gd',
                '<cmd>Gvdiffsplit<CR>',
                noremap = true,
                silent = true
            },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
            map('n', '<leader>gj', '<cmd>Gitsigns next_hunk<CR>', opts)
            map('n', '<leader>gk', '<cmd>Gitsigns prev_hunk<CR>', opts)
            map('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', opts)
            map('n', '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>', opts)
            map('n', '<leader>gu', '<cmd>Gitsigns undo_stage_hunk<CR>', opts)
            map(
                'n',
                '<leader>gb',
                '<cmd>Gitsigns toggle_current_line_blame<CR>',
                opts
            )
        end,
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'sindrets/diffview.nvim',
        cmd = 'DiffviewOpen',
    },
}
