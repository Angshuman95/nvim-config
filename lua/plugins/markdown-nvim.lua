return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    ft = { 'markdown', 'codecompanion' },
    opts = {
        completions = { lsp = { enabled = true } },
    },
}
