return {
    -- https://github.com/bullets-vim/bullets.vim
    {
        "bullets-vim/bullets.vim",
        init = function()
            -- vim.g.bullets_outline_levels = {'ROM', 'ABC', 'num', 'abc', 'rom', 'std-'},
        end
    },
    {
        -- https://github.com/MeanderingProgrammer/render-markdown.nvim
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-treesitter/nvim-treesitter",
        },
        -- stylua: ignore start
        keys = {
            { "<leader>MR", function() require("render-markdown").toggle() end, desc = "MarkdownRender Toggle" },
        },
        -- stylua: ignore end
        ---@module "render-markdown"
        ---@type render.md.UserConfig
        opts = {
            latex = {
                enabled = false,
            },
        },
        ft = { "markdown", "md" },
    },
    {
        -- https://github.com/iamcco/markdown-preview.nvim
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        keys = {
            { "<leader>MP", "<cmd>MarkdownPreview<CR>",       desc = "MarkdownPreview" },
            { "<leader>MS", "<cmd>MarkdownPreviewStop<CR>",   desc = "MarkdownPreviewStop" },
            { "<leader>MT", "<cmd>MarkdownPreviewToggle<CR>", desc = "MarkdownPreviewToggle" },
        },
        init = function()
            vim.g.mkdp_filetypes = { "markdown", "md" }
        end,
        ft = { "markdown", "md" },
    }
}
