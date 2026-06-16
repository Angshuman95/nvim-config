return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    keys = {
        { 'aa', mode = { 'x', 'o' }, desc = 'Select outer parameter' },
        { 'ia', mode = { 'x', 'o' }, desc = 'Select inner parameter' },
        { 'af', mode = { 'x', 'o' }, desc = 'Select outer function' },
        { 'if', mode = { 'x', 'o' }, desc = 'Select inner function' },
        { 'ac', mode = { 'x', 'o' }, desc = 'Select outer class' },
        { 'ic', mode = { 'x', 'o' }, desc = 'Select inner class' },
        { ']m', mode = { 'n', 'x', 'o' }, desc = 'Next function start' },
        { ']]', mode = { 'n', 'x', 'o' }, desc = 'Next class start' },
        { ']M', mode = { 'n', 'x', 'o' }, desc = 'Next function end' },
        { '][', mode = { 'n', 'x', 'o' }, desc = 'Next class end' },
        { '[m', mode = { 'n', 'x', 'o' }, desc = 'Previous function start' },
        { '[[', mode = { 'n', 'x', 'o' }, desc = 'Previous class start' },
        { '[M', mode = { 'n', 'x', 'o' }, desc = 'Previous function end' },
        { '[]', mode = { 'n', 'x', 'o' }, desc = 'Previous class end' },
        { '<leader>a', mode = 'n', desc = 'Swap next parameter' },
        { '<leader>A', mode = 'n', desc = 'Swap previous parameter' },
    },
    config = function()
        local textobjects = require('nvim-treesitter-textobjects')

        textobjects.setup({
            select = {
                enable = true,
                lookahead = true,
            },
            move = {
                enable = true,
                set_jumps = true,
            },
            swap = {
                enable = true,
            },
        })

        -- Select keymaps (executed dynamically after plugin loads)
        for _, mode in ipairs({ 'x', 'o' }) do
            vim.keymap.set(mode, 'aa', function()
                textobjects.select.select_textobject(
                    '@parameter.outer',
                    'textobjects'
                )
            end)
            vim.keymap.set(mode, 'ia', function()
                textobjects.select.select_textobject(
                    '@parameter.inner',
                    'textobjects'
                )
            end)
            vim.keymap.set(mode, 'af', function()
                textobjects.select.select_textobject(
                    '@function.outer',
                    'textobjects'
                )
            end)
            vim.keymap.set(mode, 'if', function()
                textobjects.select.select_textobject(
                    '@function.inner',
                    'textobjects'
                )
            end)
            vim.keymap.set(mode, 'ac', function()
                textobjects.select.select_textobject(
                    '@class.outer',
                    'textobjects'
                )
            end)
            vim.keymap.set(mode, 'ic', function()
                textobjects.select.select_textobject(
                    '@class.inner',
                    'textobjects'
                )
            end)
        end

        -- Move keymaps (executed dynamically after plugin loads)
        for _, mode in ipairs({ 'n', 'x', 'o' }) do
            vim.keymap.set(mode, ']m', function()
                textobjects.move.goto_next_start(
                    '@function.outer',
                    'textobjects'
                )
            end)
            vim.keymap.set(mode, ']]', function()
                textobjects.move.goto_next_start('@class.outer', 'textobjects')
            end)
            vim.keymap.set(mode, ']M', function()
                textobjects.move.goto_next_end('@function.outer', 'textobjects')
            end)
            vim.keymap.set(mode, '][', function()
                textobjects.move.goto_next_end('@class.outer', 'textobjects')
            end)
            vim.keymap.set(mode, '[m', function()
                textobjects.move.goto_previous_start(
                    '@function.outer',
                    'textobjects'
                )
            end)
            vim.keymap.set(mode, '[[', function()
                textobjects.move.goto_previous_start(
                    '@class.outer',
                    'textobjects'
                )
            end)
            vim.keymap.set(mode, '[M', function()
                textobjects.move.goto_previous_end(
                    '@function.outer',
                    'textobjects'
                )
            end)
            vim.keymap.set(mode, '[]', function()
                textobjects.move.goto_previous_end(
                    '@class.outer',
                    'textobjects'
                )
            end)
        end

        -- Swap keymaps (executed dynamically after plugin loads)
        vim.keymap.set('n', '<leader>a', function()
            textobjects.swap.swap_next('@parameter.inner')
        end)
        vim.keymap.set('n', '<leader>A', function()
            textobjects.swap.swap_previous('@parameter.inner')
        end)
    end,
}
