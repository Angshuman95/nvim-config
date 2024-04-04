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

local lsp_handlers = {}

lsp_handlers.setup = function()
    local signs = {
        { name = 'DiagnosticSignError', text = '' },
        { name = 'DiagnosticSignWarn', text = '' },
        { name = 'DiagnosticSignHint', text = '' },
        { name = 'DiagnosticSignInfo', text = '' },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(
            sign.name,
            { texthl = sign.name, text = sign.text, numhl = '' }
        )
    end

    local config = {
        -- disable virtual text
        virtual_text = false,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = 'minimal',
            border = 'rounded',
            source = 'always',
            header = '',
            prefix = '',
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers['textDocument/hover'] =
        vim.lsp.with(vim.lsp.handlers.hover, {
            border = 'rounded',
            width = 60,
        })

    vim.lsp.handlers['textDocument/signatureHelp'] =
        vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = 'rounded',
            width = 60,
        })
end

local function lsp_highlight_document(client)
    local status_ok, illuminate = pcall(require, 'illuminate')
    if not status_ok then
        return
    end
    illuminate.on_attach(client)
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        'gD',
        '<cmd>lua vim.lsp.buf.declaration()<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        'gd',
        '<cmd>lua vim.lsp.buf.definition()<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        'K',
        '<cmd>lua vim.lsp.buf.hover()<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<leader>k',
        '<cmd>lua vim.diagnostic.open_float()<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        'gi',
        '<cmd>lua vim.lsp.buf.implementation()<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        'gk',
        '<cmd>lua vim.lsp.buf.signature_help()<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<leader>rn',
        '<cmd>lua vim.lsp.buf.rename()<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        'gr',
        '<cmd>lua vim.lsp.buf.references()<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<leader>ca',
        '<cmd>lua vim.lsp.buf.code_action()<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '[d',
        '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        'gl',
        '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        ']d',
        '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<leader>q',
        '<cmd>lua vim.diagnostic.setloclist()<CR>',
        opts
    )
    vim.keymap.set('n', '<leader>lf', ':lua vim.lsp.buf.format()<CR>', opts)
    vim.keymap.set('v', '<leader>lf', ':lua vim.lsp.buf.range_formatting()<CR>', opts)
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format{async=true}' ]])
end

local function contains(list, x)
    for _, v in pairs(list) do
        if v == x then
            return true
        end
    end
    return false
end

local tbl_doc_no_format = { 'clangd', 'html', 'tsserver' }

lsp_handlers.on_attach = function(client, bufnr)
    if contains(tbl_doc_no_format, client.name) then
        client.server_capabilities.documentFormattingProvider = false
    end
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if status_ok then
    lsp_handlers.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

return {
    {
        'williamboman/mason.nvim',
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = servers,
            })
        end,
    },
    {
        'kevinhwang91/nvim-bqf'
    },
    {

        'dgagn/diagflow.nvim',
        event = 'LspAttach',
        config = true
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            for _, server in pairs(servers) do
                local opts = {
                    on_attach = lsp_handlers.on_attach,
                    capabilities = lsp_handlers.capabilities,
                }

                local has_custom_opts, server_custom_opts =
                    pcall(require, 'angshuman.lsp.settings.' .. server)
                if has_custom_opts then
                    if server == 'lua_ls' then
                        print(vim.inspect(opts))
                        print(vim.inspect(server_custom_opts))
                    end
                    opts =
                        vim.tbl_deep_extend('force', opts, server_custom_opts)

                    if server == 'lua_ls' then
                        print(vim.inspect(opts))
                    end
                end

                require('lspconfig')[server].setup(opts)
            end
            lsp_handlers.setup()
        end,
    },
}
