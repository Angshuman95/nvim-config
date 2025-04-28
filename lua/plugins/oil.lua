return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'Oil',
    config = function()
        require('oil').setup({
            columns = {
                'icon',
                'permissions',
                'size',
                'mtime',
            },
            default_file_explorer = false,
            delete_to_trash = false,
            keymaps = {
                ['g?'] = 'actions.show_help',
                ['<CR>'] = 'actions.select',
                ['<C-v>'] = 'actions.select_vsplit',
                ['<C-x>'] = 'actions.select_split',
                ['<C-t>'] = 'actions.select_tab',
                ['<C-p>'] = 'actions.preview',
                ['<C-c>'] = 'actions.close',
                ['<C-r>'] = 'actions.refresh',
                ['-'] = 'actions.parent',
                ['_'] = 'actions.open_cwd',
                ['`'] = 'actions.cd',
                ['~'] = 'actions.tcd',
                ['g.'] = 'actions.toggle_hidden',
            },
            use_default_keymaps = false,
            float = {
                max_width = 0.8,
                max_height = 0.8,
            },
        })
    end,
    keys = { { '\\', ':Oil<CR>', noremap = true, silent = true } },
}
