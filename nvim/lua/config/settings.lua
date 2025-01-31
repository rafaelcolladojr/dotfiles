vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.backspace = '2'

-- editor settings
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = false
vim.opt.signcolumn = 'yes'
vim.opt.autoread = true
-- vim.opt.colorcolumn = '80'
vim.opt.termguicolors = true

-- Relative line numbers
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.wrap = false

-- command line
vim.opt.pumblend = 20
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full'
vim.opt.wildoptions = 'pum'
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1;

-- use spaces for tabs and stuff
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.smartindent = true

-- Don't highlight search results
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.scrolloff = 8
vim.opt.updatetime = 50


-- Native clipboard
vim.opt.clipboard = 'unnamedplus'

-- When opening a window, put it right or below the current one
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Enable mouse support
vim.opt.mouse = 'a'
