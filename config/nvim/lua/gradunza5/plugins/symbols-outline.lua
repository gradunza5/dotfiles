-- https://github.com/simrat39/symbols-outline.nvim
return {
    "simrat39/symbols-outline.nvim",
    keys = {
        { '<leader>y', '<CMD>SymbolsOutline<CR>', desc = 'Open Symbols Outline' }
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("symbols-outline").setup()
        -- This plugin can't handle keys
        -- vim.keymap.set('n', '<leader>y', '<CMD>SymbolsOutline<CR>')
    end,
}
