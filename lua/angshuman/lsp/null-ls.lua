local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local function contains(list, x)
    for _, v in pairs(list) do
        if v == x then
            return true
        end
    end
    return false
end

local tbl_doc_no_format = { 'cs' }

null_ls.setup({
    debug = false,
    on_attach = function(client, _)
        if contains(tbl_doc_no_format, vim.bo.filetype) then
            client.server_capabilities.documentFormattingProvider = false
        end
    end,
    sources = {
        formatting.clang_format,
        formatting.astyle,
        --[[ formatting.prettierd, ]]
        formatting.prettier.with({ extra_args = { '--single-quote', '--jsx-single-quote' } }),
        formatting.black.with({ extra_args = { '--fast' } }),
        diagnostics.cpplint,
        diagnostics.eslint_d
        --[[ formatting.stylua, ]]
        --[[ diagnostics.flake8 ]]
    }
})
