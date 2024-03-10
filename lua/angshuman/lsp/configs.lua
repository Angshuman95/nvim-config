local status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status_ok then
    return
end

local mason
status_ok, mason = pcall(require, 'mason')
if not status_ok then
    return
end

local lspconfig = require('lspconfig')

local servers = {
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
    'tsserver',
}

mason.setup()

mason_lspconfig.setup({
    ensure_installed = servers,
})

for _, server in pairs(servers) do
    local opts = {
        on_attach = require('angshuman.lsp.handlers').on_attach,
        capabilities = require('angshuman.lsp.handlers').capabilities,
    }

    local has_custom_opts, server_custom_opts =
        pcall(require, 'angshuman.lsp.settings.' .. server)
    if has_custom_opts then
        opts = vim.tbl_deep_extend('force', opts, server_custom_opts)
    end

    lspconfig[server].setup(opts)
end
