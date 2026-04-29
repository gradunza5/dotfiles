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
}
