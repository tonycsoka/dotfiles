return {
	"stevearc/overseer.nvim",
	lazy = false,
	version = "1.6.0",
	opts = {
		log_level = vim.log.levels.TRACE,
	},
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
	dependencies = {
		"mfussenegger/nvim-dap",
	},
}
