local status_ok, barbecue = pcall(require, 'barbecue')
if not status_ok then
    return
end

local tokyonight_ok, _ = pcall(require, 'tokyonight')

if tokyonight_ok then
    barbecue.setup({
        theme = 'catppuccin-mocha',
    })

    return
end

barbecue.setup()
