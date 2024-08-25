require("jackdaw.postfix").add(function()
	local augroup = vim.api.nvim_create_augroup
	local jackdaw = augroup("Jackdaw", {})

	local autocmd = vim.api.nvim_create_autocmd
	autocmd({ "BufWritePre" }, {
		group = jackdaw,
		pattern = "*",
		command = [[%s/\s\+$//e]],
	})

	require("lspconfig.ui.windows").default_options.border = "single"

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

			set_keys("K", function()
				vim.lsp.buf.hover()
			end, "Hover")

			set_keys("gw", function()
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

			set_keys("[d", function()
				vim.diagnostic.goto_next()
			end, "Next Diagnostic")

			set_keys("]d", function()
				vim.diagnostic.goto_prev()
			end, "Pervious Diagnostic")
		end,
	})

	local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl, bg = "none", ctermbg = "none" })
	end
end)

require("jackdaw.postfix").add_highlights(function()
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk", { bg = "none", ctermbg = "none" })
end)

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
			},
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
		},
		config = function()
			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
			}
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local lspconfig = require("lspconfig")

			-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
			local servers = { "clangd", "rust_analyzer", "pyright", "tsserver", "lua_ls" }
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					-- on_attach = my_custom_on_attach,
					capabilities = capabilities,
					handlers = handlers,
				})
			end

			local get_token = function()
				local openPop = assert(io.popen("pass api/sourcery"))
				local token = openPop:read("*all"):sub(1, -2)
				openPop:close()
				return token
			end

			lspconfig.sourcery.setup({
				init_options = {
					token = get_token(),
				},
			})

			-- luasnip setup
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()

			-- nvim-cmp setup
			local cmp = require("cmp")
			cmp.setup({ ---@diagnostic disable-line: redundant-parameter
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp", keyword_length = 1 },
					{ name = "buffer", keyword_length = 1 },
					{ name = "luasnip", keyword_length = 2 },
				},
				window = {
					documentation = cmp.config.window.bordered(),
					completion = cmp.config.window.bordered(),
				},
				formatting = { ---@diagnostic disable-line: missing-fields
					fields = { "menu", "abbr", "kind" },
					format = function(entry, item)
						local menu_icon = {
							buffer = "Ω",
							nvim_lsp = "λ",
							luasnip = "⋗",
							path = "󰙅",
						}

						item.menu = menu_icon[entry.source.name]
						return item
					end,
				},
			})
		end,
	},
}
