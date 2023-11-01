vim.g.mapleader = ","
vim.g.modelines = 2

vim.opt.compatible = false
--vim.opt.foldmethod = "syntax"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--vim.opt.nofoldenable = true -- don't fold automatically?
vim.opt.foldlevelstart = 50 -- really super don't automatically start with everything folded thanks
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.spell = true
vim.opt.syntax = "on"
vim.opt.termguicolors = true
vim.opt.autoread = true
vim.opt.updatetime = 50
vim.opt.colorcolumn = "100"
vim.opt.cursorline = true

-- splits
vim.opt.splitbelow = true
--=vim.opt.splitright = false
vim.opt.splitright = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- searching
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

--  spacing
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"

-- undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
