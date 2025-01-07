return {
    'mhartington/formatter.nvim',
    event = { 'BufWritePre' },
    keys = {
        {
            '<leader>lf',
            ':Format<CR>',
            desc = 'Format',
            noremap = true,
            silent = true,
        },
    },
    config = function()
        require('formatter').setup({
            logging = true,
            log_level = vim.log.levels.WARN,
            filetype = {
                c = {
                    require('formatter.filetypes.c').clangformat,
                },
                cpp = {
                    require('formatter.filetypes.cpp').clangformat,
                },

                cs = {
                    require('formatter.filetypes.cs').csharpier,
                },

                python = {
                    require('formatter.filetypes.python').isort,
                    require('formatter.filetypes.python').black,
                },

                lua = {
                    require('formatter.filetypes.lua').stylua,
                },

                -- Use prettier with custom args for everything else
                ['*'] = {
                    function()
                        local prettier_filetypes = {
                            'javascript',
                            'typescript',
                            'javascriptreact',
                            'typescriptreact',
                            'css',
                            'scss',
                            'html',
                            'json',
                            'yaml',
                            'markdown',
                            'graphql',
                            'vue',
                            'svelte',
                        }
                        local filetype = vim.bo.filetype
                        if
                            not vim.tbl_contains(prettier_filetypes, filetype)
                        then
                            return nil
                        end
                        return {
                            exe = 'prettier',
                            args = {
                                '--stdin-filepath',
                                vim.api.nvim_buf_get_name(0),
                                '--single-quote',
                                '--jsx-single-quote',
                            },
                            stdin = true,
                        }
                    end,
                },
            },
        })

        -- Format on save
        vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
            callback = function()
                -- Don't autoformat files larger than 100kb
                if vim.fn.getfsize(vim.fn.expand('%')) < 100000 then
                    vim.cmd('FormatWrite')
                end
            end,
        })
    end,
}
