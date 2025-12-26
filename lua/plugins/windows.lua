return {
    'anuvyklack/windows.nvim',
    dependencies = {
        'anuvyklack/middleclass',
    },
    keys = {
        {
            '<C-w>m',
            function()
                vim.cmd('WindowsMaximize')
                vim.cmd('WindowsEnableAutowidth')
            end,
            desc = 'Zoom',
        },
        {
            '<C-w>e',
            function()
                vim.cmd('WindowsEqualize')
                vim.cmd('WindowsDisableAutowidth')
            end,
            desc = 'Equalize',
        },
        {
            '<C-w>_',
            '<cmd>WindowsMaximizeVertically<CR>',
            desc = 'Maximize Vertically',
        },
        {
            '<C-w>|',
            '<cmd>WindowsMaximizeHorizontally<CR>',
            desc = 'Maximize Horizontally',
        },
    },
    config = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 10
        vim.o.equalalways = false
        require('windows').setup()
    end,
}
