return {
    'nvim-orgmode/orgmode',
    ft = { 'org' },
    dependencies = {
        {
            'akinsho/org-bullets.nvim',
            config = true,
        },
        {
            'lukas-reineke/headlines.nvim',
            dependencies = 'nvim-treesitter/nvim-treesitter',
            config = true,
        },
    },
    config = function()
        require('orgmode').setup({
            org_agenda_files = '~/Documents/org-notes/**/*',
        })
    end,
}
