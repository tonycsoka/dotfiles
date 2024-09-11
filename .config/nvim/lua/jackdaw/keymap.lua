vim.keymap.set("n", " ", "<Nop>", { silent = true })

vim.keymap.set("v", ">", ">gv2l")
vim.keymap.set("v", "<", "<gv2h")
vim.keymap.set("n", ">", ">>2l")
vim.keymap.set("n", "<", "<<2h")

vim.keymap.set("n", "<leader>c", "<cmd>bd<cr>", { desc = "Close current buffer" })

vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Move left" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Move right" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Move down" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Move up" })
vim.keymap.set("n", "<cr>", "<c-w>w", { desc = "Next split" })

-- need to move the rest out

vim.keymap.set("x", "<leader>/", ":Commentary<cr>")
vim.keymap.set("v", "<leader>/", ":Commentary<cr>")
vim.keymap.set("n", "<leader>/", ":Commentary<cr>")

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<leader>sl", require("auto-session.session-lens").search_session, { noremap = true })
