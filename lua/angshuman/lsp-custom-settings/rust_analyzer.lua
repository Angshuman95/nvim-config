return {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true,
            },
        },
    },
}
