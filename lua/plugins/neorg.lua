return {
    'nvim-neorg/neorg',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-neorg/neorg-telescope' },
        { 'vhyrro/luarocks.nvim' },
    },
    cmd = 'Neorg',
    config = function()
        require('neorg').setup({
            load = {
                ['core.defaults'] = {}, -- Loads default behaviour
                ['core.concealer'] = {}, -- Adds pretty icons to your documents
                ['core.dirman'] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            main = '~/Documents/personal-notes',
                        },
                        default_workspace = 'main',
                    },
                },
                ['core.completion'] = {
                    config = {
                        engine = 'nvim-cmp',
                        name = '[Neorg]',
                    },
                },
                ['core.export'] = {},
                ['core.integrations.nvim-cmp'] = {},
                ['core.integrations.telescope'] = {},
            },
        })

        local neorg_callbacks = require('neorg.core.callbacks')

        neorg_callbacks.on_event(
            'core.keybinds.events.enable_keybinds',
            function(_, keybinds)
                -- Map all the below keybinds only when the "norg" mode is active
                keybinds.map_event_to_mode('norg', {
                    n = { -- Bind keys in normal mode
                        {
                            '<leader>fl',
                            'core.integrations.telescope.find_linkable',
                        },
                        {
                            '<leader>fh',
                            'core.integrations.telescope.search_headings',
                        },
                        {
                            '<leader>il',
                            'core.integrations.telescope.insert_link',
                        },
                        {
                            '<leader>if',
                            'core.integrations.telescope.insert_file_link',
                        },
                    },

                    -- Bind in insert mode
                    --[[ i = { }, ]]
                }, {
                    silent = true,
                    noremap = true,
                })
            end
        )
    end,
}
