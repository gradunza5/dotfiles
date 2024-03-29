-- https://github.com/nvim-tree/nvim-tree.lua
local function on_attach()
    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
        }
    end

    -- default mappings
    local api = require("nvim-tree.api")
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    on_attach = on_attach,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        {
            "<leader>e",
            function()
                local api = require("nvim-tree.api")
                api.tree.toggle()
            end,
            desc = "File Tree Toggle",
        },
        {
            "?",
            function()
                local api = require("nvim-tree.api")
                api.tree.toggle_help()
            end,
            desc = "File Tree Help"
        },
        {
            "<C-t>",
            function()
                local api = require("nvim-tree.api")
                api.tree.change_root_to_parent()
            end,
            desc = "File Tree Help"
        },
    },
    config = function()
        local icons = require("nvim-web-devicons")
        require("nvim-tree").setup({
            on_attach = on_nvim_tree_attach,
            renderer = {
                highlight_opened_files = "icon",
                icons = {
                    webdev_colors = true,
                    git_placement = "signcolumn",
                },
                special_files = {
                    "pubspec.yaml",
                    "README.md",
                },
            },
            filters = {
                git_ignored = false,
            },
            view = {
                number = true,
                relativenumber = true,
                width = 50,
            },
            update_focused_file = {
                enable = true,
                update_root = true,
            },
            actions = {
                open_file = {
                    quit_on_open = true
                },
                change_dir = {
                    global = true,
                }
            },
        })
    end,
}
