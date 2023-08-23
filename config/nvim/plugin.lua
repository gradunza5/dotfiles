-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- init lazy
require("lazy").setup({
    -- FZF
    { "junegunn/fzf", cmd = "fzf#install()" },
    "junegunn/fzf.vim",

    -- C# Support
    "OmniSharp/omnisharp-vim",

    -- colors
    "altercation/vim-colors-solarized",
    "phanviet/vim-monokai-pro",
    "liuchengxu/space-vim-dark",
    "lifepillar/vim-solarized8",

    -- buffer management
    "qpkorr/vim-bufkill",

    -- statusline
    -- "itchyny/lightline.vim -- REPLACE WITH LUALINE?
    
    -- vimwiki
    "vimwiki/vimwiki",

    -- File Tree
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",

    -- easymotion
    "easymotion/vim-easymotion",

    -- KEEP THIS LAST
    "ryanoasis/vim-devicons"
})

