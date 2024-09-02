vim.keymap.set("n", " ", "<Nop>", { silent = true })

vim.keymap.set("v", ">", ">gv2l")
vim.keymap.set("v", "<", "<gv2h")

vim.keymap.set("n", "<leader>c", "<cmd>bd<cr>", { desc = "Close current buffer" })

-- need to move the rest out

vim.keymap.set("x", "<leader>/", ":Commentary<cr>")
vim.keymap.set("v", "<leader>/", ":Commentary<cr>")
vim.keymap.set("n", "<leader>/", ":Commentary<cr>")

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<leader>sl", require("auto-session.session-lens").search_session, { noremap = true })
