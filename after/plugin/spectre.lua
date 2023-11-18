local status_ok, spectre = pcall(require, 'spectre')
if not status_ok then
    return
end

spectre.setup()

-- Keybindings
vim.api.nvim_set_keymap(
    'n',
    '<Leader>S',
    '<cmd>Spectre<CR>',
    { noremap = true, silent = true }
)
