-- https://github.com/L3MON4D3/LuaSnip
return {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",

    event = "VeryLazy",

    config = function()
        local ls = require("luasnip")
        local types = require("luasnip.util.types")

        local s = ls.snippet
        local sn = ls.snippet_node
        local isn = ls.indent_snippet_node
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node
        local c = ls.choice_node
        local d = ls.dynamic_node
        local r = ls.restore_node

        -- format string
        local fmt = require("luasnip.extras.fmt").fmt

        -- repeats a node
        -- rep(<position>)
        local rep = require("luasnip.extras").rep

        ls.setup({
            history = true,
            updateevents = "TextChanged, TextChangedI",

            -- maybe turn me off?
            enable_autosnippets = true,

            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { "<-", "Error" } },
                    }
                }
            }
        })

        -- <c-j> is my expansion key
        -- this will expand the current item or jump to the next item within the snippet.
        vim.keymap.set({ "i", "s" }, "<c-j>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { silent = true })

        -- <c-k> is my jump backwards key.
        -- this always moves to the previous item within the snippet
        vim.keymap.set({ "i", "s" }, "<c-k>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, { silent = true })

        -- <c-l> is selecting within a list of options.
        -- This is useful for choice nodes (introduced in the forthcoming episode 2)
        vim.keymap.set("i", "<c-l>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end)

        vim.keymap.set("i", "<c-u>", require "luasnip.extras.select_choice")

        -- shorcut to source my luasnips file again, which will reload my snippets
        vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/gradunza5/plugins/luasnip.lua<CR>")

        -- SNIPPET DEFINITION
        -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
        -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#snippets
        -- https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua

        ls.add_snippets("all", {
            s("req", fmt("local {} = require('{}')", { i(1), rep(1) })),
        })

        ls.add_snippets("vimwiki", {
            -- s("link", {
            --     t({ "[" }), i(1),
            --     t({ "](" }), i(2),
            --     t(")"), i(0)
            -- }),
            s("link",
                fmt("[{}]({})", { i(1, "title"), i(2, "url") }), -- formatter for the link itself
                i(0)                                             -- ending insert node so we can c-j out
            ),
            s("task",
                fmt("- [ ] {}", { i(0, "task") }),
                i(0) -- ending insert node so we can c-j out
            ),
        })
    end,
}
