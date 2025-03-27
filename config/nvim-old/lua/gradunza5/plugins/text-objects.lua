return {
    {
        "chrisgrieser/nvim-various-textobjs",
        lazy = false,
        opts = {
            keymaps = {
                useDefaults = true
            }
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = false,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
