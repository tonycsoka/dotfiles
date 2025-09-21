return {
	{
		"mfussenegger/nvim-dap",
	},
	{
		"mfussenegger/nvim-dap-python",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("dap")
			local python_path = table
				.concat({ vim.fn.stdpath("data"), "mason", "packages", "debugpy", "venv", "bin", "python" }, "/")
				:gsub("//+", "/")
			require("dap-python").setup(python_path)
		end,
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = {
			"mfussenegger/nvim-dap",
			config = function()
				require("dap")
				---@diagnostic disable-next-line: missing-fields
				require("dap-vscode-js").setup({
					-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
					-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
					-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
					adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
					-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
					-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
					-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
				})

				for _, language in ipairs({ "typescript", "javascript" }) do
					require("dap").configurations[language] = {
						{
							type = "pwa-node",
							request = "launch",
							name = "Launch file",
							program = "${file}",
							cwd = "${workspaceFolder}",
						},
						{
							type = "pwa-node",
							request = "attach",
							name = "Attach",
							processId = require("dap.utils").pick_process,
							cwd = "${workspaceFolder}",
						},
						{
							type = "pwa-node",
							request = "launch",
							name = "Debug Jest Tests",
							-- trace = true, -- include debugger info
							runtimeExecutable = "node",
							runtimeArgs = {
								"./node_modules/jest/bin/jest.js",
								"--runInBand",
							},
							rootPath = "${workspaceFolder}",
							cwd = "${workspaceFolder}",
							console = "integratedTerminal",
							internalConsoleOptions = "neverOpen",
						},
					}
				end
			end,
		},
	},
	{
		"igorlfs/nvim-dap-view",
		---@module 'dap-view'
		---@type dapview.Config
		opts = {},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-dap-virtual-text").setup({
				virt_text_pos = "eol",
				all_references = true,
			})
		end,
	},
}
