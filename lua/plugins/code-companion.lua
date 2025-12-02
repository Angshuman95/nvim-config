return {
    'olimorris/codecompanion.nvim',
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
                    model = 'claude-sonnet-4.5',
                },
            },
        },
        memory = {
            opts = {
                chat = {
                    enabled = true,
                },
            },
        },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
}
