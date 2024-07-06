vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("x", "<leader>/", ":Commentary<cr>", { remap = true })
vim.keymap.set("v", "<leader>/", ":Commentary<cr>", { remap = true })
vim.keymap.set("n", "<leader>/", "<cmd>Commentary<cr>", { remap = true })
