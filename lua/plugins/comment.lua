return {
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                pre_hook = function(ctx)
                    local U = require('Comment.utils')

                    local location = nil
                    if ctx.ctype == U.ctype.block then
                        location =
                            require('ts_context_commentstring.utils').get_cursor_location()
                    elseif
                        ctx.cmotion == U.cmotion.v
                        or ctx.cmotion == U.cmotion.V
                    then
                        location =
                            require('ts_context_commentstring.utils').get_visual_start_location()
                    end

                    return require('ts_context_commentstring.internal').calculate_commentstring({
                        key = ctx.ctype == U.ctype.line and '__default'
                            or '__multiline',
                        location = location,
                    })
                end,
            })
        end,
        event = { 'BufReadPre', 'BufNewFile' },
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
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        config = function()
            require('ts_context_commentstring').setup()
            vim.g.skip_ts_context_commentstring_module = true
        end,
        ft = { 'ts', 'js' },
    },
}
