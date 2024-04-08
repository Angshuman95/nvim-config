local opts = { noremap = true, silent = true }
local map = vim.keymap.set

return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = 'Telescope',
        keys = { '<leader>f' },
        config = function()
            require('telescope').setup({
                defaults = {
                    prompt_prefix = ' ',
                    selection_caret = ' ',
                    winblend = 0,
                    path_display = { 'truncate' },
                    layout_config = { prompt_position = 'top' },
                    sorting_strategy = 'ascending',
                },
            })

            map('n', '<leader>f', ':Telescope find_files<CR>', opts)
            map('n', '<leader>b', ':Telescope buffers<CR>', opts)
            map(
                'n',
                '<leader>sd',
                ':lua require"telescope.builtin".diagnostics{ bufnr=0 }<CR>',
                opts
            )
            map('n', '<leader>sD', ':Telescope diagnostics<CR>', opts)
            map(
                'n',
                '<leader>sf',
                ':Telescope current_buffer_fuzzy_find<CR>',
                opts
            )
            map('n', '<leader>sr', ':Telescope oldfiles<CR>', opts)
            map('n', '<leader>st', ':Telescope live_grep<CR>', opts)
            map('n', '<leader>ss', ':Telescope lsp_document_symbols<CR>', opts)
            map('n', '<leader>sm', ':Telescope marks<CR>', opts)
            map(
                'n',
                '<leader>sS',
                ':Telescope lsp_dynamic_workspace_symbols<CR>',
                opts
            )
        end,
    },
    {
        'LukasPietzschmann/telescope-tabs',
        config = function()
            require('telescope').load_extension('telescope-tabs')
            require('telescope-tabs').setup()
            map(
                'n',
                '<leader>lt',
                ':lua require("telescope-tabs").list_tabs()<CR>',
                opts
            )
        end,
        dependencies = { 'nvim-telescope/telescope.nvim' },
        keys = { '<leader>lt' },
    },
}
