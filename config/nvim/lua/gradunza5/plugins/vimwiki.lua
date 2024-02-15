-- =============================================================================
-- VimWiki
-- =============================================================================

-- https://github.com/vimwiki/vimwiki
return {
    {
        "vimwiki/vimwiki",
        version = "*",
        keys = {
            { "<leader>ww",  "<CMD>VimwikiIndex<CR>",           desc = "Vim Wiki Diary Index" },
            { "<leader>wi",  "<CMD>VimwikiDiaryIndex<CR>",      desc = "Vim Wiki Diary Index" },
            { "<leader>wd",  "<CMD>VimwikiMakeDiaryNote<CR>",   desc = "Vim Wiki Diary Today" },
            { "2<leader>ww", "<CMD>VimwikiIndex 2<CR>",         desc = "Vim Wiki Diary Index 2 " },
            { "2<leader>wi", "<CMD>VimwikiDiaryIndex 2<CR>",    desc = "Vim Wiki Diary Index 2" },
            { "2<leader>wd", "<CMD>VimwikiMakeDiaryNote 2<CR>", desc = "Vim Wiki Diary Today 2" },
            { "3<leader>ww", "<CMD>VimwikiIndex 3<CR>",         desc = "Vim Wiki Diary Index 3" },
            { "3<leader>wi", "<CMD>VimwikiDiaryIndex 3<CR>",    desc = "Vim Wiki Diary Index 3" },
            { "3<leader>wd", "<CMD>VimwikiMakeDiaryNote 3<CR>", desc = "Vim Wiki Diary Today 3" },
        },
        init = function()
            vim.keymap.set("n", "<leader>t", "<CMD>VimwikiToggleListItem<CR>")
            vim.keymap.set("v", "<leader>t", "<CMD>VimwikiToggleListItem<CR>")
            vim.keymap.set("n", "<Tab>", "<CMD>VimwikiNextLink<CR>")

            vim.g.vimwiki_hl_headers = 1
            vim.g.vimwiki_global_ext = 1
            vim.g.vimwiki_markdown_link_ext = 1
            vim.g.vimwiki_folding = "expr"
            vim.g.vimwiki_auto_chdir = 1
            vim.g.vimwiki_list = {
                { --personal wiki
                    path = "~/Drive/Drive/me/wiki",
                    path_html = "~/Drive/Drive/me/wiki/html",
                    syntax = "markdown",
                    ext = "md",
                    template_path = "~/Drive/Drive/work/me/template",
                    template_default = "default",
                    template_ext = ".tpl",
                    custom_wiki2html = "vimwiki_markdown",
                    auto_tags = 1,
                    nested_syntaxes = {
                        bash = "sh",
                        cpp = "cpp",
                        cs = "cs",
                        python = "python",
                    },
                },
                { -- work wiki
                    path = "~/Drive/Drive/work/wiki",
                    path_html = "~/Drive/Drive/work/wiki/html",
                    syntax = "markdown",
                    ext = "md",
                    template_path = "~/Drive/Drive/work/wiki/template",
                    template_default = "default",
                    template_ext = ".tpl",
                    custom_wiki2html = "vimwiki_markdown",
                    auto_tags = 1,
                    auto_diary_index = 1,
                    diary_frequency = "weekly",
                    nested_syntaxes = {
                        bash = "sh",
                        cpp = "cpp",
                        cs = "cs",
                        python = "python",
                    },
                },
                { -- D&D wiki
                    path = "~/Drive/Drive/dnd/wiki",
                    path_html = "~/Drive/Drive/dnd/wiki/html",
                    syntax = "markdown",
                    ext = "md",
                    template_path = "~/Drive/Drive/dnd/wiki/template",
                    template_default = "default",
                    template_ext = ".tpl",
                    custom_wiki2html = "vimwiki_markdown",
                    auto_tags = 1,
                },
            }
        end,
    }
}
