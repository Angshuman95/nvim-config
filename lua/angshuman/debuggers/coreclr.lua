local dap_status_ok, dap = pcall(require, 'dap')
if not dap_status_ok then
    return
end

-- netcoredbg for Darwin M1 compiled on Jul 9, 2023
dap.adapters.coreclr = {
    type = 'executable',
    command = 'netcoredbg',
    args = { '--interpreter=vscode' },
}

dap.configurations.cs = {
    {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
            return vim.fn.input(
                'Path to dll: ',
                vim.fn.getcwd() .. '/bin/Debug/',
                'file'
            )
        end,
    },
}
