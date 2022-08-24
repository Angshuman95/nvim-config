vim.g.tmux_navigator_save_on_switch = 2

vim.g.tmux_navigator_no_mappings = 1

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Normal Mode
keymap('n', '<C-h>', ':TmuxNavigateLeft<cr>', opts)
keymap('n', '<C-j>', ':TmuxNavigateDown<cr>', opts)
keymap('n', '<C-k>', ':TmuxNavigateUp<cr>', opts)
keymap('n', '<C-l>', ':TmuxNavigateRight<cr>', opts)
-- keymap('n', '<C-\\>', ':TmuxNavigatePrevious<cr>', opts) -- C-\ for terminal
