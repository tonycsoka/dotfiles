return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"williamboman/mason-lspconfig.nvim",
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
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				"flake8", -- python linter
				"mypy", -- python linter
				"eslint_d", -- js linter
				"typescript-language-server", -- ts lsp
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
