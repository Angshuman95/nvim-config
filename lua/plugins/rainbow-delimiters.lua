return {
    'hiphish/rainbow-delimiters.nvim',
    config = function()
        local rainbow_delim = require('rainbow-delimiters')
        vim.g.rainbow_delim = {
            strategy = {
                [''] = rainbow_delim.strategy['global'],
                vim = rainbow_delim.strategy['local'],
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks',
            },
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterBlue',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },
        }
    end,
}
