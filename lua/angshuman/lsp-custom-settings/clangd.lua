return {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    cmd = {
        'clangd',
        '--offset-encoding=utf-16',
    },
}
