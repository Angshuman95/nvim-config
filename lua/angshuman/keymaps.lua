local opts = { noremap = true, silent = true }

local opt_noremap = { noremap = true }
local no_opt = {}

-- Shorten function name
local map = vim.keymap.set

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
--[[ map('n', '<C-h>', '<C-w>h', opts) ]]
--[[ map('n', '<C-j>', '<C-w>j', opts) ]]
--[[ map('n', '<C-k>', '<C-w>k', opts) ]]
--[[ map('n', '<C-l>', '<C-w>l', opts) ]]

-- Clipboard
map('n', 'mc', '"+y', opt_noremap)
map('n', 'mcc', '"+yy', opt_noremap)
map('n', 'md', '"+d', opt_noremap)
map('n', 'mdd', '"+dd', opt_noremap)
map('n', 'zp', '"+p', no_opt)
map('n', 'zP', '"+P', no_opt)

-- Tabs
map('n', '<leader>ta', ':$tabnew<CR>', opt_noremap)
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
map('n', '<C-A-k>', ':resize -2<CR>', opts)
map('n', '<C-A-j>', ':resize +2<CR>', opts)
map('n', '<C-A-h>', ':vertical resize -2<CR>', opts)
map('n', '<C-A-l>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
map('n', '<leader>n', ':bnext<CR>', opts)
map('n', '<leader>p', ':bprevious<CR>', opts)
map('n', '<leader>d', ':bdelete<CR>', opts)

-- Move text up and down
map('n', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
map('n', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)

-- Go To end of line
map('n', '-', 'g_', opts)

-- Others
map('n', '<C-n>', ':set invrelativenumber<CR>', opts)
map('n', '<Esc><Esc>', ':nohlsearch<CR>', opts)

-- Insert --
-- Press jk fast to exit insert mode
-- Using better Escape
--[[ map('i', 'jk', '<ESC>', opts) ]]

-- Visual --
-- Clipboard
map('v', 'mc', '"+y', no_opt)
map('v', 'md', '"+d', no_opt)

-- Stay in indent mode
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Move text up and down
map('v', '<A-j>', ':m .+1<CR>==', opts)
map('v', '<A-k>', ':m .-2<CR>==', opts)
map('v', 'p', '"_dP', opts)

-- Go To end of line
map('v', '-', 'g_', opts)

-- Visual Block --
-- Move text up and down
map('x', 'J', ":move '>+1<CR>gv-gv", opts)
map('x', 'K', ":move '<-2<CR>gv-gv", opts)
map('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
map('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)
