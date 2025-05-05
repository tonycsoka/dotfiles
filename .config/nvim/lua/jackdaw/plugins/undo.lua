return {
	{
		"y3owk1n/time-machine.nvim",
		version = "*", -- remove this if you want to use the `main` branch
		opts = {
			diff_tool = "delta",
		},
		keys = {
			{
				"<leader>u",
				"<cmd>TimeMachineToggle<cr>",
				desc = "[Time Machine] Toggle Tree",
			},
		},
	},
}
