local opts = { noremap = true, silent = true }

local opt_noremap = { noremap = true }
local no_opt = {}

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

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
--[[ keymap('n', '<C-h>', '<C-w>h', opts) ]]
--[[ keymap('n', '<C-j>', '<C-w>j', opts) ]]
--[[ keymap('n', '<C-k>', '<C-w>k', opts) ]]
--[[ keymap('n', '<C-l>', '<C-w>l', opts) ]]

-- Clipboard
keymap('n', 'mc', '"+y', opt_noremap)
keymap('n', 'mcc', '"+yy', opt_noremap)
keymap('n', 'md', '"+d', opt_noremap)
keymap('n', 'mdd', '"+dd', opt_noremap)
keymap('n', 'zp', '"+p', no_opt)
keymap('n', 'zP', '"+P', no_opt)

-- Tabs
keymap('n', '<leader>ta', ':$tabnew<CR>', opt_noremap)
keymap('n', '<leader>t5', ':tabnew %<CR>', opt_noremap)
keymap('n', '<leader>tc', ':tabclose<CR>', opt_noremap)
keymap('n', '<leader>to', ':tabonly<CR>', opt_noremap)
keymap('n', '<leader>tn', ':tabn<CR>', opt_noremap)
keymap('n', '<leader>tp', ':tabp<CR>', opt_noremap)
-- move current tab to previous position
keymap('n', '<leader>tmp', ':-tabmove<CR>', opt_noremap)
-- move current tab to next position
keymap('n', '<leader>tmn', ':+tabmove<CR>', opt_noremap)

-- Resize with arrows
keymap('n', '<C-A-k>', ':resize -2<CR>', opts)
keymap('n', '<C-A-j>', ':resize +2<CR>', opts)
keymap('n', '<C-A-h>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-A-l>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Move text up and down
keymap('n', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
keymap('n', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)

-- Go To end of line
keymap('n', '-', 'g_', opts)

-- Others
keymap('n', '<C-n>', ':set invrelativenumber<CR>', no_opt)
keymap('n', '<leader>h', '<Esc>:nohlsearch<CR><Esc>', opts)

-- Plugins
-- Telescope
keymap('n', '<leader>f', ':Telescope find_files<CR>', no_opt)
keymap('n', '<leader>b', ':Telescope buffers<CR>', no_opt)
keymap(
    'n',
    '<leader>sd',
    ':lua require"telescope.builtin".diagnostics{ bufnr=0 }<CR>',
    no_opt
)
keymap('n', '<leader>sD', ':Telescope diagnostics<CR>', no_opt)
keymap('n', '<leader>sf', ':Telescope current_buffer_fuzzy_find<CR>', no_opt)
keymap('n', '<leader>sr', ':Telescope oldfiles<CR>', no_opt)
keymap('n', '<leader>st', ':Telescope live_grep<CR>', no_opt)
keymap('n', '<leader>ss', ':Telescope lsp_document_symbols<CR>', no_opt)
keymap(
    'n',
    '<leader>sS',
    ':Telescope lsp_dynamic_workspace_symbols<CR>',
    no_opt
)

-- Git and Gitsigns
keymap('n', '<leader>gg', ':Git<CR>', opt_noremap)
keymap('n', '<leader>gj', ':Gitsigns next_hunk<CR>', opt_noremap)
keymap('n', '<leader>gk', ':Gitsigns prev_hunk<CR>', opt_noremap)
keymap('n', '<leader>gd', ':Gvdiffsplit<CR>', opt_noremap)
keymap('n', '<leader>gr', ':Gitsigns reset_hunk<CR>', opt_noremap)
keymap('n', '<leader>gs', ':Gitsigns stage_hunk<CR>', opt_noremap)
keymap('n', '<leader>gu', ':Gitsigns undo_stage_hunk<CR>', opt_noremap)
keymap(
    'n',
    '<leader>gb',
    ':Gitsigns toggle_current_line_blame<CR>',
    opt_noremap
)

-- Others
keymap('n', '<leader>e', ':NvimTreeToggle<CR>', no_opt)
keymap('n', '<leader>lf', ':lua vim.lsp.buf.format()<CR>', opt_noremap)
keymap('n', '<leader>ps', ':Lazy sync<CR>', opt_noremap)

-- Insert --
-- Press jk fast to exit insert mode
-- Using better Escape
--[[ keymap('i', 'jk', '<ESC>', opts) ]]

-- Visual --
-- Clipboard
keymap('v', 'mc', '"+y', no_opt)
keymap('v', 'md', '"+d', no_opt)

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move text up and down
keymap('v', '<A-j>', ':m .+1<CR>==', opts)
keymap('v', '<A-k>', ':m .-2<CR>==', opts)
keymap('v', 'p', '"_dP', opts)

-- Go To end of line
keymap('v', '-', 'g_', opts)

-- Plugins
keymap(
    'v',
    '<leader>lf',
    ':lua vim.lsp.buf.range_formatting()<CR>',
    opt_noremap
)

-- Visual Block --
-- Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)
