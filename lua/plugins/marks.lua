return {
    'chentoast/marks.nvim',
    config = function()
        require('marks').setup()
    end,
    event = { 'BufReadPre', 'BufNewFile' }
}
