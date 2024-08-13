return {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    dependencies = {
        -- Required.
        'nvim-lua/plenary.nvim',
    },
    opts = {
        workspaces = {
            {
                name = 'personal-notes',
                path = '~/Documents/personal-notes',
            },
        },
        notes_subdir = 'Notes',
        daily_notes = {
            folder = 'Journal',
            date_format = '%Y-%m-%d',
            alias_format = '%B %-d, %Y',
            default_tags = { 'daily-notes' },
            template = nil,
        },
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        templates = {
            folder = 'Templates',
            date_format = '%Y-%m-%d',
            time_format = '%H:%M',
            substitutions = {},
        },
        ui = { enable = false } -- using markdown.nvim
    },
}
