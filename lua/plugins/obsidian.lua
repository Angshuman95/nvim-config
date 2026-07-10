return {
    'obsidian-nvim/obsidian.nvim',
    event = function()
        local cwd = vim.fn.getcwd()
        local workspace_paths = {
            'personal-notes',
        }

        for _, path in ipairs(workspace_paths) do
            if string.find(cwd, path, 1, true) then
                return 'VeryLazy'
            end
        end
        return nil
    end,
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('obsidian').setup({
            workspaces = {
                {
                    name = 'arch-notes',
                    path = '~/Developer/10-19-learning/10-notes/personal-notes',
                },
            },
            notes_subdir = 'notes',
            new_notes_location = 'current_dir',
            note_id_func = function(title)
                if title ~= nil then
                    return title
                        :gsub(' ', '-')
                        :gsub('[^A-Za-z0-9-]', '')
                        :lower()
                end
                return tostring(os.time())
            end,
            daily_notes = {
                folder = 'journals',
                date_format = '%Y/%m-%B/%Y-%m-%d-daily-note',
                alias_format = nil,
                default_tags = { 'daily-notes' },
                template = 'daily-note.md',
            },
            templates = {
                folder = 'templates',
                date_format = '%Y-%m-%d',
                time_format = '%H:%M:%S',
                substitutions = {},
            },
            ui = { enable = false }, -- using markdown.nvim
            picker = {
                name = 'snacks.picker',
            },
            legacy_commands = false,

            vim.keymap.set(
                'n',
                '<leader>v',
                '<cmd>Obsidian follow_link vsplit_force<CR>',
                {
                    desc = 'Open Obsidian link in vsplit',
                    silent = true,
                }
            ),
        })
    end,
}
