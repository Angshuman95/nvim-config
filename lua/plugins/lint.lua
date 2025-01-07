return {
    'mfussenegger/nvim-lint',
    event = { 'BufWritePre' },
    keys = {
        {
            '<leader>ll',
            function()
                require('lint').try_lint()
            end,
            desc = 'Trigger linting',
            noremap = true,
            silent = true,
        },
    },
    config = function()
        local lint = require('lint')

        lint.linters_by_ft = {
            javascript = { 'eslint_d' },
            typescript = { 'eslint_d' },
            javascriptreact = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },
            markdown = { 'markdownlint' },
            python = { 'pylint' },
            lua = { 'luacheck' },
            cpp = { 'cppcheck' },
            c = { 'cppcheck' },
        }

        -- Auto-lint on save
        vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
            callback = function()
                -- Don't auto-lint files larger than 100kb
                if vim.fn.getfsize(vim.fn.expand('%')) < 100000 then
                    require('lint').try_lint()
                end
            end,
        })
    end,
}
