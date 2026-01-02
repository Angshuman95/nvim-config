return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            require('nvim-treesitter').update()
        end,
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context',
            'hiphish/rainbow-delimiters.nvim',
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                branch = 'main',
            },
        },
        config = function()
            -- Install parsers
            require('nvim-treesitter').install('all')

            -- Rainbow delimiters setup
            local rainbow_delim_ok, rainbow_delim =
                pcall(require, 'rainbow-delimiters')
            if rainbow_delim_ok then
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
            end

            -- Treesitter-context setup
            local context_ok, treesitter_context =
                pcall(require, 'treesitter-context')
            if context_ok then
                treesitter_context.setup({
                    enable = true,
                    max_lines = 0,
                    min_window_height = 0,
                    line_numbers = true,
                    multiline_threshold = 20,
                    trim_scope = 'outer',
                    mode = 'cursor',
                    separator = nil,
                    zindex = 20,
                    on_attach = nil,
                })

                vim.keymap.set('n', '[c', function()
                    treesitter_context.go_to_context()
                end, { silent = true })
            end

            -- Textobjects setup
            local textobjects_ok, textobjects =
                pcall(require, 'nvim-treesitter-textobjects')
            if textobjects_ok then
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

                -- Select keymaps
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

                -- Move keymaps
                for _, mode in ipairs({ 'n', 'x', 'o' }) do
                    vim.keymap.set(mode, ']m', function()
                        textobjects.move.goto_next_start(
                            '@function.outer',
                            'textobjects'
                        )
                    end)
                    vim.keymap.set(mode, ']]', function()
                        textobjects.move.goto_next_start(
                            '@class.outer',
                            'textobjects'
                        )
                    end)
                    vim.keymap.set(mode, ']M', function()
                        textobjects.move.goto_next_end(
                            '@function.outer',
                            'textobjects'
                        )
                    end)
                    vim.keymap.set(mode, '][', function()
                        textobjects.move.goto_next_end(
                            '@class.outer',
                            'textobjects'
                        )
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

                -- Swap keymaps
                vim.keymap.set('n', '<leader>a', function()
                    textobjects.swap.swap_next('@parameter.inner')
                end)
                vim.keymap.set('n', '<leader>A', function()
                    textobjects.swap.swap_previous('@parameter.inner')
                end)
            end

            -- Enable treesitter features per filetype
            vim.api.nvim_create_autocmd('FileType', {
                pattern = '*',
                callback = function()
                    -- Syntax highlighting (provided by Neovim)
                    pcall(vim.treesitter.start)

                    -- Indentation (provided by nvim-treesitter)
                    vim.bo.indentexpr =
                        "v:lua.require'nvim-treesitter'.indentexpr()"

                    -- Folds (provided by Neovim)
                    -- Conflicts with ufo
                    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    -- vim.wo.foldmethod = 'expr'
                end,
            })

            -- Incremental selection keymaps (Neovim built-in)
            vim.keymap.set(
                'n',
                '<c-space>',
                'v<cmd>lua vim.treesitter.select_increment()<cr>'
            )
            vim.keymap.set(
                'v',
                '<c-space>',
                '<cmd>lua vim.treesitter.select_increment()<cr>'
            )
            vim.keymap.set(
                'v',
                '<c-backspace>',
                '<cmd>lua vim.treesitter.select_decrement()<cr>'
            )
        end,
    },
}
