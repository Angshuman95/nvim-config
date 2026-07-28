_G.virtual_text_enabled = false

local toggle_virtual_text = function()
    _G.virtual_text_enabled = not _G.virtual_text_enabled
    vim.diagnostic.config({
        virtual_text = _G.virtual_text_enabled,
    })
    local status = _G.virtual_text_enabled and 'enabled' or 'disabled'
    vim.notify('Virtual text ' .. status, vim.log.levels.INFO)
end

return {
    {
        'mason-org/mason.nvim',
        config = function()
            require('mason').setup({
                registries = {
                    'github:mason-org/mason-registry',
                    'github:Crashdummyy/mason-registry',
                },
            })
        end,
        cmd = 'Mason',
    },
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'saghen/blink.cmp' },
            { 'mason-org/mason-lspconfig.nvim' },
            { 'b0o/SchemaStore.nvim' },
        },
        config = function()
            vim.diagnostic.config({
                virtual_text = _G.virtual_text_enabled,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local map = vim.keymap.set
                    local opts = { buffer = event.buf, silent = true }

                    -- Normal mode mappings
                    map('n', 'gD', vim.lsp.buf.declaration, opts)
                    map('n', 'gd', vim.lsp.buf.definition, opts)
                    map('n', 'K', vim.lsp.buf.hover, opts)
                    map('n', '<leader>k', vim.diagnostic.open_float, opts)
                    map('n', 'gri', vim.lsp.buf.implementation, opts)
                    map('n', 'gk', vim.lsp.buf.signature_help, opts)
                    map('n', 'grn', vim.lsp.buf.rename, opts)
                    map('n', 'grr', vim.lsp.buf.references, opts)
                    map('n', 'gra', vim.lsp.buf.code_action, opts)
                    map('n', '[d', function()
                        vim.diagnostic.jump({ count = -1, float = true })
                    end, opts)
                    map('n', ']d', function()
                        vim.diagnostic.jump({ count = 1, float = true })
                    end, opts)
                    map('n', '<leader>q', vim.diagnostic.setloclist, opts)
                    map('n', '<leader>lv', toggle_virtual_text, opts)
                end,
            })

            vim.api.nvim_create_user_command(
                'ToggleVirtualText',
                toggle_virtual_text,
                { desc = 'Toggle LSP virtual text diagnostics' }
            )

            -- Apply blink.cmp completion capabilities to every LSP server.
            vim.lsp.config('*', {
                capabilities = require('blink.cmp').get_lsp_capabilities(),
            })

            require('mason-lspconfig').setup({
                ensure_installed = {
                    'angularls',
                    'clangd',
                    'cssls',
                    'emmet_ls',
                    'eslint',
                    'gopls',
                    'jdtls',
                    'jsonls',
                    'html',
                    'lua_ls',
                    'powershell_es',
                    'basedpyright',
                    'rust_analyzer',
                    'ts_ls',
                },
                -- Exclude jdtls: nvim-jdtls handles its setup and enabling it
                -- here would attach a second, conflicting client.
                automatic_enable = { exclude = { 'jdtls' } },
            })
        end,
    },
    {
        'kevinhwang91/nvim-bqf',
        config = true,
    },
    {
        'rmagatti/goto-preview',
        dependencies = { 'rmagatti/logger.nvim' },
        event = 'LspAttach',
        opts = {
            default_mappings = true,
            references = {
                provider = 'default',
            },
        },
    },
}
