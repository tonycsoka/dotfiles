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
					"prettierd", -- prettierd formatter
					"stylua", -- lua formatter
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
					"tinymist", -- typst
					"htmlbeautifier", -- html formatter
					"html-lsp", -- html lsp
					"firefox-debug-adapter", -- firefox
					"js-debug-adapter", -- js/ts
					"lemminx", -- xml lsp
					"xmlformatter", -- xml formatter
				},
			})

			local servers = {
				"ts_ls",
				"lua_ls",
				"graphql",
				"gopls",
				"jsonls",
				"sqlls",
				"html",
				"lemminx",
				"tinymist", -- typst
				-- "basedpyright",
				"ruff",
				-- "markdown_oxide", -- markdown
			}

			for _, lsp in ipairs(servers) do
				vim.lsp.config(lsp, {})
				vim.lsp.enable(lsp)
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
			vim.lsp.enable("markdown_oxide")

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
			vim.lsp.enable("basedpyright")

			vim.lsp.config("tinymist", {
				cmd = { "tinymist" },
				filetypes = { "typst" },
				settings = {
					formatterMode = "typstyle",
					exportPdf = "onType",
					semanticTokens = "disable",
				},
			})
			vim.lsp.enable("typst")
		end,
	},
}
