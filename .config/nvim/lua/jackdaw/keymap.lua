vim.keymap.set("n", " ", "<Nop>", { silent = true })

vim.keymap.set("v", ">", ">gv2l")
vim.keymap.set("v", "<", "<gv2h")
vim.keymap.set("n", ">", ">>2l")
vim.keymap.set("n", "<", "<<2h")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", ":m .+1<CR>==")
vim.keymap.set("n", "K", ":m .-2<CR>==")

vim.keymap.set("n", "<leader>c", "<cmd>bd<cr>", { desc = "Close current buffer" })

vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Move left (split)" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Move right (split)" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Move down (split)" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Move up (split)" })
vim.keymap.set("n", "<cr>", "<c-w>w", { desc = "Cycle splits" })

-- need to move the rest out

vim.keymap.set("x", "<leader>/", ":Commentary<cr>")
vim.keymap.set("v", "<leader>/", ":Commentary<cr>")
vim.keymap.set("n", "<leader>/", ":Commentary<cr>")

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<leader>sl", require("auto-session.session-lens").search_session, { noremap = true })
