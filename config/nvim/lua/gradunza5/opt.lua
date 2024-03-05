vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.modelines = 2

vim.opt.compatible = false

-- enable mouse support
vim.opt.mouse = "a"

-- folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 50 -- really super don't automatically start with everything folded thanks

-- line numbering
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 10
vim.opt.spell = true
vim.opt.syntax = "on"
vim.opt.termguicolors = false
vim.opt.autoread = true
vim.opt.colorcolumn = "100"
vim.opt.cursorline = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.timeout = true

-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- preview substitutions live
vim.opt.inccommand = "split"

--  spacing
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"

-- break indenting
vim.opt.breakindent = true

-- disable showing mode since it's in the status line
vim.opt.showmode = false

-- share system clipboard
vim.opt.clipboard = "unnamedplus"

-- undo
vim.opt.swapfile = false
vim.opt.backup = false
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
