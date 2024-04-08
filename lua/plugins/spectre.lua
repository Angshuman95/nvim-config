return {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('spectre').setup()
        vim.keymap.set('n', '<Leader>S', '<cmd>Spectre<CR>', {
            noremap = true,
            silent = true,
        })
    end,
    cmd = 'Spectre',
    keys = { '<Leader>S' },
}