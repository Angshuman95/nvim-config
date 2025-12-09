local function add_custom_lsp_settings(server_name, opts)
    local status_ok, custom_settings =
        pcall(require, 'angshuman.lsp-custom-settings.' .. server_name)
    if not status_ok then
        return {}
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
                    local opts =
                        { buffer = event.buf, silent = true, noremap = true }
                    local mappings = {
                        n = {
                            {
                                'gD',
                                '<cmd>lua vim.lsp.buf.declaration()<CR>',
                            },
                            {
                                'gd',
                                '<cmd>lua vim.lsp.buf.definition()<CR>',
                            },
                            {
                                'K',
                                '<cmd>lua vim.lsp.buf.hover()<CR>',
                            },
                            {
                                '<leader>k',
                                '<cmd>lua vim.diagnostic.open_float()<CR>',
                            },
                            {
                                'gri',
                                '<cmd>lua vim.lsp.buf.implementation()<CR>',
                            },
                            {
                                'gk',
                                '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                            },
                            {
                                'grn',
                                '<cmd>lua vim.lsp.buf.rename()<CR>',
                            },
                            {
                                'grr',
                                '<cmd>lua vim.lsp.buf.references()<CR>',
                            },
                            {
                                'gra',
                                '<cmd>lua vim.lsp.buf.code_action()<CR>',
                            },
                            {
                                '[d',
                                '<cmd>lua vim.diagnostic.goto_prev()<CR>',
                            },
                            {
                                ']d',
                                '<cmd>lua vim.diagnostic.goto_next()<CR>',
                            },
                            {
                                '<leader>q',
                                '<cmd>lua vim.diagnostic.setloclist()<CR>',
                            },
                            {
                                '<leader>lf',
                                '<cmd>lua vim.lsp.buf.format()<CR>',
                            },
                            {
                                '<leader>lt',
                                toggle_format_on_save,
                            },
                            {
                                '<leader>lv',
                                toggle_virtual_text,
                            },
                        },
                        v = {
                            {
                                '<leader>lf',
                                '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
                            },
                        },
                    }

                    for mode, binds in pairs(mappings) do
                        for _, m in ipairs(binds) do
                            map(mode, m[1], m[2], opts)
                        end
                    end
                end,
            })

            vim.api.nvim_create_user_command(
                'ToggleVirtualText',
                toggle_virtual_text,
                {
                    desc = 'Toggle LSP virtual text diagnostics',
                }
            )

            vim.api.nvim_create_user_command(
                'ToggleAutoFormatOnSave',
                toggle_format_on_save,
                {
                    desc = 'Toggle auto format on save',
                }
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
                        local opts = add_custom_lsp_settings('clangd', {})
                        require('lspconfig').clangd.setup(opts)
                    end,
                    jsonls = function()
                        local opts = add_custom_lsp_settings('jsonls', {})
                        require('lspconfig').jsonls.setup(opts)
                    end,
                    lua_ls = function()
                        local opts = add_custom_lsp_settings('lua_ls', {})
                        require('lspconfig').lua_ls.setup(opts)
                    end,
                    rust_analyzer = function()
                        local opts =
                            add_custom_lsp_settings('rust_analyzer', {})
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
    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        },
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local null_ls = require('null-ls')
            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics
            local command

            if vim.fn.has('win32') == 1 then
                command = vim.loop.os_homedir()
                    .. '/AppData/Roaming/npm/prettier.cmd'
            else
                command = 'prettier'
            end

            local prettierOpts = {
                command = command,
                extra_args = { '--single-quote', '--jsx-single-quote' },
                filetypes = {
                    'javascript',
                    'javascriptreact',
                    'typescript',
                    'typescriptreact',
                    'vue',
                    'css',
                    'scss',
                    'less',
                    'html',
                    'json',
                    'jsonc',
                    'yaml',
                    'markdown',
                    'markdown.mdx',
                },
            }

            -- Create an augroup for formatting
            local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

            null_ls.setup({
                debug = false,
                sources = {
                    -- formatting sources
                    formatting.clang_format.with({
                        filetypes = {
                            'c',
                            'cpp',
                        },
                    }),
                    formatting.csharpier,
                    formatting.google_java_format.with({
                        extra_args = { '--aosp' },
                    }),
                    formatting.prettier.with(prettierOpts),
                    formatting.stylua,
                    formatting.isort,
                    formatting.black.with({ extra_args = { '--fast' } }),

                    -- Diagnostics sources
                    diagnostics.cppcheck,
                    require("none-ls.diagnostics.ruff"),
                    diagnostics.markdownlint,
                },
                -- Configure format on save
                on_attach = function(client, bufnr)
                    if client.supports_method('textDocument/formatting') then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr,
                        })
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                if _G.format_on_save_enabled then
                                    vim.lsp.buf.format({ bufnr = bufnr })
                                end
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
