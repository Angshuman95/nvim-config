return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
        {
            '<leader>td',
            ':TodoFzfLua<CR>',
            noremap = true,
            silent = true,
        },
    },
    config = function()
        require('todo-comments').setup()
    end,
}
