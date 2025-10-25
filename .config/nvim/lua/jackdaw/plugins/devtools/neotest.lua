return {
	{
		"nvim-neotest/neotest",
		commit = "52fca6717ef972113ddd6ca223e30ad0abb2800c",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-jest",
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
					require("neotest-jest")({
						jestCommand = "npm test --",
						jestArguments = function(defaultArguments, context)
							return defaultArguments
						end,
						jestConfigFile = "jest.config.js",
						env = { CI = true },
						cwd = function(path)
							return vim.fn.getcwd()
						end,
						isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
					}),
				},
				summary = { ---@diagnostic disable-line: missing-fields
					open = "botright vsplit | vertical resize 30",
				},
			})
		end,
	},
}
