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
        local has_opencodezen = os.getenv('OPENCODE_ZEN_API_KEY') ~= nil
        local has_deepseek = os.getenv('DEEPSEEK_API_KEY') ~= nil

        local adapters_http = {}
        if has_opencodezen then
            adapters_http.opencodezen = function()
                return require('codecompanion.adapters').extend(
                    'openai_compatible',
                    {
                        name = 'opencodezen',
                        formatted_name = 'OpenCode Zen',
                        env = {
                            api_key = os.getenv('OPENCODE_ZEN_API_KEY'),
                            url = 'https://opencode.ai/zen',
                            chat_url = '/v1/chat/completions',
                            models_endpoint = '/v1/models',
                        },
                        schema = {
                            model = {
                                default = 'deepseek-v4-pro',
                            },
                        },
                    }
                )
            end
        end
        if has_deepseek then
            adapters_http.deepseek = function()
                return require('codecompanion.adapters').extend('deepseek', {
                    env = {
                        api_key = os.getenv('DEEPSEEK_API_KEY'),
                    },
                })
            end
        end

        -- Pick default adapter: opencodezen > deepseek > copilot
        local adapter_config
        if has_opencodezen then
            adapter_config = 'opencodezen'
        elseif has_deepseek then
            adapter_config = 'deepseek'
        else
            adapter_config = {
                name = 'copilot',
                model = 'claude-opus-4.8',
            }
        end

        return {
            adapters = {
                http = adapters_http,
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
