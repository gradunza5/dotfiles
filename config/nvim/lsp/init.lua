-- https://neovim.io/doc/user/lsp.html
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
--
-- Use `:lua vim.cmd('edit '..vim.lsp.get_log_path())<CR>` to debug
vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  },
  root_markers = { ".git" },
})
