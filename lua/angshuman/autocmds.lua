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
    callback = function()
        local filepath = vim.fn.expand('%:p')
        -- Skip mkview if filepath is too long (will cause E190 error)
        if #filepath > 150 then
            return
        end
        vim.cmd('silent! mkview')
    end,
    group = fold_grp,
})

api.nvim_create_autocmd('BufWinEnter', {
    pattern = '*.*',
    callback = function()
        local filepath = vim.fn.expand('%:p')
        if #filepath > 150 then
            return
        end
        vim.cmd('silent! loadview')
    end,
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
