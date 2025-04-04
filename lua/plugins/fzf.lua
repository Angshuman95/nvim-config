return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'FzfLua',
    keys = {
        {
            '<leader>f',
            ':FzfLua files<CR>',
            silent = true,
            noremap = true,
        },
        {
            '<leader>b',
            ':FzfLua buffers<CR>',
            silent = true,
            noremap = true,
        },
        {
            '<leader>tb',
            ':FzfLua tabs<CR>',
            silent = true,
            noremap = true,
        },
        {
            '<leader>st',
            ':FzfLua live_grep<CR>',
            silent = true,
            noremap = true,
        },
        {
            '<leader>sd',
            ':FzfLua lsp_document_diagnostics<CR>',
            silent = true,
            noremap = true,
        },
        {
            '<leader>sD',
            ':FzfLua lsp_workspace_diagnostics<CR>',
            silent = true,
            noremap = true,
        },
        {
            '<leader>sf',
            ':FzfLua grep_curbuf<CR>',
            silent = true,
            noremap = true,
        },
        {
            '<leader>sr',
            ':FzfLua oldfiles<CR>',
            silent = true,
            noremap = true,
        },
        {
            '<leader>ss',
            ':FzfLua lsp_document_symbols<CR>',
            silent = true,
            noremap = true,
        },
        {
            '<leader>sm',
            ':FzfLua marks<CR>',
            silent = true,
            noremap = true,
        },
        {
            '<leader>sS',
            ':FzfLua lsp_workspace_symbols<CR>',
            silent = true,
            noremap = true,
        },
        {
            '<leader>sD',
            ':FzfLua lsp_workspace_diagnostics<CR>',
            silent = true,
            noremap = true,
        },
        {
            '<leader>sj',
            ':FzfLua jumps<CR>',
            silent = true,
            noremap = true,
        },
        {
            '<leader>sq',
            ':FzfLua quickfix<CR>',
            silent = true,
            noremap = true,
        },
        {
            '<leader>ca',
            ':FzfLua lsp_code_actions<CR>',
            silent = true,
            noremap = true,
        },
    },
    config = function()
        require('fzf-lua').setup({
            keymap = {
                fzf = {
                    ['ctrl-q'] = 'select-all+accept',
                },
            },
        })
    end,
}
