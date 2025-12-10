_G.format_on_save_enabled = false

local toggle_format_on_save = function()
    _G.format_on_save_enabled = not _G.format_on_save_enabled
    local status = _G.format_on_save_enabled and 'enabled' or 'disabled'
    vim.notify('Format on save ' .. status, vim.log.levels.INFO)
end

return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local conform = require('conform')
        conform.setup({
            formatters_by_ft = {

                -- C/C++
                c = { 'clang_format' },
                cpp = { 'clang_format' },

                -- C#
                cs = { 'csharpier' },

                -- Java
                java = { 'google-java-format' },

                -- JavaScript/TypeScript
                javascript = { 'prettier' },
                javascriptreact = { 'prettier' },
                typescript = { 'prettier' },
                typescriptreact = { 'prettier' },
                vue = { 'prettier' },

                -- Web
                css = { 'prettier' },
                scss = { 'prettier' },
                less = { 'prettier' },
                html = { 'prettier' },

                -- Data formats
                json = { 'prettier' },
                jsonc = { 'prettier' },
                yaml = { 'prettier' },

                -- Markdown
                markdown = { 'prettier' },
                ['markdown.mdx'] = { 'prettier' },

                -- Lua
                lua = { 'stylua' },

                -- Python
                python = { 'isort', 'black' },
            },

            formatters = {
                prettier = {
                    command = vim.fn.has('win32') == 1 and vim.fn.stdpath(
                        'data'
                    ) .. '/mason/bin/prettier.cmd' or 'prettier',
                    args = {
                        '--stdin-filepath',
                        '$FILENAME',
                        '--single-quote',
                        '--jsx-single-quote',
                    },
                },
                ['google-java-format'] = {
                    args = { '--aosp', '-' },
                },
                black = {
                    args = { '--fast', '--quiet', '-' },
                },
            },

            format_on_save = function(_)
                if not _G.format_on_save_enabled then
                    return
                end

                return {
                    timeout_ms = 2000,
                    lsp_fallback = true,
                }
            end,
        })

        vim.keymap.set(
            'n',
            '<leader>lt',
            toggle_format_on_save,
            { silent = true }
        )

        vim.keymap.set({ 'n', 'v' }, '<leader>lf', function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 2000,
            })
        end, { desc = 'Format file or range', silent = true })
    end,
}
