return {
    settings = {
        yaml = {
            -- Let SchemaStore.nvim provide the catalog instead of yamlls'
            schemaStore = {
                enable = false,
                url = '',
            },
            schemas = require('schemastore').yaml.schemas(),
        },
    },
}
