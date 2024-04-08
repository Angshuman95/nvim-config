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
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        config = true,
    },

    -- Autocompletion
    {
        'hrsh7th/cmp-buffer',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'hrsh7th/cmp-path',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'hrsh7th/cmp-nvim-lsp',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'hrsh7th/cmp-nvim-lua',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'saadparwaiz1/cmp_luasnip',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'L3MON4D3/LuaSnip',
        config = function()
            require('luasnip/loaders/from_vscode').lazy_load()
        end,
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'rafamadriz/friendly-snippets',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
        },
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                formatting = lsp_zero.cmp_format({ details = true }),
                mapping = {
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-b>'] = cmp.mapping(
                        cmp.mapping.scroll_docs(-1),
                        { 'i', 'c' }
                    ),
                    ['<C-f>'] = cmp.mapping(
                        cmp.mapping.scroll_docs(1),
                        { 'i', 'c' }
                    ),
                    ['<C-Space>'] = cmp.mapping(
                        cmp.mapping.complete(),
                        { 'i', 'c' }
                    ),
                    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ['<C-e>'] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    -- Accept currently selected item. If none selected, `select` first item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, {
                        'i',
                        's',
                    }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {
                        'i',
                        's',
                    }),
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'neorg' },
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
            })
        end,
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(_, bufnr)
                local map = vim.keymap.set
                local opts = { buffer = bufnr, silent = true, noremap = true }
                map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
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
                map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                map(
                    'n',
                    '<leader>ca',
                    '<cmd>lua vim.lsp.buf.code_action()<CR>',
                    opts
                )
                map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
                map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
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
                map('n', '<leader>lf', ':lua vim.lsp.buf.format()<CR>', opts)
            end)

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
                    'tsserver',
                },
                handlers = {
                    lsp_zero.default_setup,
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
        event = 'QuickFixCmdPost',
    },
    {

        'dgagn/diagflow.nvim',
        event = 'LspAttach',
        config = true,
    },
    {
        'nvimtools/none-ls.nvim',
        event = 'LspAttach',
        config = function()
            local null_ls = require('null-ls')
            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics
            null_ls.setup({
                debug = false,
                sources = {
                    formatting.clang_format.with({
                        filetypes = {
                            'c',
                            'cpp',
                            'cuda',
                            'proto',
                        },
                    }),
                    formatting.csharpier,
                    formatting.prettier.with({
                        extra_args = { '--single-quote', '--jsx-single-quote' },
                    }),
                    formatting.stylua,
                    formatting.isort,
                    formatting.black.with({ extra_args = { '--fast' } }),

                    diagnostics.cppcheck,
                    diagnostics.pylint,
                    diagnostics.write_good.with({
                        filetypes = { 'markdown', 'text' },
                    }),
                },
            })
        end,
    },
}
