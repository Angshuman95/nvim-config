return {
    'rest-nvim/rest.nvim',
    ft = 'http',
    dependencies = { 'vhyrro/luarocks.nvim' },
    config = function()
        require('rest-nvim').setup({
            skip_ssl_verification = true,
            keybinds = {
                {
                    '<leader>rr',
                    '<cmd>Rest run<cr>',
                    'Run request under the cursor',
                },
            },
        })
    end,
}
