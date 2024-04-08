return {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('spectre').setup()
    end,
    cmd = 'Spectre',
    keys = {
        {
            'n',
            '<Leader>S',
            '<cmd>Spectre<CR>',
            { noremap = true, silent = true },
        },
    },
}
