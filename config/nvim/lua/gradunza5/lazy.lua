-- https://github.com/folke/lazy.nvim
-- https://www.lazyvim.org/
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    print("Setting up Lazy...")
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
    print("Setting up Lazy: DONE")
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("gradunza5.plugins", {
    ui = {},
    change_detection = {
        enabled = false
    },
})
