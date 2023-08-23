-- Format hacks
local format = function()
    if vim.bo.filetype == "python" then
        -- pyright does not support formatting
        vim.cmd([[!black %]])
    else
        vim.lsp.buf.format()
    end
end

return {
    -- https://github.com/VonHeikemen/lsp-zero.nvim
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        lazy = true,
        config = function()
            require("lsp-zero.settings").preset({})
        end
    },

    -- https://github.com/hrsh7th/nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- https://github.com/L3MON4D3/LuaSnip
            { "L3MON4D3/LuaSnip" },
        },
        -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp
        config = function()
            require("lsp-zero.cmp").extend()
            local cmp = require("cmp")
            local cmp_action = require("lsp-zero.cmp").action()
            cmp.setup({
                mapping = {
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<TAB>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                },
                sources = {
                    { name = 'vimwiki-tags' }
                }
            })
        end
    },

    -- https://github.com/neovim/nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        cmd = "LspInfo",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
            { "williamboman/mason.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            -- Formatting
            vim.api.nvim_create_user_command("Fmt", format, {})

            -- Keybindings ":h lsp-zero-keybindings"
            local lsp = require("lsp-zero")
            local telescope = require("telescope.builtin")
            lsp.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr }
                vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
                -- Custom
                vim.keymap.set("n", "<F2>", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "?", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gr", telescope.lsp_references, { buffer = true })
                vim.keymap.set({ "n", "i" }, "<C-H>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set({ "n", "v" }, "<TAB>", vim.lsp.buf.code_action, opts)
            end)

            -- Language Server Config: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
            lspconfig.bashls.setup({ capabilities = capabilities })
            lspconfig.neocmake.setup({ capabilities = capabilities })
            lspconfig.pyright.setup({ capabilities = capabilities })
            lspconfig.omnisharp.setup({ capabilities = capabilities })

            lsp.setup()
        end
    }
}
