local colorscheme = 'catppuccin'

--[[ Tokyonight ]]
local tokyonight_ok, tokyonight = pcall(require, 'tokyonight')

if tokyonight_ok and colorscheme == 'tokyonight' then
    tokyonight.setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = 'night',        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = 'day',    -- The theme is used when the background is set to light
        transparent = true,     -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
            -- Style to be applied to different syntax groups
            -- Value is any valid attr-list value for `:help nvim_set_hl`
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
            types = { bold = true },
            -- Background styles. Can be "dark", "transparent" or "normal"
            sidebars = 'dark',            -- style for sidebars, see below
            floats = 'dark',              -- style for floating windows
        },
        sidebars = { 'qf', 'help' },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false,             -- dims inactive windows
        lualine_bold = true,              -- When `true`, section headers in the lualine theme will be bold
        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,
        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
    })

    vim.cmd([[colorscheme tokyonight]])

    return
end

--[[ Onedark ]]
local onedark_ok, onedark = pcall(require, 'onedark')

if onedark_ok and colorscheme == 'onedark' then
    onedark.setup({
        -- Main options --
        style = 'warmer',             -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = true,           -- Show/hide background
        term_colors = true,           -- Change terminal color as per the selected theme style
        ending_tildes = true,         -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        -- toggle theme style ---
        toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = {
            'dark',
            'darker',
            'cool',
            'deep',
            'warm',
            'warmer',
            'light',
        }, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
        code_style = {
            comments = 'italic',
            keywords = 'italic',
            functions = 'none',
            strings = 'none',
            variables = 'none',
            types = 'bold',
        },

        -- Lualine options --
        lualine = {
            transparent = true, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {},     -- Override default colors
        highlights = {}, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
            darker = true,     -- darker colors for diagnostic
            undercurl = true,  -- use undercurl instead of underline for diagnostics
            background = true, -- use background color for virtual text
        },
    })

    onedark.load()

    return
end

--[[ Catppuccin ]]
local catppuccin_ok, catppuccin = pcall(require, 'catppuccin')

if catppuccin_ok and colorscheme == 'catppuccin' then
    catppuccin.setup({
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        background = {
            -- :h background
            light = 'latte',
            dark = 'mocha',
        },
        transparent_background = true,
        show_end_of_buffer = false, -- show the '~' characters after the end of buffers
        term_colors = false,
        dim_inactive = {
            enabled = false,
            shade = 'dark',
            percentage = 0.15,
        },
        no_italic = false,    -- Force no italic
        no_bold = false,      -- Force no bold
        no_underline = false, -- Force no underline
        styles = {
            comments = { 'italic' },
            conditionals = {},
            loops = {},
            functions = {},
            keywords = { 'italic' },
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = { 'bold' },
            operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            telescope = true,
            leap = true,
            lsp_trouble = true,
        },
        indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
        },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme('catppuccin')
end
