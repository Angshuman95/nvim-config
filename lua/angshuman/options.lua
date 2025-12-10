local cache_dir = vim.fn.stdpath('cache') .. '/'

-- Ensure cache directories exist
local ensure_dir = function(path)
    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path, 'p')
    end
end

ensure_dir(cache_dir .. 'swap')
ensure_dir(cache_dir .. 'undo')
ensure_dir(cache_dir .. 'backup')
ensure_dir(cache_dir .. 'view')
ensure_dir(cache_dir .. 'spell')

-- Determine shell and guifont based on OS
local shell, guifont
local os_name = vim.uv.os_uname().sysname

if os_name == 'Windows_NT' then
    shell = 'pwsh.exe'
    guifont = 'FiraCode_Nerd_Font_Mono:h10'
elseif os_name == 'Darwin' then
    shell = 'zsh'
    guifont = 'FiraCode_Nerd_Font:h13'
else
    shell = 'zsh'
    guifont = 'Fira_Code:h10'
end

vim.opt.guifont = guifont

local options = {
    background = 'dark',
    termguicolors = true,
    confirm = true,
    shell = shell,
    mouse = 'a',

    -- Indentation
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    shiftround = true,

    -- Session and view
    viewoptions = 'folds,cursor,curdir,slash,unix',
    sessionoptions = 'curdir,help,tabpages,winsize',

    -- Completion and search
    wildignorecase = true,
    wildignore = '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**',
    ignorecase = true,
    smartcase = true,
    infercase = true,
    wrapscan = true,
    complete = '.,w,b,k',
    completeopt = 'menuone,noselect',

    -- Files and backup
    backup = true,
    writebackup = true,
    undofile = true,
    swapfile = true,
    directory = cache_dir .. 'swap/',
    undodir = cache_dir .. 'undo/',
    backupdir = cache_dir .. 'backup/',
    viewdir = cache_dir .. 'view/',
    spellfile = cache_dir .. 'spell/en.utf-8.add',
    shada = "!,'300,<50,@100,s10,h",
    backupskip = '/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim',

    -- Display and UI
    showmode = false,
    shortmess = 'aoOTIcF',
    number = true,
    relativenumber = true,
    cursorline = true,
    list = true,
    listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←',
    showbreak = '↳  ',
    wrap = true,

    -- Split behavior
    splitbelow = true,
    splitright = true,
    switchbuf = 'useopen',

    -- Windows and completion
    pumheight = 15,
    helpheight = 12,
    previewheight = 12,
    pumblend = 20,
    winblend = 20,
    showtabline = 2,
    laststatus = 3, -- Global statusline

    -- Matching and diff
    showmatch = true,
    diffopt = 'filler,iwhite,internal,algorithm:patience',

    -- Misc
    inccommand = 'nosplit',
    grepformat = '%f:%l:%c:%m',
    grepprg = 'rg --hidden --vimgrep --smart-case --',
    breakat = [[\ \;:,!?]],
    startofline = false,
    whichwrap = 'h,l,<,>,[,],~',
    backspace = 'indent,eol,start',
    jumpoptions = 'stack',
    foldlevelstart = 99,
    display = 'lastline',
    timeoutlen = 400,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- colorColumn
-- Handled by smartcolumn
-- vim.cmd([[let &colorcolumn="80,".join(range(120,999),",")]])

-- Neovide Settings
if vim.g.neovide then
    vim.g.neovide_opacity = 0.90
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
end

-- kulala requirements
vim.filetype.add({
    extension = {
        ['http'] = 'http',
    },
})
