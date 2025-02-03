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
                    vim.tbl_extend("force", opts, { desc = "[C]ode [A]ction" }))
                vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration,
                    vim.tbl_extend("force", opts, { desc = "[G]o to [D]eclaration" }))
                vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition,
                    vim.tbl_extend("force", opts, { desc = "[G]o to [d]efinition" }))
                vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation,
                    vim.tbl_extend("force", opts, { desc = "[G]o to [i]mplementation" }))
                vim.keymap.set("n", "<Leader>go", vim.lsp.buf.type_definition,
                    vim.tbl_extend("force", opts, { desc = "[G]o to type definition" }))
                vim.keymap.set("n", "<leader>gr", telescope.lsp_references,
                    { buffer = true, desc = "[G]o to [R]eferences" })

                vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("i", "<C-H>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<F2>", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
                    vim.tbl_extend("force", opts, { desc = "[R]e[n]ame" }))

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

                -- The following two autocommands are used to highlight references of the
                -- -- word under your cursor when your cursor rests there for a little while.
                -- --    See `:help CursorHold` for information about when this is executed
                -- --
                -- -- When you move your cursor, the highlights will be cleared (the second autocommand).
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = bufnr,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = bufnr,
                        callback = vim.lsp.buf.clear_references,
                    })
                end


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

            lspconfig.lua_ls.setup(lsp.nvim_lua_ls({
                -- settings block pulled from kickstart.nvim
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        workspace = {
                            checkThirdParty = false,
                            -- Tells lua_ls where to find all the Lua files that you have loaded
                            -- for your neovim configuration.
                            library = {
                                '${3rd}/luv/library',
                                unpack(vim.api.nvim_get_runtime_file('', true)),
                            },
                            -- If lua_ls is really slow on your computer, you can try this instead:
                            -- library = { vim.env.VIMRUNTIME },
                        },
                        completion = {
                            callSnippet = 'Replace',
                        },
                        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                        -- diagnostics = { disable = { 'missing-fields' } },
                    },
                },
            }))

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
                on_init = function(client)
                    -- client.server_capabilities.documentFormattingProvider = false,
                    -- client.server_capabilities.documentFormattingRangeProvider = false,
                end,
            })
            lspconfig.ts_ls.setup({ capabilities = capabilities })

            lsp.setup()
        end
    },
}
