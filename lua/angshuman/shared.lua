local M = {}

local ok, overrides = pcall(require, 'angshuman.local')
if not ok then
    overrides = {}
end

-- Obsidian vault location.
--   Consumed by:
--     * lua/plugins/obsidian.lua
--     * lsp/marksman.lua
local vault_ov = overrides.vault or {}
M.vault = {
    path = vim.fs.normalize(vault_ov.path),
    name = vault_ov.name,
    marker = vault_ov.marker,
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
