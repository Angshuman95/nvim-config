local dap_status_ok, dap = pcall(require, 'dap')
if not dap_status_ok then
    return
end

local dap_vtext_ok, dap_vtext = pcall(require, 'nvim-dap-virtual-text')
if not dap_vtext_ok then
    return
end

local dap_ui_status_ok, dapui = pcall(require, 'dapui')
if not dap_ui_status_ok then
    return
end

dap_vtext.setup()

dapui.setup()

require('angshuman.debuggers.coreclr')
require('angshuman.debuggers.lldb')
require('angshuman.debuggers.node2')
require('angshuman.debuggers.python')

vim.fn.sign_define(
    'DapBreakpoint',
    { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' }
)
vim.fn.sign_define(
    'DapStopped',
    { text = '', texthl = '', linehl = '', numhl = '' }
)
vim.fn.sign_define(
    'DapBreakpointRejected',
    { text = '', texthl = '', linehl = '', numhl = '' }
)

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap('n', '<A-b>', '<cmd>lua require"dap".toggle_breakpoint()<cr>', opts)
keymap('n', '<A-h>', '<cmd>lua require"dap".continue()<cr>', opts)
keymap('n', '<A-l>', '<cmd>lua require"dap".step_into()<cr>', opts)
keymap('n', '<A-j>', '<cmd>lua require"dap".step_over()<cr>', opts)
keymap('n', '<A-k>', '<cmd>lua require"dap".step_out()<cr>', opts)
keymap('n', '<leader>dr', '<cmd>lua require"dap".repl.toggle()<cr>', opts)
keymap('n', '<leader>dl', '<cmd>lua require"dap".run_last()<cr>', opts)
keymap('n', '<leader>dt', '<cmd>lua require"dap".terminate()<cr>', opts)
keymap('n', '<leader>du', '<cmd>lua require"dapui".toggle()<cr>', opts)
keymap('n', '<leader>dn', '<cmd>lua require"dap".run_to_cursor()<cr>', opts)
keymap('n', '<leader>dR', '<cmd>lua require"dap".clear_breakpoints()<cr>', opts)
keymap('n', '<leader>da', '<cmd>lua require"debugHelper".attach()<cr>', opts)
keymap(
    'n',
    '<leader>dA',
    '<cmd>lua require"debugHelper".attachToRemote()<cr>',
    opts
)
keymap('n', '<leader>di', '<cmd>lua require"dap.ui.widgets".hover()<cr>', opts)

dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end

dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end

dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end
