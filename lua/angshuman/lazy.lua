local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

--Remap space as leader key
vim.api.nvim_set_keymap(
    '',
    '<Space>',
    '<Nop>',
    { noremap = true, silent = true }
)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
    return
end

vim.keymap.set(
    'n',
    '<leader>ls',
    ':Lazy sync<CR>',
    { noremap = true, silent = true }
)

return lazy.setup('plugins')

--     'nvimtools/none-ls.nvim',
--     'kevinhwang91/nvim-bqf',
--     { 'folke/trouble.nvim', dependencies = 'nvim-tree/nvim-web-devicons' },
--     {
--         'dgagn/diagflow.nvim',
--         event = 'LspAttach',
--         opts = {},
--     },
--
--     'mfussenegger/nvim-dap',
--     'theHamsta/nvim-dap-virtual-text',
--     'rcarriga/nvim-dap-ui',
-- })
