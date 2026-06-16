return {
    'romus204/tree-sitter-manager.nvim',
    config = function()
        -- Initialize tree-sitter-manager for parser installation
        require('tree-sitter-manager').setup({
            auto_install = true,
        })

        -- Enable treesitter features per filetype
        vim.api.nvim_create_autocmd('FileType', {
            pattern = '*',
            callback = function()
                -- Syntax highlighting (provided natively by Neovim 0.12+)
                pcall(vim.treesitter.start)

                -- Indentation (nvim-treesitter module is archived; use Neovim native defaults or another plugin)
                -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

                -- Folds (provided by Neovim)
                -- Conflicts with ufo
                -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                -- vim.wo.foldmethod = 'expr'
            end,
        })

        -- Incremental selection keymaps (Neovim built-in)
        vim.keymap.set(
            'n',
            '<c-space>',
            'v<cmd>lua vim.treesitter.select_increment()<cr>'
        )
        vim.keymap.set(
            'v',
            '<c-space>',
            '<cmd>lua vim.treesitter.select_increment()<cr>'
        )
        vim.keymap.set(
            'v',
            '<c-backspace>',
            '<cmd>lua vim.treesitter.select_decrement()<cr>'
        )
    end,
}
