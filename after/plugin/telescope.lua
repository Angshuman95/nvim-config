local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
    return
end

telescope.setup({
    defaults = {
        prompt_prefix = ' ',
        selection_caret = ' ',
        path_display = { 'truncate' },
        layout_config = { prompt_position = 'top' },
        sorting_strategy = 'ascending',
    },
})

local tabs_ok, telescope_tabs = pcall(require, 'telescope-tabs')
if not tabs_ok then
    return
end

telescope_tabs.setup()

vim.api.nvim_set_keymap(
    'n',
    '<leader>tt',
    ':lua require("telescope-tabs").list_tabs()<CR>',
    { noremap = true, silent = true }
)
