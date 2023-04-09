local autogroups = {
    highlight_yank = {
        'TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}'
    },
    remember_folds = {
        'BufWinLeave *.* mkview',
        'BufWinEnter *.* silent! loadview'
    }
    --[[ set_cursor_shape = { ]]
    --[[     'VimEnter,VimResume * set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50' .. ]]
    --[[         ',a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor' .. ]]
    --[[         ',sm:block-blinkwait175-blinkoff150-blinkon175' ]]
    --[[ }, ]]
    --[[ restore_cursor_shape = { ]]
    --[[     'VimLeave,VimSuspend * set guicursor=a:ver90-blinkwait300-blinkon200-blinkoff150' ]]
    --[[ } ]]
}

for group_name, definition in pairs(autogroups) do
    vim.api.nvim_command('augroup ' .. group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
        local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
        vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
end
