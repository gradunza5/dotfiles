local colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    yellow = "#ecbe7b",
    cyan = "#0084ff",
    darkblue = "#081633",
    green = "#4ef278",
    orange = "#ff8800",
    violet = "#c489ff",
    magenta = "#ff539e",
    blue = "#51afef",
    red = "#ec5f67",
    white = "#cccccc",
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
    is_cmake_project = function()
        local cmake = require("cmake-tools")
        return cmake.is_cmake_project() and cmake.has_cmake_preset()
    end,
}

local function cmake_line()
    local cmake_presets = io.open(vim.fn.getcwd() .. "/CMakePresets.json", "r")
    if cmake_presets == nil then
        return {}
    end
    io.close(cmake_presets)
    local present = function(text)
        return "[" .. (text and text or "?") .. "]"
    end
    local cmake = require("cmake-tools")

    return {
        {
            function()
                return present(cmake.get_configure_preset())
            end,
            icon = " ",
            cond = conditions.is_cmake_project,
            on_click = function(n, mouse)
                if (n == 1) and (mouse == "l") then
                    cmake.select_configure_preset()
                end
            end,
        },
        {
            function()
                return present(cmake.get_build_target())
            end,
            icon = " ",
            cond = cmake.is_cmake_project,
            on_click = function(n, mouse)
                if (n == 1) and (mouse == "l") then
                    cmake.select_build_target()
                end
            end,
        },
        {
            function()
                return ""
            end,
            cond = cmake.is_cmake_project,
            on_click = function(n, mouse)
                if (n == 1) and (mouse == "l") then
                    cmake.run()
                end
            end,
        },
        {
            function()
                return present(cmake.get_launch_target())
            end,
            cond = cmake.is_cmake_project,
            on_click = function(n, mouse)
                if (n == 1) and (mouse == "l") then
                    cmake.select_launch_target()
                end
            end,
        },
    }
end

