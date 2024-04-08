return {
    {
        'ggandor/leap.nvim',
        dependencies = 'tpope/vim-repeat',
        config = function()
            require('leap').add_default_mappings()
        end,
        event = { 'BufReadPre', 'BufNewFile' }
    },
    {
        'ggandor/flit.nvim',
        config = function()
            require('flit').setup({
                keys = { f = 'f', F = 'F', t = 't', T = 'T' },
                labeled_modes = 'v',
                multiline = true,
            })
        end,
        event = { 'BufReadPre', 'BufNewFile' }
    },
}
