return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({ ---@diagnostic disable-line: redundant-parameter
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"mypy", -- python linter
				"ruff", -- python linter / formatter
				"eslint_d", -- js linter
				"typescript-language-server", -- typescript lsp
				"pyright", -- python lsp
				"basedpyright", -- python lsp
				"clangd", -- c family lsp
				"lua_ls", -- lua lsp
				"debugpy", -- python dap
				"codelldb", -- c family debugger
				"sourcery", -- multi language AI code actions
			},
		})
	end,
}
