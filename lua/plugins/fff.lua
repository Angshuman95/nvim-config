return {
    'dmtrKovalenko/fff.nvim',
    build = 'cargo build --release',
    opts = {
        -- pass here all the options
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
