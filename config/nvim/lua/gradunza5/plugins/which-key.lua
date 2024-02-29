-- https://github.com/folke/which-key.nvim
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        require("which-key").setup()

        require("which-key").register {
            ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
            ["<leader>d"] = { name = "[D]iagnostics", _ = "which_key_ignore" },
            ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
            ["<leader>f"] = { name = "[F]ind", _ = "which_key_ignore" },
            ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
        }
    end
}
