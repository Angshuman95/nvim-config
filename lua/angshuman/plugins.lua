local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
    is_bootstrap = true;
    fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    print('Installing packer. Close and open Neovim')
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'rounded' })
        end,
    },
})

return packer.startup(function(use)
    use('wbthomason/packer.nvim')
    use('nvim-lua/plenary.nvim')

    use('windwp/nvim-autopairs')
    use('windwp/nvim-ts-autotag')
    use('nvim-lualine/lualine.nvim')
    use('numToStr/Comment.nvim')
    use('JoosepAlviste/nvim-ts-context-commentstring')
    use('kyazdani42/nvim-web-devicons')
    use('kyazdani42/nvim-tree.lua')
    use('akinsho/toggleterm.nvim')
    use('kylechui/nvim-surround')
    use('christoomey/vim-tmux-navigator')
    use('lukas-reineke/indent-blankline.nvim')
    use('norcalli/nvim-colorizer.lua')
    use('ggandor/leap.nvim')

    use('navarasu/onedark.nvim')

    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('saadparwaiz1/cmp_luasnip')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-nvim-lua')

    use('L3MON4D3/LuaSnip')
    use('rafamadriz/friendly-snippets')

    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')
    use('neovim/nvim-lspconfig')
    use('jose-elias-alvarez/null-ls.nvim')
    use('kevinhwang91/nvim-bqf')

    use('nvim-telescope/telescope.nvim')
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }
    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    use('p00f/nvim-ts-rainbow')

    use('lewis6991/gitsigns.nvim')
    use('tpope/vim-fugitive')

    use('mfussenegger/nvim-dap')
    use('theHamsta/nvim-dap-virtual-text')
    use('rcarriga/nvim-dap-ui')

    -- At the end
    if is_bootstrap then
        require('packer').sync()
    end
end)
