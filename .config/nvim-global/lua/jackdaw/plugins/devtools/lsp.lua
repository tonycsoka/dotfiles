return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("mason-lspconfig").setup()

			-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
			local servers = { "clangd", "rust_analyzer", "ts_ls", "lua_ls" }
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

			-- lspconfig.sourcery.setup({
			-- 	handlers = handlers,
			vim.lsp.enable("sourcery")
			vim.lsp.config("sourcery", {
				init_options = {
					editor_version = "vim",
					extension_version = "vim.lsp",
					token = get_token(),
				},
			})
			-- require("lspconfig.ui.windows").default_options.border = "single"

			local augroup = vim.api.nvim_create_augroup
			local jackdaw = augroup("Jackdaw", {})

			local autocmd = vim.api.nvim_create_autocmd
			autocmd("LspAttach", {
				group = jackdaw,
				callback = function(e)
					local function set_keys(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = e.buf, desc = desc })
					end

					local client = vim.lsp.get_client_by_id(e.data.client_id)
					if client == nil then
						return
					end
					if client.name == "ruff" then
						-- Disable hover in favor of Pyright
						client.server_capabilities.hoverProvider = false
					end

					set_keys("gd", function()
						vim.lsp.buf.definition()
					end, "Goto Definition")

					set_keys("gf", function()
						vim.lsp.buf.declaration()
					end, "Goto Declaration")

					set_keys("K", function()
						vim.lsp.buf.hover()
					end, "Hover")

					set_keys("gS", function()
						vim.lsp.buf.workspace_symbol()
					end, "Workspace Symbol")

					set_keys("gD", function()
						vim.diagnostic.open_float()
					end, "Open Diagnostics")

					set_keys("gc", function()
						vim.lsp.buf.code_action()
					end, "Code Actions")

					set_keys("gr", function()
						vim.lsp.buf.references()
					end, "References")

					set_keys("gR", function()
						vim.lsp.buf.rename()
					end, "Rename")

					set_keys("gs", function()
						vim.lsp.buf.signature_help()
					end, "Signature Help")

					set_keys("]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "Next Diagnostic")

					set_keys("[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "Pervious Diagnostic")
				end,
			})
		end,
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

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
					border = "rounded",
					draw = {
						gap = 2,
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
					},
				},
			},
			signature = {
				enabled = true,
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
