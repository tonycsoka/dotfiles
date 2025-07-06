return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			-- enable mason and configure icons
			require("mason").setup({ ---@diagnostic disable-line: redundant-parameter
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettier", -- prettier formatter
					"stylua", -- lua formatter
					"mypy", -- python linter
					"ruff", -- python linter / formatter / lsp
					"eslint_d", -- js linter
					"typescript-language-server", -- typescript lsp
					"basedpyright", -- python lsp
					"lua-language-server", -- lua lsp
					"debugpy", -- python dap
					"graphql-language-service-cli", -- graphql
					"golangci-lint-langserver", -- golang
					"golangci-lint", -- golang
					"gopls", -- golang
					"json-lsp", -- json
					"sqlls", -- sql
					"markdown-oxide", -- markdown
				},
			})

			local servers = {
				"ts_ls",
				"lua_ls",
				"graphql",
				"gopls",
				"jsonls",
				"sqlls",
				"basedpyright",
				"ruff",
				"markdown_oxide", -- markdown
			}

			for _, lsp in ipairs(servers) do
				vim.lsp.enable(lsp)
				vim.lsp.config(lsp, {})
			end

			vim.lsp.config("markdown_oxide", {
				capabilities = {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
			})

			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						-- Pyright settings
						disableOrganizeImports = true,
						analysis = {
							typeCheckingMode = "off",
							autoSearchPaths = true,
							useLibraryCodeForTypes = false,
							diagnosticMode = "workspace",
							autoImportCompletions = true,
						},
					},
				},
			})
		end,
	},
}
