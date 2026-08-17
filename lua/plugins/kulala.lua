return {
    'mistweaverco/kulala.nvim',
    ft = 'http',

    init = function()
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'http',
            callback = function(ev)
                local function map(key, cmd, desc)
                    vim.keymap.set('n', key, cmd, {
                        buffer = ev.buf,
                        noremap = true,
                        silent = true,
                        desc = desc,
                    })
                end

                map(
                    '<CR>',
                    "<cmd>lua require('kulala').run()<CR>",
                    'Execute the request'
                )
                map(
                    '[',
                    "<cmd>lua require('kulala').jump_prev()<CR>",
                    'Jump to previous request'
                )
                map(
                    ']',
                    "<cmd>lua require('kulala').jump_next()<CR>",
                    'Jump to next request'
                )
                map(
                    '<leader>i',
                    "<cmd>lua require('kulala').inspect()<CR>",
                    'Inspect current request'
                )
                map(
                    '<leader>t',
                    "<cmd>lua require('kulala').toggle_view()<CR>",
                    'Toggle view'
                )
                map(
                    '<leader>co',
                    "<cmd>lua require('kulala').copy()<CR>",
                    'Copy current request as curl'
                )
                map(
                    '<leader>ci',
                    "<cmd>lua require('kulala').from_curl()<CR>",
                    'Paste curl from clipboard as http request'
                )
            end,
        })
    end,

    config = function()
        require('kulala').setup({
            winbar = true,
        })
    end,
}
