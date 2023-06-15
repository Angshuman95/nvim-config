local status_ok, comment = pcall(require, 'Comment')
if not status_ok then
    return
end

comment.setup({
    pre_hook = function(ctx)
        local U = require('Comment.utils')

        local location = nil
        if ctx.ctype == U.ctype.block then
            location =
                require('ts_context_commentstring.utils').get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location =
                require('ts_context_commentstring.utils').get_visual_start_location()
        end

        return require('ts_context_commentstring.internal').calculate_commentstring({
            key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
            location = location,
        })
    end,
})

local nvc_status_ok, nvim_comment = pcall(require, 'nvim_comment')
if not nvc_status_ok then
    return
end

nvim_comment.setup({
    -- Linters prefer comment and line to have a space in between markers
    marker_padding = true,
    -- should comment out empty or whitespace only lines
    comment_empty = true,
    -- trim empty comment whitespace
    comment_empty_trim_whitespace = true,
    -- Should key mappings be created
    create_mappings = false,
    -- Normal mode mapping left hand side
    line_mapping = 'gcc',
    -- Visual/Operator mapping left hand side
    operator_mapping = 'gc',
    -- text object mapping, comment chunk,,
    comment_chunk_text_object = 'ic',
    -- Hook function to call before commenting takes place
    hook = nil,
})

vim.keymap.set('n', '<leader>/', ':CommentToggle<CR>')
vim.keymap.set('v', '<leader>/', ':CommentToggle<CR>')
