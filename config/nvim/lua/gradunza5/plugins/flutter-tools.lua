return {
    'akinsho/flutter-tools.nvim',
    ft = {
        "dart"
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    opt = {
        debugger = {
            enabled = true,
            run_via_dap = true,
        },
    },
    config = function()
        require("telescope").load_extension("flutter")

        vim.keymap.set("n", "<leader>fl", function()
            require('telescope').extensions.flutter.commands()
        end, { desc = "Telescope Flutter Commands" })
    end
}
