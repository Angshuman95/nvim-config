local function add_custom_lsp_settings(server_name, opts)
    local status_ok, custom_settings =
        pcall(require, 'angshuman.lsp-custom-settings.' .. server_name)
    if not status_ok then
        return {}
    end
    opts = vim.tbl_deep_extend('force', opts, custom_settings)
    return opts
end

return {
    {
        'williamboman/mason.nvim',
        config = true,
        cmd = 'Mason',
    },
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local map = vim.keymap.set
                    local opts =
                    { buffer = event.buf, silent = true, noremap = true }
                    map(
                        'n',
                        'gD',
                        '<cmd>lua vim.lsp.buf.declaration()<CR>',
                        opts
                    )
                    map(
                        'n',
                        'gd',
                        '<cmd>lua vim.lsp.buf.definition()<CR>',
                        opts
                    )
                    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                    map(
                        'n',
                        '<leader>k',
                        '<cmd>lua vim.diagnostic.open_float()<CR>',
                        opts
                    )
                    map(
                        'n',
                        'gi',
                        '<cmd>lua vim.lsp.buf.implementation()<CR>',
                        opts
                    )
                    map(
                        'n',
                        'gk',
                        '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                        opts
                    )
                    map(
                        'n',
                        '<leader>rn',
                        '<cmd>lua vim.lsp.buf.rename()<CR>',
                        opts
                    )
                    map(
                        'n',
                        'gr',
                        '<cmd>lua vim.lsp.buf.references()<CR>',
                        opts
                    )
                    map(
                        'n',
                        '<leader>ca',
                        '<cmd>lua vim.lsp.buf.code_action()<CR>',
                        opts
                    )
                    map(
                        'n',
                        '[d',
                        '<cmd>lua vim.diagnostic.goto_prev()<CR>',
                        opts
                    )
                    map(
                        'n',
                        ']d',
                        '<cmd>lua vim.diagnostic.goto_next()<CR>',
                        opts
                    )
                    map(
                        'n',
                        '<leader>q',
                        '<cmd>lua vim.diagnostic.setloclist()<CR>',
                        opts
                    )
                    map(
                        'v',
                        '<leader>lf',
                        ':lua vim.lsp.buf.range_formatting()<CR>',
                        opts
                    )
                    map(
                        'n',
                        '<leader>lf',
                        ':lua vim.lsp.buf.format()<CR>',
                        opts
                    )
                end,
            })
            local lsp_capabilities =
                require('cmp_nvim_lsp').default_capabilities()

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
                    'jdtls',
                    'jsonls',
                    'html',
                    'lua_ls',
                    'omnisharp',
                    'powershell_es',
                    'pyright',
                    'rust_analyzer',
                    'ts_ls',
                },
                handlers = {
                    default_setup,
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

            vim.lsp.handlers['textDocument/publishDiagnostics'] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                    virtual_text = false,
                })
        end,
    },
    {
        'kevinhwang91/nvim-bqf',
        config = true,
    },
    {
        'dgagn/diagflow.nvim',
        event = 'LspAttach',
        config = true,
    },
    {
        'nvimtools/none-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local null_ls = require('null-ls')
            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics

            local prettierOpts = {
                command = vim.fn.has('win32')
                    and vim.loop.os_homedir() .. '/AppData/Roaming/npm/prettier.cmd'
                    or 'prettier',
                extra_args = { '--single-quote', '--jsx-single-quote' },
            }

            -- Create an augroup for formatting
            local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

            null_ls.setup({
                debug = false,
                sources = {
                    formatting.clang_format.with({
                        filetypes = {
                            'c',
                            'cpp',
                        },
                    }),
                    formatting.csharpier,
                    formatting.prettier.with(prettierOpts),
                    formatting.stylua,
                    formatting.isort,
                    formatting.black.with({ extra_args = { '--fast' } }),

                    -- Diagnostics sources
                    diagnostics.cppcheck,
                    diagnostics.pylint,
                    diagnostics.write_good.with({
                        filetypes = { 'markdown', 'text' },
                    }),
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
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
