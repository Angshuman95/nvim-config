return {
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    },
    {
        'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup({
                create_mappings = false,
            })
        end,
        keys = {
            {
                '<leader>//',
                '<cmd>CommentToggle<CR>',
                'n',
                silent = true,
                noremap = true,
            },
            {
                '<leader>/',
                '<cmd>CommentToggle<CR>',
                mode = 'v',
                silent = true,
                noremap = true,
            },
        },
    }
}
