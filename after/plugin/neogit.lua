local status_ok, neogit = pcall(require, 'neogit')
if not status_ok then
    return
end

neogit.setup {
    kind = 'split',
    integrations = {
        diffview = true
    }
}
