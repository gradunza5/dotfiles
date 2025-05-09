return {
    {
        -- https://github.com/Saghen/blink.cmp
        "saghen/blink.cmp",
        enabled = true,
        version = "*",

        ---@module "blink.cmp"
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "super-tab", -- { "default", "super-tab" "enter" }
            },

            completion = {
                keyword = { range = "full" },
                -- Show documentation when selecting a completion item
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                menu = { auto_show = true },
                ghost_text = { enabled = false },
            },

            appearance = {
                -- Useful for when your theme doesn't support blink.cmp
                use_nvim_cmp_as_default = true,
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
                default = { "lsp", "path", "snippets", "markdown" }, --"buffer" },
                providers = {
                    snippets = {
                        opts = {
                            search_paths = {
                                vim.fn.getcwd() .. "/.vscode",
                                vim.fn.stdpath("config") .. "/snippets",
                            },
                        },
                    },
                    markdown = {
                        name = "RenderMarkdown",
                        module = "render-markdown.integ.blink",
                        fallbacks = { "lsp" },
                    },
                },
            },

            signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
    },
    {
        -- https://github.com/nvimtools/none-ls.nvim
        "nvimtools/none-ls.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        config = function(_, _)
            local null_ls = require("null-ls")
            local sources = {
                null_ls.builtins.diagnostics.cppcheck,
                null_ls.builtins.diagnostics.mypy,
                null_ls.builtins.diagnostics.pylint,
                null_ls.builtins.formatting.gersemi,
                null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", "2", "-ci" } }),
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.yamlfix,
                null_ls.builtins.completion.tags,
            }
            null_ls.setup({ sources = sources })
        end,
    },
    {
        -- https://github.com/danymat/neogen
        "danymat/neogen",
        version = "*",
        keys = {
            {
                "<leader>KK",
                function()
                    require("neogen").generate()
                end,
                desc = "Generate docstring comment",
            },
        },
        opts = {
            snippet_engine = "nvim",
            insert_after_comment = true,
            binsert_after_comment = true,
            languages = {
                ["python"] = {
                    template = {
                        annotation_convention = "numpydoc",
                    },
                },
            },
        },
    },
    {
        -- https://github.com/Civitasv/cmake-tools.nvim/blob/master/docs/all_commands.md
        "Civitasv/cmake-tools.nvim",
        dependencies = {
            { "mfussenegger/nvim-dap" },
            { "nvim-lua/plenary.nvim" },
        },
        ft = { "cmake", "c", "cpp" },
        opts = {
            cmake_regenerate_on_save = false,
            cmake_executor = {
                name = "overseer",
                opts = {
                    ---@class overseer.TaskDefinition
                    new_task_opts = {
                        name = "cmake build",
                        components = {
                            { "default" },
                            { "on_output_parse",      problem_matcher = "$gcc" },
                            { "on_result_diagnostics" },
                        },
                    },
                    ---@param overseer.Task
                    on_new_task = function(task)
                        require("overseer").open({ enter = false, direction = "bottom" })
                    end,
                },
            },
        },
        keys = {
            { "<F7>",        "<cmd>CMakeBuild<CR>",              desc = "CMake Build" },
            { "<leader>cmb", "<cmd>CMakeBuild<CR>",              desc = "CMake Build" },
            { "<leader>cmt", "<cmd>CMakeSelectBuildTarget<CR>",  desc = "CMake Launch Target" },
            { "<leader>cmT", "<cmd>CMakeSelectLaunchTarget<CR>", desc = "CMake Launch Target" },
            { "<leader>cmd", "<cmd>CMakeDebug<CR>",              desc = "CMake Debug" },
            { "<leader>cmr", "<cmd>CMakeRun<CR>",                desc = "CMake Run" },
            { "<C-S-F5>",    "<cmd>CMakeRun<CR>",                desc = "CMake Run" },
        },
    },
    {
        -- https://github.com/MTDL9/vim-log-highlighting
        "MTDL9/vim-log-highlighting",
        ft = { "log" },
    },
}
