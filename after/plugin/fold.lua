local status_ok, ufo = pcall(require, 'ufo')
if not status_ok then
    return
end

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)

-- Option 1: coc.nvim as LSP client
--[[ use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'} ]]
--[[ require('ufo').setup() ]]
--

-- Option 2: nvim lsp as LSP client
-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if lspconfig_ok then
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    local language_servers = lspconfig.util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
    for _, ls in ipairs(language_servers) do
        lspconfig[ls].setup({
            capabilities = capabilities,
            -- you can add other fields for setting up lsp server in this table
        })
    end
    ufo.setup()
end

-- Option 3: treesitter as a main provider instead
-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
local treesitter = false

if not lspconfig_ok then
    ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
            return { 'treesitter', 'indent' }
        end,
    })
    treesitter = true
end

-- Option 4: disable all providers for all buffers
-- Not recommend, AFAIK, the ufo's providers are the best performance in Neovim
if not lspconfig_ok and not treesitter then
    ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
            return ''
        end,
    })
end
