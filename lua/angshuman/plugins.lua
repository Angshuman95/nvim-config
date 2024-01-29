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

return lazy.setup({
    'nvim-lua/plenary.nvim',

    'max397574/better-escape.nvim',
    'windwp/nvim-autopairs',
    'windwp/nvim-ts-autotag',
    'nvim-lualine/lualine.nvim',
    'numToStr/Comment.nvim',
    'terrortylor/nvim-comment',
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-tree/nvim-web-devicons',
    'nvim-tree/nvim-tree.lua',
    'akinsho/toggleterm.nvim',
    'kylechui/nvim-surround',
    'numToStr/Navigator.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'norcalli/nvim-colorizer.lua',
    { 'ggandor/leap.nvim', dependencies = 'tpope/vim-repeat' },
    'ggandor/flit.nvim',
    {
        'utilyre/barbecue.nvim',
        version = '*',
        dependencies = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons',
        },
    },
    'luukvbaal/statuscol.nvim',
    { 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },
    { 'stevearc/oil.nvim', dependencies = 'nvim-tree/nvim-web-devicons' },
    'mbbill/undotree',
    'chentoast/marks.nvim',
    'folke/todo-comments.nvim',
    'nvim-pack/nvim-spectre',

    'navarasu/onedark.nvim',
    'folke/tokyonight.nvim',
    { 'catppuccin/nvim', name = 'catppuccin' },

    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',

    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',

    'williamboman/mason.nvim',

    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'nvimtools/none-ls.nvim',
    'kevinhwang91/nvim-bqf',
    { 'folke/trouble.nvim', dependencies = 'nvim-tree/nvim-web-devicons' },
    'github/copilot.vim',

    'nvim-telescope/telescope.nvim',
    'nanozuki/tabby.nvim',
    'LukasPietzschmann/telescope-tabs',
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    },
    'nvim-treesitter/nvim-treesitter-context',

    'hiphish/rainbow-delimiters.nvim',

    'lewis6991/gitsigns.nvim',
    'tpope/vim-fugitive',
    { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
    'rest-nvim/rest.nvim',

    'mfussenegger/nvim-dap',
    'theHamsta/nvim-dap-virtual-text',
    'rcarriga/nvim-dap-ui',

    {
        'nvim-neorg/neorg',
        build = ':Neorg sync-parsers',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-neorg/neorg-telescope',
        },
    },
    'dhruvasagar/vim-table-mode',
})
