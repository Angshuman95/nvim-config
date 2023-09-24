local status_ok, todo = pcall(require, 'todo-comments')
if not status_ok then
    return
end

todo.setup()

vim.api.nvim_set_keymap(
    'n',
    '<leader>td',
    '<cmd>TodoTelescope<cr>',
    { noremap = true, silent = true }
)
