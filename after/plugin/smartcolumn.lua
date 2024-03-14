local status_ok, smartcolumn = pcall(require, 'smartcolumn')
if not status_ok then
    return
end

smartcolumn.setup({
    colorcolumn = { '80', '120' },
})
