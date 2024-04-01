local opts = { noremap = true, silent = true }
local map = vim.keymap.set

return {
    {
        'tpope/vim-fugitive',
        config = function()
            map('n', '<leader>gg', ':Git<CR>', opts)
            map('n', '<leader>gd', ':Gvdiffsplit<CR>', opts)
        end,
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
    },
    {
        'sindrets/diffview.nvim',
        event = 'VeryLazy'
    },
}
