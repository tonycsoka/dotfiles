vim.keymap.set("n", "<space>", "<Nop>", { desc = "Ignore space", silent = true })

vim.keymap.set("x", ">", ">gv2l", { desc = "Add Indent" })
vim.keymap.set("x", "<", "<gv2h", { desc = "Remove Indent" })
vim.keymap.set("n", ">", ">>2l", { desc = "Add Indent" })
vim.keymap.set("n", "<", "<<2h", { desc = "Remove Indent" })

vim.keymap.set("x", "<c-m-j>", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
vim.keymap.set("x", "<c-m-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up" })
vim.keymap.set("n", "<c-m-j>", ":m .+1<CR>==", { desc = "move line down" })
vim.keymap.set("n", "<c-m-k>", ":m .-2<CR>==", { desc = "move line up" })

vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Move left (split)" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Move right (split)" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Move down (split)" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Move up (split)" })
vim.keymap.set("n", "<cr>", "<c-w>w", { desc = "Cycle splits" })

vim.keymap.set("n", "Q", "@qj", { desc = "Last macro with down" })
vim.keymap.set("x", "Q", ":norm @q<cr>", { desc = "Last macro norm" })
