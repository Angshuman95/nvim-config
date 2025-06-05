return {
    'nanozuki/tabby.nvim',
    event = 'VimEnter',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        local catppuccin_ok, catppuccin_palettes =
            pcall(require, 'catppuccin.palettes')
        local theme = {}

        if catppuccin_ok then
            local palette_name = vim.o.background == 'dark' and 'mocha'
                or 'latte'
            local palette = catppuccin_palettes.get_palette(palette_name)
            theme = {
                fill = {
                    fg = palette.subtext0,
                    bg = palette.base,
                    style = 'italic',
                },
                head = { fg = palette.crust, bg = palette.pink },
                current_tab = { fg = palette.crust, bg = palette.mauve },
                tab = { fg = palette.subtext1, bg = palette.mantle },
                win = { fg = palette.subtext1, bg = palette.mantle },
                tail = { fg = palette.subtext1, bg = palette.mantle },
            }
        else
            theme = {
                fill = 'TabLineFill',
                head = 'TabLine',
                current_tab = 'TabLineSel',
                tab = 'TabLine',
                win = 'TabLine',
                tail = 'TabLine',
            }
        end

        require('tabby.tabline').set(function(line)
            return {
                {
                    line.sep('', theme.head, theme.fill),
                    { '  ', hl = theme.head },
                    line.sep('', theme.head, theme.fill),
                },
                line.tabs().foreach(function(tab)
                    local hl = tab.is_current() and theme.current_tab
                        or theme.tab
                    return {
                        line.sep('', hl, theme.fill),
                        tab.is_current() and '' or '󰆣',
                        tab.number(),
                        tab.name(),
                        tab.close_btn(''),
                        line.sep('', hl, theme.fill),
                        hl = hl,
                        margin = ' ',
                    }
                end),
                line.spacer(),
                line.wins_in_tab(line.api.get_current_tab())
                    .foreach(function(win)
                        return {
                            line.sep('', theme.win, theme.fill),
                            win.is_current() and '' or '',
                            win.buf_name(),
                            line.sep('', theme.win, theme.fill),
                            hl = theme.win,
                            margin = ' ',
                        }
                    end),
                {
                    line.sep('', theme.tail, theme.fill),
                    { '  ', hl = theme.tail },
                },
                hl = theme.fill,
            }
        end)
    end,
}
