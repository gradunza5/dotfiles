-- https://github.com/simrat39/symbols-outline.nvim
return {
    "simrat39/symbols-outline.nvim",
    event = "VeryLazy",
    -- keys = {
    --     { '<leader>y',  '<CMD>SymbolsOutline<CR>', desc = 'Open Symbols Outline' }
    --     { "<leader>ww", "<CMD>VimwikiIndex<CR>",   desc = "Vim Wiki Diary Index" },
    -- }
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("symbols-outline").setup()
        -- This plugin can't handle keys
        vim.keymap.set('n', '<leader>y', '<CMD>SymbolsOutline<CR>')
    end,
}
