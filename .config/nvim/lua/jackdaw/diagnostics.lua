vim.diagnostic.config({
	float = { border = "rounded" },
	virtual_lines = { current_line = true },
	virtual_text = { current_line = false },

	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = "󰋼 ",
			[vim.diagnostic.severity.HINT] = "󰌵 ",
		},
	},
})

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk", { bg = "none", ctermbg = "none" })
