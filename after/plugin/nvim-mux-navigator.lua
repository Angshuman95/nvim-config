local status_ok, Navigator = pcall(require, 'Navigator')
if not status_ok then
    return
end

Navigator.setup({
    -- Save modified buffer(s) when moving to mux
    -- nil - Don't save (default)
    -- 'current' - Only save the current modified buffer
    -- 'all' - Save all the buffers
    auto_save = 'all',

    -- Disable navigation when the current mux pane is zoomed in
    disable_on_zoom = false,

    -- Multiplexer to use
    -- 'auto' - Chooses mux based on priority (default)
    -- table - Custom mux to use
    mux = 'auto',
})

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-- Normal Mode
keymap({ 'n', 't' }, '<C-h>', ':NavigatorLeft<cr>', opts)
keymap({ 'n', 't' }, '<C-j>', ':NavigatorDown<cr>', opts)
keymap({ 'n', 't' }, '<C-k>', ':NavigatorUp<cr>', opts)
keymap({ 'n', 't' }, '<C-l>', ':NavigatorRight<cr>', opts)
