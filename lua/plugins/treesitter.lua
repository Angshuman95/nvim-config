return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = '<cmd>TSUpdate',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context',
            'hiphish/rainbow-delimiters.nvim',
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        config = function()
            local configs = require('nvim-treesitter.configs')

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

            configs.setup({
                ensure_installed = 'all',
                ignore_install = { 'org' },
                highlight = {
                    enable = true,
                    disable = { '' },
                },
                autopairs = {
                    enable = true,
                },
                indent = { enable = true, disable = { '', '' } },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        scope_incremental = '<c-s>',
                        node_decremental = '<c-backspace>',
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>a'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>A'] = '@parameter.inner',
                        },
                    },
                },
            })

            local context_ok, treesitter_context =
                pcall(require, 'treesitter-context')
            if not context_ok then
                return
            end

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
        end,
    },
}
