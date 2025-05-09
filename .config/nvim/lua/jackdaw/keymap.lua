vim.keymap.set("n", " ", "<Nop>", { silent = true })

vim.keymap.set("v", ">", ">gv2l")
vim.keymap.set("v", "<", "<gv2h")
vim.keymap.set("n", ">", ">>2l")
vim.keymap.set("n", "<", "<<2h")

vim.keymap.set("v", "<c-m-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<c-m-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<c-m-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<c-m-k>", ":m .-2<CR>==")

vim.keymap.set("n", "<leader>c", "<cmd>bd<cr>", { desc = "Close current buffer" })

vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Move left (split)" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Move right (split)" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Move down (split)" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Move up (split)" })
vim.keymap.set("n", "<cr>", "<c-w>w", { desc = "Cycle splits" })
