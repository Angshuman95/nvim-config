return {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('nvim-tree').setup({
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            renderer = {
                root_folder_modifier = ':t',
                icons = {
                    glyphs = {
                        default = '',
                        symlink = '',
                        folder = {
                            arrow_open = '',
                            arrow_closed = '',
                            default = '',
                            open = '',
                            empty = '',
                            empty_open = '',
                            symlink = '',
                            symlink_open = '',
                        },
                        git = {
                            unstaged = '',
                            staged = 'S',
                            unmerged = '',
                            renamed = '➜',
                            untracked = 'U',
                            deleted = '',
                            ignored = '◌',
                        },
                    },
                },
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                icons = {
                    hint = '',
                    info = '',
                    warning = '',
                    error = '',
                },
            },
            view = {
                --[[ width = 30, ]]
                adaptive_size = true,
                side = 'left',
            },
            git = {
                enable = true,
                ignore = false,
                timeout = 400,
            },
        })
    end,
    cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
    keys = { { '<leader>e', '<cmd>NvimTreeToggle<CR>' } },
}
