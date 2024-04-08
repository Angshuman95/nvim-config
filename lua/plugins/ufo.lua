return {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local ufo = require('ufo')

        vim.o.foldcolumn = '0'
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
        vim.keymap.set('n', 'zR', ufo.openAllFolds)
        vim.keymap.set('n', 'zM', ufo.closeAllFolds)

        -- Use lsp by default
        local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
        if lspconfig_ok then
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }
            local language_servers = lspconfig.util.available_servers()
            for _, ls in ipairs(language_servers) do
                lspconfig[ls].setup({
                    capabilities = capabilities,
                })
            end
            ufo.setup()
            return
        end

        local treesitter = false

        -- Use treesitter else
        if not lspconfig_ok then
            ufo.setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { 'treesitter', 'indent' }
                end,
            })
            treesitter = true
        end

        if not lspconfig_ok and not treesitter then
            ufo.setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return ''
                end,
            })
        end
    end,
}