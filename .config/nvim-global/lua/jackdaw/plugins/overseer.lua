require("jackdaw.postfix").add(function()
	require("overseer").setup({})
	vim.keymap.set("n", "<leader>tr", "<cmd>OverseerRun<cr>", {
		desc = "Run task",
	})
	vim.keymap.set("n", "<leader>tt", "<cmd>OverseerToggle<cr>", {
		desc = "Run task",
	})
end)

return {
	"stevearc/overseer.nvim",
	opts = {},
}
