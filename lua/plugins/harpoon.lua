return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local harpoon = require('harpoon')

        harpoon:setup()

        vim.keymap.set('n', '<leader>p', function()
            harpoon:list():add()
        end, { desc = 'Pin to Harpoon' })

        vim.keymap.set('n', '<C-e>', function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = 'Toggle Harpoon menu' })

        vim.keymap.set('n', '<leader>1', function()
            harpoon:list():select(1)
        end, { desc = 'Harpoon 1' })
        vim.keymap.set('n', '<leader>2', function()
            harpoon:list():select(2)
        end, { desc = 'Harpoon 2' })
        vim.keymap.set('n', '<leader>3', function()
            harpoon:list():select(3)
        end, { desc = 'Harpoon 3' })
        vim.keymap.set('n', '<leader>4', function()
            harpoon:list():select(4)
        end, { desc = 'Harpoon 4' })
        vim.keymap.set('n', '<leader>5', function()
            harpoon:list():select(5)
        end, { desc = 'Harpoon 5' })
        vim.keymap.set('n', '<leader>6', function()
            harpoon:list():select(6)
        end, { desc = 'Harpoon 6' })

        vim.keymap.set('n', '<C-p>', function()
            harpoon:list():prev()
        end, { desc = 'Harpoon prev' })
        vim.keymap.set('n', '<C-n>', function()
            harpoon:list():next()
        end, { desc = 'Harpoon next' })

        vim.keymap.set('n', '<leader>h', function()
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
        end, { desc = 'Snacks picker Harpoon' })
    end,
}
