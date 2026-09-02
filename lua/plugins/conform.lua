local state = require('angshuman.shared').state

local toggle_format_on_save = function()
    state.format_on_save = not state.format_on_save
    local status = state.format_on_save and 'enabled' or 'disabled'
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

                -- Go
                go = { 'golines' },
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
                golines = {
                    args = { '--max-len=100', '--base-formatter=gofumpt' },
                },
            },

            format_after_save = function(_)
                if not state.format_on_save then
                    return
                end

                return {
                    lsp_format = 'fallback',
                }
            end,
        })

        vim.keymap.set(
            'n',
            '<leader>lt',
            toggle_format_on_save,
            { silent = true }
        )

        vim.api.nvim_create_user_command(
            'ToggleAutoFormatOnSave',
            toggle_format_on_save,
            { desc = 'Toggle auto format on save' }
        )

        vim.keymap.set({ 'n', 'v' }, '<leader>lf', function()
            conform.format({
                lsp_format = 'fallback',
                async = true,
            })
        end, { desc = 'Format file or range', silent = true })
    end,
}
