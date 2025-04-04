return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            transparent_background = true,
            styles = {
                comments = { 'italic' },
                conditionals = { 'italic' },
                types = { 'bold' },
            },
            integrations = {
                leap = true,
                lsp_trouble = true,
                blink_cmp = true,
            },
            indent_blankline = {
                enabled = true,
                colored_indent_levels = true,
            },
        },
    },
    {
        'folke/tokyonight.nvim',
        lazy = true,
        opts = {
            style = 'night',
            transparent = true,
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                conditionals = { italic = true },
                types = { bold = true },
            },
        },
    },
    {
        'navarasu/onedark.nvim',
        lazy = true,
        opts = {
            style = 'warmer',
            transparent = true,
            code_style = {
                comments = 'italic',
                conditionals = 'italic',
                types = 'bold',
            },

            -- Lualine options --
            lualine = {
                transparent = true, -- lualine center bar transparency
            },

            -- Plugins Config --
            diagnostics = {
                darker = true,     -- darker colors for diagnostic
                undercurl = true,  -- use undercurl instead of underline for diagnostics
                background = true, -- use background color for virtual text
            },
        },
    },
}
