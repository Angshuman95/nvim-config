local opts = { noremap = true, silent = true }
local map = vim.keymap.set

return {
    {
        'tpope/vim-fugitive',
        cmd = 'Git',
        keys = {
            {
                '<leader>gg',
                ':Git<CR>',
                noremap = true,
                silent = true
            },
            {
                '<leader>gd',
                ':Gvdiffsplit<CR>',
                noremap = true,
                silent = true
            },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
            map('n', '<leader>gj', ':Gitsigns next_hunk<CR>', opts)
            map('n', '<leader>gk', ':Gitsigns prev_hunk<CR>', opts)
            map('n', '<leader>gr', ':Gitsigns reset_hunk<CR>', opts)
            map('n', '<leader>gs', ':Gitsigns stage_hunk<CR>', opts)
            map('n', '<leader>gu', ':Gitsigns undo_stage_hunk<CR>', opts)
            map(
                'n',
                '<leader>gb',
                ':Gitsigns toggle_current_line_blame<CR>',
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
