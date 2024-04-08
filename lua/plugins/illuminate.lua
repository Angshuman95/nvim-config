return {
    'RRethy/vim-illuminate',
    config = function ()
        require('illuminate').configure()
    end,
    event = { 'BufReadPre', 'BufNewFile' }
}
