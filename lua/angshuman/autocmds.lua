local api = vim.api

-- Highlight on yank
local yank_grp = api.nvim_create_augroup('yank_highlight', { clear = true })
api.nvim_create_autocmd('TextYankPost', {
    command = "silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=300}",
    group = yank_grp,
})

-- Remember Folds
local fold_grp = api.nvim_create_augroup('remember_folds', { clear = true })
api.nvim_create_autocmd('BufWinLeave', {
    pattern = '*.*',
    command = 'mkview',
    group = fold_grp,
})
api.nvim_create_autocmd('BufWinEnter', {
    pattern = '*.*',
    command = 'silent! loadview',
    group = fold_grp,
})

-- Code Build and Run
api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    callback = function()
        vim.schedule(CodeRunner)
    end,
})

function CodeRunner()
    local ft = vim.bo.filetype

    if ft == 'python' then
        vim.api.nvim_set_keymap('n', '<leader>r', ':!clear; python3 %<CR>', {})
    elseif ft == 'cpp' then
        vim.api.nvim_set_keymap(
            'n',
            '<leader>b',
            ':!clear; clang++ -g %<CR>',
            {}
        )
        vim.api.nvim_set_keymap(
            'n',
            '<leader>r',
            ':!clear; clang++ -g %;  if [ -f a.out ]; then time ./a.out; fi <CR>',
            {}
        )
    end
end
