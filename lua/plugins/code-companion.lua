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
    opts = function()
        local adapter_config
        if os.getenv('DEEPSEEK_API_KEY') then
            adapter_config = 'deepseek'
        else
            adapter_config = {
                name = 'copilot',
                model = 'claude-sonnet-4.6',
            }
        end
        return {
            adapters = {
                deepseek = function()
                    return require('codecompanion.adapters').extend(
                        'deepseek',
                        {
                            env = {
                                api_key = os.getenv('DEEPSEEK_API_KEY'),
                            },
                        }
                    )
                end,
            },
            strategies = {
                chat = {
                    adapter = adapter_config,
                },
                inline = {
                    adapter = adapter_config,
                },
            },
            extensions = {
                history = {
                    opts = {
                        picker = 'snacks',
                    },
                },
            },
        }
    end,
}
