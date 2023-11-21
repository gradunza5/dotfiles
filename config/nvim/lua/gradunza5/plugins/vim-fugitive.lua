-- https://github.com/tpope/vim-fugitive
return {
    "tpope/vim-fugitive",
    event = "FileType",
    keys = {
        { "<leader>gb", "<CMD>Git blame<CR>",  desc = "Git Blame Toggle" },
        { "<leader>gs", "<CMD>Git status<CR>", desc = "Git Status Toggle" },
    },
    config = function()
        vim.keymap.set("n", "<Leader>tt", "<CMD>diffg //2<CR>",
            { desc = "Git merge tool : Take from Target (left buffer)" })

        vim.keymap.set("n", "<Leader>tm", "<CMD>diffg //3<CR>",
            { desc = "Git merge tool : Take from Merge (right buffer)" })
    end
}
