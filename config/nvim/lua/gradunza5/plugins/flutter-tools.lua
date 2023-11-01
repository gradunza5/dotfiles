return {
    'akinsho/flutter-tools.nvim',
    lazy = true,
    ft = {
        "dart"
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
    init = function()
        require("telescope").load_extension("flutter")
    end
}
