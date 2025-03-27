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
    -- https://github.com/navarasu/onedark.nvim
    {
        "navarasu/onedark.nvim",
        priority = 1000, -- Ensure it loads first
        config = function()
            require('onedark').setup {
                -- Main options --
                style = 'deep',               -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
                transparent = false,          -- Show/hide background
                term_colors = true,           -- Change terminal color as per the selected theme style
                ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
                cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

                -- toggle theme style ---
                toggle_style_key = nil,                                                              -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
                toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

                -- Change code style ---
                -- Options are italic, bold, underline, none
                -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
                code_style = {
                    comments = 'italic',
                    keywords = 'none',
                    functions = 'none',
                    strings = 'none',
                    variables = 'none'
                },

                -- Lualine options --
                lualine = {
                    transparent = false, -- lualine center bar transparency
                },

                -- Custom Highlights --
                colors = {},     -- Override default colors
                highlights = {}, -- Override highlight groups

                -- Plugins Config --
                diagnostics = {
                    darker = true,     -- darker colors for diagnostic
                    undercurl = true,  -- use undercurl instead of underline for diagnostics
                    background = true, -- use background color for virtual text
                },
            }
            require('onedark').load()
        end,
    },
}
