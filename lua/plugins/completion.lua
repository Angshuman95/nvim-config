return {
    'saghen/blink.cmp',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        {
            'rafamadriz/friendly-snippets',
        },
    },
    version = '1.*',
    opts = {
        keymap = { preset = 'default' },
        appearance = {
            nerd_font_variant = 'mono',
        },
        completion = {
            accept = {
                auto_brackets = {
                    enabled = true,
                },
            },
            menu = {
                draw = {
                    treesitter = { 'lsp' },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
        },
        signature = { enabled = true },
        sources = {
            default = {
                'lsp',
                'path',
                'snippets',
                'buffer',
            },
        },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
}
