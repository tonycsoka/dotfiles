require("jackdaw.postfix").add(function()
	vim.keymap.set("n", "<leader>dt", function()
		require("neotest").run.run()
	end, { desc = "Run nearest test" })

	vim.keymap.set("n", "<leader>dT", function()
		require("neotest").run.run({ strategy = "dap" }) ---@diagnostic disable-line: missing-fields
	end, { desc = "Debug nearest test" })

	vim.keymap.set("n", "<leader>df", function()
		require("neotest").run.run()
	end, { desc = "Run all tests" })

	vim.keymap.set("n", "<leader>dF", function()
		require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) ---@diagnostic disable-line: missing-fields
	end, { desc = "Debug all tests" })

	vim.keymap.set("n", "<leader>ds", function()
		require("neotest").summary.toggle() ---@diagnostic disable-line: missing-fields
	end, { desc = "Test Summary Toggle" })

	require("neotest").setup({ ---@diagnostic disable-line: missing-fields
		adapters = {
			require("neotest-python"),
		},
		summary = { ---@diagnostic disable-line: missing-fields
			open = "botright vsplit | vertical resize 30",
		},
	})
end)

return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"nvim-neotest/neotest-python",
		dependencies = {
			"nvim-neotest/neotest",
		},
	},
}
