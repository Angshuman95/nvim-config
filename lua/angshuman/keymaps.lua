local opts = { noremap = true, silent = true }

local opt_noremap = { noremap = true }
local no_opt = {}

-- Shorten function name
local map = vim.keymap.set

--Remap space as leader key
map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal Mode
-- Better window navigation
-- Taken care by tmux
-- map('n', '<C-h>', '<C-w>h', opts)
-- map('n', '<C-j>', '<C-w>j', opts)
-- map('n', '<C-k>', '<C-w>k', opts)
-- map('n', '<C-l>', '<C-w>l', opts)

-- Quick Save
map('n', '<leader>w', ':w<CR>', opts)

-- Clipboard
-- Yank and move the cursor to the end of yanked text.
map('n', 'y', 'y`]', opt_noremap)
map('n', 'yy', 'yy`]', opt_noremap)
map('n', 'mc', '"+y`]', opt_noremap)
map('n', 'mcc', '"+yy`]', opt_noremap)
map('n', 'md', '"+d', opt_noremap)
map('n', 'mdd', '"+dd', opt_noremap)
map('n', 'zp', '"+p', no_opt)
map('n', 'zP', '"+P', no_opt)

-- Tabs
map('n', '<leader>ta', ':tabnew<CR>', opt_noremap)
map('n', '<leader>t5', ':tabnew %<CR>', opt_noremap)
map('n', '<leader>tc', ':tabclose<CR>', opt_noremap)
map('n', '<leader>to', ':tabonly<CR>', opt_noremap)
map('n', '<leader>tn', ':tabn<CR>', opt_noremap)
map('n', '<leader>tp', ':tabp<CR>', opt_noremap)
-- move current tab to previous position
map('n', '<leader>tmp', ':-tabmove<CR>', opt_noremap)
-- move current tab to next position
map('n', '<leader>tmn', ':+tabmove<CR>', opt_noremap)

-- Resize with arrows
map('n', '<C-S-k>', ':resize -2<CR>', opts)
map('n', '<C-S-j>', ':resize +2<CR>', opts)
map('n', '<C-S-h>', ':vertical resize -2<CR>', opts)
map('n', '<C-S-l>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
map('n', '<leader>bn', ':bnext<CR>', opts)
map('n', '<leader>bp', ':bprevious<CR>', opts)
map('n', '<leader>bd', ':bdelete<CR>', opts)

-- Go To end of line
map('n', '-', 'g_', opts)

-- Better indenting
map('n', '<', '<<', opts)
map('n', '>', '>>', opts)

-- Center screen when jumping
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)

-- Select all
map('n', '<C-a>', 'ggVG', opts)

-- Others
map('n', '<C-n>', ':set invrelativenumber<CR>', opts)
map('n', '<Esc><Esc>', ':nohlsearch<CR>', opts)

-- Insert --
-- Press jk fast to exit insert mode
-- Using better Escape
--[[ map('i', 'jk', '<ESC>', opts) ]]

-- Visual --
-- Clipboard
-- Yank and move the cursor to the end of yanked text.
map('v', 'y', 'y`]', opt_noremap)
map('v', 'mc', '"+y`]', opt_noremap)
map('v', 'md', '"+d', no_opt)

-- Stay in indent mode
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Move text up and down
map('v', 'J', ':m .+1<CR>==', opts)
map('v', 'K', ':m .-2<CR>==', opts)

-- Correct paste behavior in visual mode
map('v', 'p', '"_dP', opts)
map('v', 'P', '"_dP', opts)

-- Go To end of line
map('v', '-', 'g_', opts)
