return {
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    opts = {
        workspaces = {
            {
                name = 'personal-notes',
                path = '~/Developer/notes_and_files/10-19-Learning/10-Notes/10_00-Personal-Notes/personal-notes',
            },
            {
                name = 'office-notes',
                path = '~/Developer/notes_and_files/10-19-Learning/10-Notes/10_01-Office-Notes/Notes-And-Files/10-19-Learning/10-Notes/10_00-Office-Notes',
            },
        },
        notes_subdir = 'notes',
        daily_notes = {
            folder = 'journals',
            date_format = '%Y-%m-%d',
            alias_format = '%B %-d, %Y',
            default_tags = { 'daily-notes' },
            template = nil,
        },
        completion = {
            blink = true,
            min_chars = 2,
        },
        templates = {
            folder = 'templates',
            date_format = '%Y-%m-%d',
            time_format = '%H:%M',
            substitutions = {},
        },
        ui = { enable = false }, -- using markdown.nvim
        picker = {
            name = 'fzf-lua',
        },
    },
}
