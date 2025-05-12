return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"j-hui/fidget.nvim",
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
					"basedpyright", -- python lsp
					"rust_analyzer",
					"clangd", -- c family lsp
					"lua_ls", -- lua lsp
					"debugpy", -- python dap
					"codelldb", -- c family debugger
					"sourcery", -- multi language AI code actions
					"graphql-language-service-cli", -- graphql
					"golangci-lint-langserver", -- golang
					"golangci-lint", -- golang
					"gopls", -- golang
					"json-lsp", -- json
					"sqlls", --sql
				},
			})
			require("mason-lspconfig").setup()

			-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
			local servers = { "clangd", "rust_analyzer", "ts_ls", "lua_ls", "graphql", "gopls", "jsonls", "sqlls" }
			for _, lsp in ipairs(servers) do
				vim.lsp.enable(lsp)
				vim.lsp.config(lsp, {})
			end

			vim.lsp.enable("basedpyright")
			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						-- Pyright settings
						disableOrganizeImports = true,
						-- },
						-- python = {
						analysis = {
							typeCheckingMode = "off",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							autoImportCompletions = true,
						},
					},
				},
			})

			local get_token = function()
				local openPop = assert(io.popen("pass api/sourcery"))
				local token = openPop:read("*all"):sub(1, -2)
				openPop:close()
				return token
			end

			vim.lsp.enable("sourcery")
			vim.lsp.config("sourcery", {
				init_options = {
					editor_version = "vim",
					extension_version = "vim.lsp",
					token = get_token(),
				},
			})
			-- require("lspconfig.ui.windows").default_options.border = "single"
		end,
	},
	{
		"saghen/blink.cmp",

		-- use a release tag to download pre-built binaries
		version = "1.*",
		dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap

			keymap = { preset = "enter" },
			snippets = {
				preset = "luasnip",
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			-- completion = { documentation = { auto_show = false } },
			completion = {
				list = {
					selection = { preselect = true, auto_insert = true },
				},

				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = {
						border = "rounded",
					},
				},
				menu = {
					auto_show = true,
					border = "rounded",
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
					},
				},
			},
			signature = {
				enabled = true,
			},

			cmdline = {
				keymap = { preset = "cmdline" },
				completion = { menu = { auto_show = true } },
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "buffer", "lsp", "snippets", "path", "omni" },
				per_filetype = {
					sql = { "snippets", "dadbod", "buffer" },
				},
				-- add vim-dadbod-completion to your completion providers
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = {
				implementation = "prefer_rust_with_warning",
				-- sorts = {
				-- 	"exact",
				-- 	"kind",
				-- 	"score",
				-- 	"sort_text",
				-- },
			},
		},
		opts_extend = { "sources.default" },
	},
}
