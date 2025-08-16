return {
    'dmtrKovalenko/fff.nvim',
    build = 'cargo build --release',
    opts = {
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
            desc = 'Open file picker',
        },
    },
}
