return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {
            '<leader>p',
            function()
                require('harpoon'):list():add()
            end,
            desc = 'Pin to Harpoon',
        },
        {
            '<C-e>',
            function()
                require('harpoon').ui:toggle_quick_menu(
                    require('harpoon'):list()
                )
            end,
            desc = 'Toggle Harpoon menu',
        },
        {
            '<leader>1',
            function()
                require('harpoon'):list():select(1)
            end,
            desc = 'Harpoon 1',
        },
        {
            '<leader>2',
            function()
                require('harpoon'):list():select(2)
            end,
            desc = 'Harpoon 2',
        },
        {
            '<leader>3',
            function()
                require('harpoon'):list():select(3)
            end,
            desc = 'Harpoon 3',
        },
        {
            '<leader>4',
            function()
                require('harpoon'):list():select(4)
            end,
            desc = 'Harpoon 4',
        },
        {
            '<leader>5',
            function()
                require('harpoon'):list():select(5)
            end,
            desc = 'Harpoon 5',
        },
        {
            '<leader>6',
            function()
                require('harpoon'):list():select(6)
            end,
            desc = 'Harpoon 6',
        },
        {
            '<C-p>',
            function()
                require('harpoon'):list():prev()
            end,
            desc = 'Harpoon prev',
        },
        {
            '<C-n>',
            function()
                require('harpoon'):list():next()
            end,
            desc = 'Harpoon next',
        },
        {
            '<leader>h',
            function()
                local harpoon = require('harpoon')
                local harpoon_list = harpoon:list()
                local files = {}

                for _, item in ipairs(harpoon_list.items) do
                    if item and item.value ~= '' then
                        table.insert(files, {
                            text = item.value,
                            file = item.value,
                        })
                    end
                end

                require('snacks').picker.pick({
                    title = 'Harpoon',
                    finder = function()
                        return files
                    end,
                    format = 'file',
                    confirm = 'jump',
                })
            end,
            desc = 'Snacks picker Harpoon',
        },
    },
    config = function()
        require('harpoon'):setup()
    end,
}
