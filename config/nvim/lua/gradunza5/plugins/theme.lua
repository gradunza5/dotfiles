return {
    { "altercation/vim-colors-solarized", lazy = true },
    { "phanviet/vim-monokai-pro",         lazy = true },
    { "liuchengxu/space-vim-dark",        lazy = true },
    { "lifepillar/vim-solarized8",        lazy = true },
    { "catppuccin/nvim",                  lazy = true },
    { "rebelot/kanagawa.nvim",            lazy = true },
    { "jacoborus/tender.vim",             lazy = true },
    { "Shatur/neovim-ayu",                lazy = true },
    { "savq/melange-nvim",                lazy = true },
    { "folke/tokyonight.nvim",            lazy = true },
    { 'rose-pine/neovim',                 spec = { name = 'rose-pine', lazy = true } },
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = true,
        priority = 1000,
        opts = function()
            return {
                transparent = true,
                terminal_colors = false,
            }
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },
    -- Lazy
    {
        "olimorris/onedarkpro.nvim",
        --priority = 1000, -- Ensure it loads first
        lazy = true,
    }
}
