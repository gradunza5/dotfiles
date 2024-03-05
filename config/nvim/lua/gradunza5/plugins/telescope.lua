-- https://github.com/nvim-telescope/telescope.nvim
return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    event = "VeryLazy",
    keys = {
        {
            "<leader>fv",
            function()
                require("telescope.builtin").git_files()
            end,
            desc = "Find Git Files",
        },
        {
            "<leader>lr",
            function()
                require("telescope.builtin").lsp_references()
            end,
            desc = "Find References",
        },
        {
            "<leader>li",
            function()
                require("telescope.builtin").lsp_incoming_calls()
            end,
            desc = "Find Incoming Calls",
        },
        {
            "<leader>lo",
            function()
                require("telescope.builtin").lsp_outgoing_calls()
            end,
            desc = "Find Outgoing Calls",
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build =
            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
        require("telescope").setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                },
                file_ignore_patterns = {
                    ".git/",
                },
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                }
            }
        })
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("ui-select")

        -- See `:help telescope.builtin`
        local builtin = require("telescope.builtin")
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
        vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
        vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
        vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
        vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = '[F]ind [M]arks' })
        vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = '[F]ind [C]ommands' })
        vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

        vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

        -- Also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        vim.keymap.set('n', '<leader>f/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end, { desc = '[F]ind [/] in Open Files' })

        -- Shortcut for searching your neovim configuration files
        vim.keymap.set('n', '<leader>fn', function()
            builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end, { desc = '[F]ind [N]eovim files' })
    end,
}
