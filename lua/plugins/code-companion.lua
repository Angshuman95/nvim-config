return {
    'olimorris/codecompanion.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'ravitemer/codecompanion-history.nvim',
    },
    cmd = {
        'CodeCompanion',
        'CodeCompanionChat',
        'CodeCompanionActions',
        'CodeCompanionCmd',
    },
    opts = {
        strategies = {
            chat = {
                adapter = {
                    name = 'copilot',
                    model = 'claude-sonnet-4.6',
                },
            },
            inline = {
                adapter = {
                    name = 'copilot',
                    model = 'claude-sonnet-4.6',
                },
            },
        },
        extensions = {
            history = {
                opts = {
                    picker = 'snacks',
                },
            },
        },
    },
}
