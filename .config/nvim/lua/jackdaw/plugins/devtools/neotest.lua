return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"tonycsoka/neotest-behave",
		},
		config = function()
			require("neotest").setup({ ---@diagnostic disable-line: missing-fields
				adapters = {
					require("neotest-behave"),
					require("neotest-python")({
						dap = {
							name = "Attach",
							type = "python",
							request = "attach",
							connect = {
								host = "localhost",
								port = 5678,
							},
							pathMappings = {
								{
									localRoot = "${workspaceFolder}",
									remoteRoot = ".",
								},
							},
						},
					}),
				},
				summary = { ---@diagnostic disable-line: missing-fields
					open = "botright vsplit | vertical resize 30",
				},
			})
		end,
	},
}