return {
    {
        -- https://github.com/stevearc/overseer.nvim
        "stevearc/overseer.nvim",
        keys = {
            { "<leader>Wb", "<cmd>OverseerRun<CR>",    desc = "Execute Task" },
            { "<leader>Wo", "<cmd>OverseerToggle<CR>", desc = "Task Output" },
            { "<leader>B",  "<cmd>OverseerRun<CR>",    desc = "Execute Task" },
            { "<leader>O",  "<cmd>OverseerToggle<CR>", desc = "Task Output" },
        },
        ---@type overseer.Config
        opts = {
            templates = { "make", "vscode", "cargo", "just" },
            task_list = {
                max_width = { 100, 0.4 },
                min_width = { 30, 0.2 },
                max_height = { 20, 0.2 },
                bindings = {
                    ["<C-h>"] = false,
                    ["<C-j>"] = false,
                    ["<C-k>"] = false,
                    ["<C-l>"] = false,
                    ["<C-Left>"] = "DecreaseDetail",
                    ["<C-Down>"] = "ScrollOutputDown",
                    ["<C-Up>"] = "ScrollOutputUp",
                    ["<C-Right>"] = "IncreaseDetail",
                },
            },
        },
        config = function(_, opts)
            local overseer = require("overseer")
            overseer.setup(opts)
            -- https://github.com/stevearc/overseer.nvim/blob/master/doc/reference.md#add_template_hookopts-hook
            overseer.add_template_hook(
                { name = "^make.*", },
                function(task_defn, util)
                    util.add_component(task_defn, { "on_output_parse", problem_matcher = "$gcc" })
                    util.add_component(task_defn, { "on_result_diagnostics" })
                    util.add_component(task_defn, { "on_result_diagnostics_trouble" })
                end)
        end,
    },
    {
        -- https://github.com/mbbill/undotree
        "mbbill/undotree",
        event = "BufEnter",
        keys = {
            { "<leader>U",  "<cmd>UndotreeToggle<CR>", desc = "Toggle Undo Tree" },
            { "<leader>Wu", "<cmd>Outline<CR>",        desc = "Undo Tree" },
        },
        init = function()
            vim.g.undotree_WindowLayout = 4
        end,
    },
    {
        -- https://github.com/folke/trouble.nvim
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        keys = {
            { "<leader>Wd", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
        },
        opts = {
            padding = false,
            mode = "document_diagnostics",
        },
    },
    {
        -- https://github.com/hedyhli/outline.nvim
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = {
            { "<leader>y",  "<cmd>Outline<CR>", desc = "Toggle Symbol Outline" },
            { "<leader>Wy", "<cmd>Outline<CR>", desc = "Symbol Outline" },
        },
        opts = {
            symbol_folding = {
                autofold_depth = 5,
            },
        },
    },
    {
        -- https://github.com/lewis6991/gitsigns.nvim
        "lewis6991/gitsigns.nvim",
        keys = {
            { "<leader>gb", "<cmd>Gitsigns blame<CR>",                     desc = "Git Blame Toggle" },
            { "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Git Blame Toggle" },
            { "<leader>Wb", "<cmd>Gitsigns blame<CR>",                     desc = "Git Blame" },
        },
        cmd = {
            "Gitsigns",
        },
        opts = {},
    },
    {
        -- https://github.com/folke/which-key.nvim
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
        opts = {
            prefix = "<leader>",
        },
    },
    {
        -- https://github.com/NvChad/nvim-colorizer.lua
        "NvChad/nvim-colorizer.lua",
        ft = {
            "css",
            "dosini",
            "lua",
        },
        opts = {
            filetypes = { "*" },
            user_default_options = {
                RGB = true,           -- #RGB hex codes
                RRGGBB = true,        -- #RRGGBB hex codes
                names = false,        -- "Name" codes like Blue or blue
                RRGGBBAA = false,     -- #RRGGBBAA hex codes
                AARRGGBB = false,     -- 0xAARRGGBB hex codes
                rgb_fn = false,       -- CSS rgb() and rgba() functions
                hsl_fn = false,       -- CSS hsl() and hsla() functions
                css = false,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = false,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
                mode = "virtualtext", -- "foreground", "background", "virtualtext"
                tailwind = false,
                sass = { enable = false, parsers = { "css" } },
                virtualtext = "■",
                always_update = false,
            },
            buftypes = {},
        },
        {
            -- https://github.com/akinsho/bufferline.nvim
            "akinsho/bufferline.nvim",
            dependencies = "nvim-tree/nvim-web-devicons",
            lazy = false,
            -- stylua: ignore start
            keys = {
                { "<leader>1", function() require("bufferline").go_to(1, true) end, desc = "GoTo Ordinal Buffer 1", },
                { "<leader>2", function() require("bufferline").go_to(2, true) end, desc = "GoTo Ordinal Buffer 2", },
                { "<leader>3", function() require("bufferline").go_to(3, true) end, desc = "GoTo Ordinal Buffer 3", },
                { "<leader>4", function() require("bufferline").go_to(4, true) end, desc = "GoTo Ordinal Buffer 4", },
                { "<leader>5", function() require("bufferline").go_to(5, true) end, desc = "GoTo Ordinal Buffer 5", },
                { "<leader>6", function() require("bufferline").go_to(6, true) end, desc = "GoTo Ordinal Buffer 6", },
                { "<leader>7", function() require("bufferline").go_to(7, true) end, desc = "GoTo Ordinal Buffer 7", },
                { "<leader>8", function() require("bufferline").go_to(8, true) end, desc = "GoTo Ordinal Buffer 8", },
                { "<leader>9", function() require("bufferline").go_to(9, true) end, desc = "GoTo Ordinal Buffer 9", },
                { "<leader><", function() require("bufferline").move(-1) end,       desc = "Move buffer to the left", },
                { "<leader>>", function() require("bufferline").move(1) end,        desc = "Move buffer to the right", },
            },
            -- stylua: ignore end
            opts = {
                options = {
                    themable = true,
                    numbers = function(opts)
                        return string.format("%s%s", opts.id, opts.raise(opts.ordinal))
                    end,
                    diagnostics = "nvim_lsp",
                    indicator = {
                        icon = "█",
                        style = "icon",
                    },
                    show_buffer_close_icons = false,
                    separator_style = { "", "" },
                    diagnostics_indicator = function(count, level)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end,
                },
            },
        },

    },
    {
        -- https://github.com/nvim-lualine/lualine.nvim
        "nvim-lualine/lualine.nvim",
        dependencies = {
            { "Civitasv/cmake-tools.nvim" },
            -- { "MagicDuck/grug-far.nvim" },
            { "hedyhli/outline.nvim" },
            { "lewis6991/gitsigns.nvim" },
            { "mbbill/undotree" },
            { "mfussenegger/nvim-dap" },
            { "nvim-tree/nvim-web-devicons" },
        },
        event = "VeryLazy",
        init = function()
            vim.opt.fillchars = {
                stl = "─",
                stlnc = "─",
            }
        end,
        opts = {
            extensions = { "quickfix", "trouble", "overseer" },
            options = {
                component_separators = "",
                section_separators = "",
                theme = "onedark",
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        on_click = function(n, mouse)
                            if (n == 1) and (mouse == "l") then
                                Snacks.picker.help()
                            end
                        end,
                    },
                },
                lualine_b = cmake_line(),
                lualine_c = {
                    {
                        function()
                            return "█"
                        end,
                        color = { fg = colors.blue },
                        padding = { left = 0, right = 1 }, -- We don't need space before this
                        on_click = function(n, mouse)
                            if (n == 1) and (mouse == "l") then
                                Snacks.terminal.toggle()
                            end
                        end,
                    },
                    {
                        "o:encoding",
                        fmt = string.upper,
                        cond = conditions.hide_in_width,
                        color = { fg = colors.green, gui = "bold" },
                        on_click = function(n, mouse)
                            if (n == 1) and (mouse == "l") then
                                -- require("grug-far").open({ transient = true })
                            end
                        end,
                    },
                    {
                        function()
                            local msg = ""
                            local clients = vim.lsp.get_clients()
                            if next(clients) == nil then
                                return msg
                            end
                            local ftype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                            for _, client in ipairs(clients) do
                                local filetypes = client.config.filetypes
                                if filetypes and vim.fn.index(filetypes, ftype) ~= -1 then
                                    return client.name
                                end
                            end
                            return msg
                        end,
                        icon = "󰡱",
                        color = { fg = colors.white },
                        on_click = function(n, mouse)
                            if (n == 1) and (mouse == "l") then
                                require("outline").open()
                            end
                        end,
                    },
                    {
                        "%=",
                    },
                    {
                        "branch",
                        icon = "",
                        color = { fg = colors.violet, gui = "bold" },
                        on_click = function(n, mouse)
                            if (n == 1) and (mouse == "l") then
                                require("snacks.lazygit").open()
                            end
                        end,
                    },
                    {
                        "diff",
                        symbols = { added = " ", modified = "󰝤 ", removed = " " },
                        diff_color = {
                            added = { fg = colors.green },
                            modified = { fg = colors.orange },
                            removed = { fg = colors.red },
                        },
                        cond = conditions.hide_in_width,
                        on_click = function(n, mouse)
                            if (n == 1) and (mouse == "l") then
                                require("gitsigns").blame()
                            end
                        end,
                    },
                },
                lualine_x = {
                    {
                        "filesize",
                        cond = conditions.buffer_not_empty,
                    },
                    { "progress", color = { fg = colors.fg, gui = "bold" } },
                    { "location" },
                },
                lualine_y = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = { error = " ", warn = " ", info = " " },
                        diagnostics_color = {
                            color_error = { fg = colors.red },
                            color_warn = { fg = colors.yellow },
                            color_info = { fg = colors.cyan },
                        },
                        on_click = function(n, mouse)
                            if (n == 1) and (mouse == "l") then
                                vim.cmd("Trouble diagnostics toggle")
                            end
                        end,
                    },
                    {
                        "overseer",
                        on_click = function(n, mouse)
                            if (n == 1) and (mouse == "l") then
                                vim.cmd("OverseerToggle")
                            end
                        end,
                    },
                },
                lualine_z = {
                    {
                        "filename",
                        cond = conditions.buffer_not_empty,
                        color = { gui = "bold" },
                        on_click = function(n, mouse)
                            if (n == 1) and (mouse == "l") then
                                vim.cmd("UndotreeToggle")
                            end
                        end,
                    },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = { { "filesize" }, { "progress" }, { "location" }, { "filename" } },
                lualine_z = {},
            },
        },
    },
}
