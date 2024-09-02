require("jackdaw.postfix").add(function()
	local layers = require("layers").setup({})
	local mode = layers.mode.new()

	mode:auto_show_help()

	vim.keymap.set("n", "<leader>r", function()
		mode.window.config.title = "Refactor Mode"
		mode:activate()
	end, { desc = "Refactor Mode" })

	mode:keymaps({
		n = {
			{
				"n",
				function()
					vim.diagnostic.goto_next()
				end,
				{ desc = "Next diagnostic" },
			},
			{
				"p",
				function()
					vim.diagnostic.goto_prev()
				end,
				{ desc = "Previous diagnostic" },
			},
			{
				"w",
				"gww",
				{ desc = "Format comments" },
			},
			{
				"q",
				function()
					mode:deactivate()
				end,
				{ desc = "quit" },
			},
		},
	})

	local debug_mode = layers.mode.new()
	debug_mode:auto_show_help()

	vim.keymap.set("n", "<leader>dd", function()
		debug_mode.window.config.title = "Debug Mode"
		debug_mode:activate()
	end, { desc = "Refactor Mode" })

	debug_mode:keymaps({
		n = {
			{
				"c",
				function()
					require("dap").continue()
				end,
				{ desc = "Continue" },
			},
			{
				"b",
				function()
					require("dap").toggle_breakpoint()
				end,
				{ desc = "Toggle breakpoint" },
			},
			{
				"i",
				function()
					require("dap").step_into()
				end,
				{ desc = "DAP Step into" },
			},
			{
				"o",
				function()
					require("dap").step_over()
				end,
				{ desc = "DAP Step over" },
			},
			{
				"u",
				function()
					require("dapui").toggle()
				end,
				{ desc = "DAP Toggle UI" },
			},
			{
				"t",
				function()
					require("neotest").run.run()
				end,
				{ desc = "Run nearest test" },
			},
			{
				"T",
				function()
					require("neotest").run.run({ strategy = "dap" }) ---@diagnostic disable-line: missing-fields
				end,
				{ desc = "Debug nearest test" },
			},
			{
				"f",
				function()
					require("neotest").run.run()
				end,
				{ desc = "Run all tests" },
			},
			{
				"F",
				function()
					require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) ---@diagnostic disable-line: missing-fields
				end,
				{ desc = "Debug all tests" },
			},
			{
				"s",
				function()
					require("neotest").summary.toggle() ---@diagnostic disable-line: missing-fields
				end,
				{ desc = "Test Summary Toggle" },
			},
			{
				"q",
				function()
					debug_mode:deactivate()
				end,
				{ desc = "quit" },
			},
		},
	})
end)

return {
	{
		"debugloop/layers.nvim",
		opts = {}, -- see :help Layers.config
	},
}
