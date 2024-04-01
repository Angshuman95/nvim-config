return {
    'nanozuki/tabby.nvim',
    event = 'VimEnter',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        local catppuccin_ok, catppuccin_palettes =
            pcall(require, 'catppuccin.palettes')
        local mocha = {}
        local theme = {}

        if catppuccin_ok then
            mocha = catppuccin_palettes.get_palette('mocha')
            theme = {
                fill = {
                    fg = mocha.subtext0,
                    bg = mocha.base,
                    style = 'italic',
                },
                head = { fg = mocha.crust, bg = mocha.pink },
                current_tab = { fg = mocha.crust, bg = mocha.mauve },
                tab = { fg = mocha.subtext1, bg = mocha.mantle },
                win = { fg = mocha.subtext1, bg = mocha.mantle },
                tail = { fg = mocha.subtext1, bg = mocha.mantle },
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
