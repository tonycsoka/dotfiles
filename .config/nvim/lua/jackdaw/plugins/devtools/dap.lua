return {
	{ "mfussenegger/nvim-dap" },
	{
		"mfussenegger/nvim-dap-python",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
	},
}
