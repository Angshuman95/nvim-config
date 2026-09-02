local M = {}

-- Obsidian vault location.
--   Consumed by:
--     * lua/plugins/obsidian.lua
--     * lsp/marksman.lua
M.vault = {
    path = vim.fs.normalize(
        '~/Developer/10-19-learning/10-notes/personal-notes'
    ),
    name = 'arch-notes',
    marker = 'personal-notes',
}

--- True when `fname` is the vault root or any file/dir inside it.
---@param fname string
---@return boolean
function M.vault.contains(fname)
    local path = vim.fs.normalize(fname)
    return path == M.vault.path
        or path:sub(1, #M.vault.path + 1) == M.vault.path .. '/'
end

--   M.state.format_on_save  toggled in lua/plugins/conform.lua, also read by
--                           the Go organize-imports autocmd in
--                           lua/plugins/lsp.lua.
M.state = {
    format_on_save = false,
}

return M
