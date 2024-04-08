return {
    'm4xshen/smartcolumn.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        require('smartcolumn').setup({
            colorcolumn = { '80', '120' },
        })
    end,
}
