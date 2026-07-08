return {
    'fei6409/log-highlight.nvim',
    config = function()
        require('log-highlight').setup({
            keyword = {
                error = { 'ERR', 'ERROR', 'FTL', 'FATAL' },
                warning = { 'WARN', 'WARNING', 'WRN' },
                info = { 'INFO', 'INFORMATION', 'INF' },
                debug = { 'DEBUG', 'VERBOSE', 'DBG', 'VRB' },
            },
        })
    end,
}
