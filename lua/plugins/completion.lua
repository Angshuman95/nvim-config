return {
    {
        'hrsh7th/cmp-buffer',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'hrsh7th/cmp-path',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'hrsh7th/cmp-nvim-lsp',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'hrsh7th/cmp-nvim-lua',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'saadparwaiz1/cmp_luasnip',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'L3MON4D3/LuaSnip',
        config = function()
            require('luasnip/loaders/from_vscode').lazy_load()
        end,
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'rafamadriz/friendly-snippets',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
        },
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                mapping = {
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-b>'] = cmp.mapping(
                        cmp.mapping.scroll_docs(-1),
                        { 'i', 'c' }
                    ),
                    ['<C-f>'] = cmp.mapping(
                        cmp.mapping.scroll_docs(1),
                        { 'i', 'c' }
                    ),
                    ['<C-Space>'] = cmp.mapping(
                        cmp.mapping.complete(),
                        { 'i', 'c' }
                    ),
                    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ['<C-e>'] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    -- Accept currently selected item. If none selected, `select` first item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, {
                        'i',
                        's',
                    }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {
                        'i',
                        's',
                    }),
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'neorg' },
                    { name = 'orgmode' },
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
            })
        end,
    },
}
