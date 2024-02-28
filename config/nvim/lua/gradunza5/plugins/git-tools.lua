-- https://github.com/tpope/vim-fugitive
return {
    {
        "tpope/vim-fugitive",
        event = "FileType",
        keys = {
            { "<leader>gb", "<CMD>Git blame<CR>",  desc = "Git Blame Toggle" },
            { "<leader>gs", "<CMD>Git status<CR>", desc = "Git Status Toggle" },
        },
        config = function()
            vim.keymap.set("n", "<Leader>tt", "<CMD>diffg //2<CR>",
                { desc = "Git merge tool : Take from Target (left buffer)" })

            vim.keymap.set("n", "<Leader>tm", "<CMD>diffg //3<CR>",
                { desc = "Git merge tool : Take from Merge (right buffer)" })
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup {
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, desc)
                        local opts = { buffer = bufnr, desc = desc }
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    -- Actions
                    map('n', '<leader>hs', gs.stage_hunk, "Stage Hunk")
                    map('n', '<leader>hr', gs.reset_hunk, "Reset Hunk")
                    map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        "Stage Hunk")
                    map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        "Reset Hunk")
                    map('n', '<leader>hS', gs.stage_buffer, "Stage Buffer")
                    map('n', '<leader>hu', gs.undo_stage_hunk, "Undo Stage Hunk")
                    map('n', '<leader>hR', gs.reset_buffer, "Reset Buffer")
                    map('n', '<leader>hp', gs.preview_hunk, "Preview Hunk")
                    map('n', '<leader>hb', function() gs.blame_line { full = true } end, "Blame Line")
                    map('n', '<leader>tb', gs.toggle_current_line_blame, "Toggle Line Blame")
                    map('n', '<leader>hd', gs.diffthis, "Diff This")
                    map('n', '<leader>hD', function() gs.diffthis('~') end, "Diff This... ~")
                    map('n', '<leader>td', gs.toggle_deleted, "Toggle Deleted")

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
            }
        end
    }
}
