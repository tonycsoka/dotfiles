require("jackdaw.postfix").add(function()
	vim.keymap.set("n", "<leader>db", function()
		require("dap").toggle_breakpoint()
	end, { desc = "DAP Toggle breakpoint" })
	vim.keymap.set("n", "<leader>dc", function()
		require("dap").continue()
	end, { desc = "DAP Continue" })
	vim.keymap.set("n", "<leader>di", function()
		require("dap").step_into()
	end, { desc = "DAP Step into" })
	vim.keymap.set("n", "<leader>do", function()
		require("dap").step_over()
	end, { desc = "DAP Step over" })
	vim.keymap.set("n", "<leader>du", function()
		require("dapui").toggle()
	end, { desc = "DAP Toggle UI" })

	local python_path = table
		.concat({ vim.fn.stdpath("data"), "mason", "packages", "debugpy", "venv", "bin", "python" }, "/")
		:gsub("//+", "/")
	require("dap-python").setup(python_path)
	require("dapui").setup({
		controls = {
			-- Requires Neovim nightly (or 0.8 when released)
			enabled = true,
			-- Display controls in this element
			element = "repl",
		},
	})
end)

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
