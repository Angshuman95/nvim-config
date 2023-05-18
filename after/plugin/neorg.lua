local status_ok, neorg = pcall(require, 'neorg')
if not status_ok then
    return
end

neorg.setup({
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
                name = '[Neorg]'
            }
        },
        ['core.integrations.nvim-cmp'] = {}
    },
})

-- For quick reference about neorg
--[[ https://github.com/nvim-neorg/neorg/blob/main/doc/neorg.norg ]]
