return {
    'anuvyklack/windows.nvim',
    dependencies = {
        'anuvyklack/middleclass',
        'anuvyklack/animation.nvim',
    },
    keys = {
        { '<C-w>m', '<cmd>WindowsMaximize<CR>', desc = 'Zoom' },
        { '<C-w>=', '<cmd>WindowsEqualize<CR>', desc = 'Reset Zoom' },
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
