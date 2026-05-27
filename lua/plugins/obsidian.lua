return {
    'obsidian-nvim/obsidian.nvim',
    event = function()
        local cwd = vim.fn.getcwd()
        local workspace_paths = {
            'personal-notes',
            '10_00-Office-Notes',
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
    opts = {
        workspaces = {
            {
                name = 'mac-notes',
                path = '~/Developer/notes_and_files/10-19-Learning/10-Notes/10_00-Personal-Notes/personal-notes',
            },
            {
                name = 'office-notes',
                path = '~/Developer/notes_and_files/10-19-Learning/10-Notes/10_01-Office-Notes/Notes-And-Files/10-19-Learning/10-Notes/10_00-Office-Notes',
            },
            {
                name = 'arch-notes',
                path = '~/Developer/10-19-learning/10-notes/personal-notes',
            },
        },
        notes_subdir = 'notes',
        new_notes_location = 'current_dir',
        note_id_func = function(title)
            if title ~= nil then
                return title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
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
            time_format = '%H:%M',
            substitutions = {},
        },
        ui = { enable = false }, -- using markdown.nvim
        picker = {
            name = 'snacks.pick',
        },
        legacy_commands = false,
    },
}
