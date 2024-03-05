-- https://github.com/numToStr/Comment.nvim
return {
    {
        'numToStr/Comment.nvim',
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },
}
