return {
	"stevearc/overseer.nvim",
	config = function()
		require("overseer").setup()
	end,
	keys = {
		{
			"<leader>tr",
			"<cmd>OverseerRun<cr>",
			desc = "Run task",
		},
		{
			"<leader>tt",
			"<cmd>OverseerToggle<cr>",
			desc = "Run task",
		},
	},
}
