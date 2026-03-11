return {
    'dmtrKovalenko/fff.nvim',
    build = function()
        require('fff.download').download_or_build_binary()
    end,
    opts = {
        prompt = ' ',
        layout = {
            prompt_position = 'top',
        },
    },
    keys = {
        {
            '<leader>f',
            function()
                require('fff').find_files()
            end,
            desc = 'FFFind files',
        },
        {
            '<leader>lg',
            function()
                require('fff').live_grep()
            end,
            desc = 'LiFFFe grep',
        }
    },
}
