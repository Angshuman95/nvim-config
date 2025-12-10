local function add_custom_lsp_settings(server_name, opts)
    local status_ok, custom_settings =
        pcall(require, 'angshuman.lsp-custom-settings.' .. server_name)
    if not status_ok then
        return opts
    end
    return vim.tbl_deep_extend('force', opts, custom_settings)
end

_G.format_on_save_enabled = false
_G.virtual_text_enabled = false

local toggle_format_on_save = function()
    _G.format_on_save_enabled = not _G.format_on_save_enabled
    local status = _G.format_on_save_enabled and 'enabled' or 'disabled'
    vim.notify('Format on save ' .. status, vim.log.levels.INFO)
end

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

            vim.api.nvim_create_user_command(
                'ToggleAutoFormatOnSave',
                toggle_format_on_save,
                { desc = 'Toggle auto format on save' }
            )

            local lsp_capabilities = require('blink.cmp').get_lsp_capabilities()

            local default_setup = function(server)
                require('lspconfig')[server].setup({
                    capabilities = lsp_capabilities,
                })
            end

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
                handlers = {
                    default_setup,
                    jdtls = function()
                        -- Do nothing, nvim-jdtls will handle the setup
                    end,
                    clangd = function()
                        local opts = add_custom_lsp_settings('clangd', {
                            capabilities = lsp_capabilities,
                        })
                        require('lspconfig').clangd.setup(opts)
                    end,
                    jsonls = function()
                        local opts = add_custom_lsp_settings('jsonls', {
                            capabilities = lsp_capabilities,
                        })
                        require('lspconfig').jsonls.setup(opts)
                    end,
                    lua_ls = function()
                        local opts = add_custom_lsp_settings('lua_ls', {
                            capabilities = lsp_capabilities,
                        })
                        require('lspconfig').lua_ls.setup(opts)
                    end,
                    rust_analyzer = function()
                        local opts = add_custom_lsp_settings('rust_analyzer', {
                            capabilities = lsp_capabilities,
                        })
                        require('lspconfig').rust_analyzer.setup(opts)
                    end,
                },
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
