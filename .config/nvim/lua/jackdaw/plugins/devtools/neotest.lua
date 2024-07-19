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
	require("neotest").setup({ ---@diagnostic disable-line: missing-fields
		adapters = {
			require("neotest-python"),
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
