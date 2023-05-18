local home = vim.loop.os_homedir()

local cache_dir = home .. '/.cache/nvim/'

local shell, os_name
os_name = vim.loop.os_uname().sysname

if os_name == 'Windows_NT' then
    shell = 'pwsh.exe'
    vim.cmd [[set guifont=FiraCode\ NF:h11]]
elseif os_name == 'Darwin' then
    shell = 'zsh'
    vim.cmd [[set guifont=FiraCode\ Nerd\ Font:h15]]
else
    shell = 'fish'
    vim.cmd [[set guifont=Fira\ Code:h10]]
end

local options = {
    syntax = 'on',
    background = 'dark',
    termguicolors = true,
    confirm = true,
    shell = shell,
    mouse = 'a',
    hidden = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    viewoptions = 'folds,cursor,curdir,slash,unix',
    sessionoptions = 'curdir,help,tabpages,winsize',
    wildignorecase = true,
    wildignore =
    '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**',
    backup = true,
    writebackup = true,
    undofile = true,
    swapfile = true,
    directory = cache_dir .. 'swap/',
    undodir = cache_dir .. 'undo/',
    backupdir = cache_dir .. 'backup/',
    viewdir = cache_dir .. 'view/',
    spellfile = cache_dir .. 'spell/en.uft-8.add',
    shada = "!,'300,<50,@100,s10,h",
    backupskip = '/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim',
    autoindent = true,
    smartindent = true,
    shiftround = true,
    showmatch = true,
    ignorecase = true,
    smartcase = true,
    infercase = true,
    incsearch = true,
    wrapscan = true,
    complete = '.,w,b,k',
    inccommand = 'nosplit',
    grepformat = '%f:%l:%c:%m',
    grepprg = 'rg --hidden --vimgrep --smart-case --',
    breakat = [[\ \ ;:,!?]],
    startofline = false,
    whichwrap = 'h,l,<,>,[,],~',
    splitbelow = true,
    splitright = true,
    switchbuf = 'useopen',
    backspace = 'indent,eol,start',
    diffopt = 'filler,iwhite,internal,algorithm:patience',
    completeopt = 'menuone,noselect',
    jumpoptions = 'stack',
    showmode = false,
    shortmess = 'aoOTIcF',
    foldlevelstart = 99,
    ruler = true,
    list = true,
    showtabline = 0,
    winwidth = 30,
    winminwidth = 10,
    pumheight = 15,
    helpheight = 12,
    previewheight = 12,
    showcmd = true,
    equalalways = true,
    laststatus = 2,
    display = 'lastline',
    showbreak = ' ↳  ',
    wrap = true,
    listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←',
    pumblend = 20,
    winblend = 20,
    number = true,
    relativenumber = true,
    cursorline = true,
    timeoutlen = 400,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- colorColumn
vim.cmd [[let &colorcolumn="80,".join(range(120,999),",")]]

-- Neovide Settings
if vim.g.neovide then
    vim.cmd [[let g:neovide_transparency = 0.90]]
    vim.cmd [[let g:neovide_floating_blur_amount_x = 2.0]]
    vim.cmd [[let g:neovide_floating_blur_amount_y = 2.0]]
end
