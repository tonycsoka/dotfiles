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
					"ruff", -- python linter / formatter
					"eslint_d", -- js linter
					"typescript-language-server", -- typescript lsp
					"basedpyright", -- python lsp
					"rust-analyzer",
					"clangd", -- c family lsp
					"lua-language-server", -- lua lsp
					"debugpy", -- python dap
					"codelldb", -- c family debugger
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
				"clangd",
				"rust_analyzer",
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
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							autoImportCompletions = true,
						},
					},
				},
			})
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
				keymap = {
					preset = "inherit",
					["<CR>"] = { "accept_and_enter", "fallback" },
				},
				completion = {
					menu = {
						auto_show = true,
					},
					ghost_text = { enabled = true },
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "buffer", "lsp", "snippets", "path", "omni" },
				per_filetype = {
					lua = { "lazydev", "buffer", "lsp", "snippets", "path", "omni" },
					sql = { "snippets", "dadbod", "buffer" },
				},
				-- add vim-dadbod-completion to your completion providers
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					cmdline = {
						min_keyword_length = function(ctx)
							-- when typing a command, only show when the keyword is 3 characters or longer
							if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
								return 3
							end
							return 0
						end,
					},
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
