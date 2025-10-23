return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local debug_path = table
				.concat({
					vim.fn.stdpath("data"),
					"mason",
					"packages",
					"js-debug-adapter",
					"js-debug",
					"src",
					"dapDebugServer.js",
				}, "/")
				:gsub("//+", "/")
			local adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }
			for _, adapter in ipairs(adapters) do
				require("dap").adapters[adapter] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "node",
						-- 💀 Make sure to update this path to point to your installation
						args = { debug_path, "${port}" },
					},
				}
			end

			for _, language in ipairs({ "typescript", "typescriptreact", "javascript", "javascriptreact" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}/src",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}/src",
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
						cwd = "${workspaceFolder}/src",
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
					},
					{
						-- type = "pwa-chrome",
						-- name = "Attach - Remote Debugging",
						-- request = "attach",
						-- program = "${file}",
						--       url =
						-- cwd = vim.fn.getcwd(),
						-- sourceMaps = true,
						-- protocol = "inspector",
						-- port = 9222,
						-- webRoot = "${workspaceFolder}/src",

						type = "pwa-chrome",
						request = "launch",
						-- name of the debug action
						name = "Launch Chrome to debug client side code",
						-- default vite dev server url
						url = "http://localhost:5173",
						-- for TypeScript/Svelte
						sourceMaps = true,
						webRoot = "${workspaceFolder}/src",
						protocol = "inspector",
						port = 9222,
						-- skip files from vite's hmr
						skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
					},
					{
						type = "pwa-chrome",
						name = "Launch Chrome",
						request = "launch",
						url = "http://localhost:3000",
					},
				}
			end
		end,
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
