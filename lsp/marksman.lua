local vault = require('angshuman.shared').vault

return {
    root_dir = function(fname)
        -- Block inside the Obsidian vault
        if vault.contains(fname) then
            return nil
        end

        local found = vim.fs.find(
            { '.marksman.toml', '.git' },
            { path = fname, upward = true }
        )[1]
        if found then
            return vim.fs.dirname(found)
        end
        return vim.fs.dirname(fname)
    end,
}
