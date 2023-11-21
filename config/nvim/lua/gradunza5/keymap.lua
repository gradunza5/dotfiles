-- escape remap
vim.keymap.set("i", "jk", "<ESC>")

-- absolute movement
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- substitute word
vim.keymap.set("n", "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
)

-- insert newline
vim.keymap.set("v", "<leader>lf",
    [[:s/\%V/\r/]]
)

-- Move highlighted text up/down w/ shift JK
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- stay in visual when indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Cursor to Middle for PgUp/PgDown
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Cursor to Middle for next diff/prev diff
vim.keymap.set("n", "]c", "]czz")
vim.keymap.set("n", "[c", "[czz")

-- Cursor to Middle for next issue/prev issue
vim.keymap.set("n", "]d", "]dzz")
vim.keymap.set("n", "[d", "[dzz")

-- Cursor to Middle for Search Next/Previous
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste over and keep register
vim.keymap.set("x", "<leader>p", "\"_dP")

-- delete and keep register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- arrows switch buffers
vim.keymap.set("n", "<right>", ":bn<cr>")
vim.keymap.set("n", "<left>", ":bp<cr>")

-- delete buffer, keep split
vim.keymap.set("n", "<leader>q", "<CMD>bp|bd#<CR>")
--vim.keymap.set("n", "<leader>w", "<CMD>bp|bd#<CR>")

-- split movement
vim.keymap.set("n", "<C-J>", "<C-w>w", { noremap = true })
vim.keymap.set("n", "<C-K>", "<C-w>W", { noremap = true })
vim.keymap.set("n", "<C-L>", "<C-w>l", { noremap = true })
vim.keymap.set("n", "<C-H>", "<C-w>h", { noremap = true })

-- Resize Splits with Arrows
vim.keymap.set("n", "<S-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<S-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<S-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<S-Right>", ":vertical resize +2<CR>")

-- Move Splits with Shift+Arrows
vim.keymap.set("n", "<C-Left>", "<C-w><S-h>")
vim.keymap.set("n", "<C-Down>", "<C-w><S-j>")
vim.keymap.set("n", "<C-Up>", "<C-w><S-k>")
vim.keymap.set("n", "<C-Right>", "<C-w><S-l>")

-- quick formats
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- quick fix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- system copy/paste
vim.keymap.set("n", "<leader>v", "\"+gp")
vim.keymap.set("i", "<leader>v", "<esc>\"+gpa")
vim.keymap.set("v", "<leader>c", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- reload config
--local fn = require("gradunza5.functions")
--vim.keymap.set("n", "<leader>r", fn.reload.config, { silent = false })
--
--
--<BS>
--
