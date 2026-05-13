--@type vim.lsp.Config

-- return {
--   cmd = { "lua-language-server", },
--   filetypes = { "lua", },
--   root_markers = { ".luarc.json", ".luarc.jsonc", "init.lua", },
--   settings = {
--     Lua = {
--       workspace = {
--         library = vim.api.nvim_get_runtime_file("", true)
--       }
--     }
--   }
-- }

return {
	cmd = { "emmylua_ls" },
	filetypes = { "lua" },
	root_markers = { ".emmyrc.json", ".luarc.json", ".git" },
	settings = {
		Lua = {
			format = {
				enable = true,
			},
			runtime = {
				version = "LuaJIT",
				reqirePattern = {
					"lua/?.lua",
					"lua/?/init.lua",
					"?/lua/?.lua",
					"?/lua/?/init.lua",
				},
			},
			workspace = {
				library = {
					-- vim.api.nvim_get_runtime_file("", true),
					"$VIMRUNTIME",
					"$HOME/.dotfiles/home/.config/nvim/lua",
				},
			},
		},
	},
}
