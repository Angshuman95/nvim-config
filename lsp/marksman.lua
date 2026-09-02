local vault = require('angshuman.shared').vault

return {
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)

        -- Block inside the Obsidian vault: obsidian.nvim owns it.
        if vault.contains(fname) then
            return
        end

        -- Elsewhere: replicate marksman's default root detection
        -- (root_markers = { '.marksman.toml', '.git' }), falling back to
        -- the file's own directory so single markdown files still work.
        local found = vim.fs.find(
            { '.marksman.toml', '.git' },
            { path = fname, upward = true }
        )[1]
        on_dir(found and vim.fs.dirname(found) or vim.fs.dirname(fname))
    end,
}
