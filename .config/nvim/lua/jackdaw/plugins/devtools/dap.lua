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
	require("dapui").setup({ ---@diagnostic disable-line: missing-fields
		controls = { ---@diagnostic disable-line: missing-fields
			-- Requires Neovim nightly (or 0.8 when released)
			enabled = true,
			-- Display controls in this element
			element = "repl",
		},
	})
	require("nvim-dap-virtual-text").setup({
		virt_text_pos = "eol",
		all_references = true,
	})

	vim.fn.sign_define(
		"DapBreakpoint",
		{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
	)
	vim.fn.sign_define(
		"DapBreakpointCondition",
		{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
	)
	vim.fn.sign_define(
		"DapBreakpointRejected",
		{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
	)
	vim.fn.sign_define(
		"DapLogPoint",
		{ text = "󰛿", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
	)
	vim.fn.sign_define(
		"DapStopped",
		{ text = "󰁕", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
	)
end)

require("jackdaw.postfix").add_highlights(function()
	vim.api.nvim_set_hl(0, "DapUIPlayPause", { fg = "#A9FF68", bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DapUIRestart", { fg = "#A9FF68", bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DapUIStop", { fg = "#F70067", bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DapUIStepOut", { fg = "#00f1f5", bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DapUIStepBack", { fg = "#00f1f5", bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DapUIStepInto", { fg = "#00f1f5", bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DapUIStepOver", { fg = "#00f1f5", bg = "none", ctermbg = "none" })

	vim.api.nvim_set_hl(0, "DapUIPlayPauseNC", { fg = "#A9FF68", bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DapUIRestartNC", { fg = "#A9FF68", bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DapUIStopNC", { fg = "#F70067", bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DapUIStepOutNC", { fg = "#00f1f5", bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DapUIStepBackNC", { fg = "#00f1f5", bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DapUIStepIntoNC", { fg = "#00f1f5", bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DapUIStepOverNC", { fg = "#00f1f5", bg = "none", ctermbg = "none" })

	vim.api.nvim_set_hl(0, "DapUIUnavailable", { fg = "#424242", bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DapUIUnavailableNC", { fg = "#424242", bg = "none", ctermbg = "none" })
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
	{ "theHamsta/nvim-dap-virtual-text" },
}
