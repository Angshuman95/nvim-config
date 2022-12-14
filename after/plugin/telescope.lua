local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
    return
end

telescope.setup {
    defaults = {
        prompt_prefix = ' ',
        selection_caret = ' ',
        path_display = { 'truncate' },
        layout_config = { prompt_position = 'top' },
        sorting_strategy = 'ascending'
    }
}
