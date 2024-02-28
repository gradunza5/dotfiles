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
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                event = "VeryLazy",
                dependencies = {
                    { "saadparwaiz1/cmp_luasnip" },
                    { "rafamadriz/friendly-snippets" }, -- adds friendly snippets
                }
            },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-buffer" },
            { "pontusk/cmp-vimwiki-tags" }, -- for tag completion
            { "FelipeLema/cmp-async-path" },
        },
        -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp
        config = function()
            require("lsp-zero.cmp").extend()
            local cmp = require("cmp")
            local cmp_action = require("lsp-zero.cmp").action()

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },

                mapping = {
                    -- safely use <CR> for cmp selection
                    -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr
                    ["<CR>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                        -- disabled because otherwise it would automatically complete on command
                        -- line for e.g. `:q` or `:w` to e.g. `:qa` or 1:wa`
                        -- c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    }),
                    ["<TAB>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                },
                sources = cmp.config.sources({
                        { name = 'nvim_lsp' },   -- default lsp source
                        { name = 'async_path' }, -- async system paths
                        { name = 'luasnip' },
                    },
                    {
                        { name = 'buffer' }
                    })
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!', 'q' }
                        }
                    }
                })
            })

            cmp.setup.filetype({ 'lua' }, {
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'luasnip' },
                    { name = 'async_path' }, -- async system paths
                }, {
                    { name = 'buffer' },
                })
            })

            cmp.setup.filetype({ 'markdown', 'md', 'vimwiki' }, {
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vimwiki-tags' },
                    { name = 'async_path' }, -- async system paths
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                })
            })
        end
    },

    -- https://github.com/neovim/nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        cmd = "LspInfo",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "williamboman/mason-lspconfig.nvim" },
            { "williamboman/mason.nvim" },
            { "nvim-telescope/telescope.nvim" },
            { "j-hui/fidget.nvim" },
            { "folke/neodev.nvim" }
        },
        config = function()
            require("fidget").setup({
                notification = {
                    window = {
                        winblend = 00 -- transparent background
                    }
                },
                integration = {
                    ["nvim-tree"] = {
                        -- disabled this because Fidget would error every time nvim-tree opened
                        enable = false,
                    },
                },
            })

            -- Formatting
            vim.api.nvim_create_user_command("Fmt", format, {})

            -- Keybindings ":h lsp-zero-keybindings"
            local lsp = require("lsp-zero")
            local telescope = require("telescope.builtin")
            lsp.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr }
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "?", vim.lsp.buf.hover, opts)

                vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action,
                    vim.tbl_extend("force", opts, { desc = "Code action" }))
                vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration,
                    vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
                vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition,
                    vim.tbl_extend("force", opts, { desc = "Go to definition" }))
                vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation,
                    vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
                vim.keymap.set("n", "<Leader>go", vim.lsp.buf.type_definition,
                    vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
                vim.keymap.set("n", "<leader>gr", telescope.lsp_references,
                    { buffer = true, desc = "Go to references" })

                vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("i", "<C-H>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<F2>", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                -- Diagnostics
                vim.keymap.set("n", "]d", vim.diagnostic.goto_prev,
                    vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }))
                vim.keymap.set("n", "[d", vim.diagnostic.goto_next,
                    vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }))
                vim.keymap.set("n", "gl", vim.diagnostic.open_float,
                    vim.tbl_extend("force", opts, { desc = "Open diagnostics window" }))

                local diagnostics_active = true
                vim.keymap.set('n', '<leader>d', function()
                    diagnostics_active = not diagnostics_active
                    if diagnostics_active then
                        vim.diagnostic.show()
                    else
                        vim.diagnostic.hide()
                    end
                end, opts)

                vim.diagnostic.config({
                    update_in_insert = true,
                    float = {
                        focusable = false,
                        style = "minimal",
                        border = "rounded",
                        source = "always",
                        header = "",
                        prefix = "",
                    },
                    virtual_text = true,
                })

                lsp.buffer_autoformat()
            end)

            lsp.format_on_save({
                servers = {
                    --['lua_ls'] = { 'lua' },
                }
            })

            -- Language Server Config: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
            lspconfig.bashls.setup({ capabilities = capabilities })
            lspconfig.neocmake.setup({ capabilities = capabilities })
            lspconfig.pyright.setup({ capabilities = capabilities })
            lspconfig.omnisharp.setup({ capabilities = capabilities })
            lspconfig.clangd.setup({ capabilities = capabilities })
            lspconfig.yamlls.setup({ capabilities = capabilities })
            lspconfig.marksman.setup({
                filetypes = { "markdown", "md", "vimwiki" },
                single_file_support = false,
                capabilities = capabilities,
            })
            lspconfig.tsserver.setup({ capabilities = capabilities })

            lsp.setup()
        end
    },
}
