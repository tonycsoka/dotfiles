vim.keymap.set("n", "<space>", "<Nop>", { desc = "Ignore space", silent = true })

vim.keymap.set("x", ">", ">gv2l", { desc = "Add Indent" })
vim.keymap.set("x", "<", "<gv2h", { desc = "Remove Indent" })
vim.keymap.set("n", ">", ">>2l", { desc = "Add Indent" })
vim.keymap.set("n", "<", "<<2h", { desc = "Remove Indent" })

vim.keymap.set("x", "<c-m-j>", "<cmd>m '>+1<CR>gv=gv", { desc = "Move block down" })
vim.keymap.set("x", "<c-m-k>", "<cmd>m '<-2<CR>gv=gv", { desc = "Move block up" })
vim.keymap.set("n", "<c-m-j>", "<cmd>m .+1<CR>==", { desc = "move line down" })
vim.keymap.set("n", "<c-m-k>", "<cmd>m .-2<CR>==", { desc = "move line up" })

vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Move left (split)" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Move right (split)" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Move down (split)" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Move up (split)" })
vim.keymap.set("n", "<cr>", "<c-w>w", { desc = "Cycle splits" })

vim.keymap.set("n", "Q", "@qj", { desc = "Last macro with down" })
vim.keymap.set("x", "Q", "<cmd>norm @q<cr>", { desc = "Last macro norm" })

vim.keymap.set("n", "<leader>ju", function()
	local prompt = "Give me a markdown summary, Jira comment style, of the changes today. Make it consise, and output only final markdown"
	local on_exit = function(obj)
		vim.schedule(function()
			local lines = vim.split(obj.stdout or "", "\n")
			-- Drop the first and last lines (equivalent of `sed '1d;$d'`)
			local trimmed = table.concat(lines, "\n", 2, #lines - 1)
			require("jira-nvim").comment_from_branch(trimmed)
		end)
	end
	vim.system({ "pi", "-p", prompt }, { text = true }, on_exit)
end, { desc = "Add Jira comment update" })

vim.keymap.set("n", "<leader>jc", function()
	require("jira-nvim").comment_from_branch()
end, { desc = "Add Jira comment" })

vim.keymap.set("n", "<leader>js", function()
	require("jira-nvim").sprint()
end, { desc = "Open sprint tickets" })

vim.keymap.set("n", "<leader>jm", function()
	require("jira-nvim").sprint("assignee = currentUser()")
end, { desc = "Open my sprint tickets" })

local ls = require("luasnip")

vim.keymap.set({ "i" }, "<Tab>", function()
	ls.expand_or_jumpable()
end, { silent = true })
vim.keymap.set({ "s" }, "<Tab>", function()
	ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })
