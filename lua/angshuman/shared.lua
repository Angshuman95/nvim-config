local M = {}

local ok, overrides = pcall(require, 'angshuman.local')
if not ok then
    overrides = {}
end

-- Obsidian vault locations.
--   Consumed by:
--     * lua/plugins/obsidian.lua
--     * lsp/marksman.lua
local vaults_ov = overrides.vaults or {}
M.vaults = {}
for _, v in ipairs(vaults_ov) do
    table.insert(M.vaults, {
        path = vim.fs.normalize(v.path),
        name = v.name,
        marker = v.marker,
    })
end

--- True when `fname` is the root of, or a file/dir inside, any vault.
---@param fname string
---@return boolean
function M.vault_contains(fname)
    local path = vim.fs.normalize(fname)
    for _, v in ipairs(M.vaults) do
        if path == v.path or path:sub(1, #v.path + 1) == v.path .. '/' then
            return true
        end
    end
    return false
end

--- True when `fname` (e.g. cwd) matches any vault marker.
---@param fname string
---@return boolean
function M.vault_marker_match(fname)
    for _, v in ipairs(M.vaults) do
        if v.marker and string.find(fname, v.marker, 1, true) then
            return true
        end
    end
    return false
end

--   M.state.format_on_save  toggled in lua/plugins/conform.lua, also read by
--                           the Go organize-imports autocmd in
--                           lua/plugins/lsp.lua.
M.state = {
    format_on_save = false,
}

return M
