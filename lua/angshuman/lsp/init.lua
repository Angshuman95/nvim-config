local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
    return
end

require('angshuman.lsp.configs')
require('angshuman.lsp.handlers').setup()
require('angshuman.lsp.null-ls')

-- WorkAround for omnisharp
-- https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
-- https://github.com/OmniSharp/omnisharp-roslyn/issues/2483#issuecomment-1546721190

-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(ev)
--         local client = vim.lsp.get_client_by_id(ev.data.client_id)
--         local function toSnakeCase(str)
--             return string.gsub(str, '%s*[- ]%s*', '_')
--         end
--
--         if client.name == 'omnisharp' then
--             local tokenModifiers =
--                 client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
--             for i, v in ipairs(tokenModifiers) do
--                 tokenModifiers[i] = toSnakeCase(v)
--             end
--             local tokenTypes =
--                 client.server_capabilities.semanticTokensProvider.legend.tokenTypes
--             for i, v in ipairs(tokenTypes) do
--                 tokenTypes[i] = toSnakeCase(v)
--             end
--         end
--     end,
-- })
