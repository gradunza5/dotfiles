-- https://github.com/tpope/vim-fugitive
return {
  "tpope/vim-fugitive",
  event = "FileType",
  keys = {
    { "<leader>gb", "<CMD>Git blame<CR>", desc = "Git Blame Toggle" },
    { "<leader>gs", "<CMD>Git status<CR>", desc = "Git Status Toggle" },
  },
}
