return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local firefox_path = table
				.concat({
					vim.fn.stdpath("data"),
					"mason",
					"packages",
					"firefox-debug-adapter",
					"dist",
					"adapter.bundle.js",
				}, "/")
				:gsub("//+", "/")

			dap.adapters.firefox = {
				type = "executable",
				command = "node",
				args = { firefox_path },
			}

			local jsdebug_path = table
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

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					-- 💀 Make sure to update this path to point to your installation
					args = { jsdebug_path, "${port}" },
				},
			}
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
