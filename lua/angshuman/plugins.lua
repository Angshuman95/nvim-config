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
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
    return
end

return lazy.setup({
    'nvim-lua/plenary.nvim',

    'windwp/nvim-autopairs',
    'windwp/nvim-ts-autotag',
    'nvim-lualine/lualine.nvim',
    'numToStr/Comment.nvim',
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-tree/nvim-web-devicons',
    'nvim-tree/nvim-tree.lua',
    'akinsho/toggleterm.nvim',
    'kylechui/nvim-surround',
    'numToStr/Navigator.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'norcalli/nvim-colorizer.lua',
    'ggandor/leap.nvim',
    {
        'utilyre/barbecue.nvim',
        version = '*',
        dependencies = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons',
        },
    },
    'luukvbaal/statuscol.nvim',

    --[[ 'navarasu/onedark.nvim', ]]
    'folke/tokyonight.nvim',

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
    'jose-elias-alvarez/null-ls.nvim',
    'kevinhwang91/nvim-bqf',

    'nvim-telescope/telescope.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = 'nvim-treesitter/nvim-treesitter-textobjects'
    },

    'p00f/nvim-ts-rainbow',

    'lewis6991/gitsigns.nvim',
    'tpope/vim-fugitive',
    { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },

    'mfussenegger/nvim-dap',
    'theHamsta/nvim-dap-virtual-text',
    'rcarriga/nvim-dap-ui',

    {
        'nvim-neorg/neorg',
        build = ":Neorg sync-parsers",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    }
})
