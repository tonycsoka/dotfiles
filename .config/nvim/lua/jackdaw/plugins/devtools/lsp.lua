require("jackdaw.postfix").add(function()
	local augroup = vim.api.nvim_create_augroup
	local jackdaw = augroup("Jackdaw", {})

	local autocmd = vim.api.nvim_create_autocmd
	autocmd({ "BufWritePre" }, {
		group = jackdaw,
		pattern = "*",
		command = [[%s/\s\+$//e]],
	})

	autocmd("LspAttach", {
		group = jackdaw,
		callback = function(e)
			local opts = { buffer = e.buf }
			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, opts)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			vim.keymap.set("n", "gw", function()
				vim.lsp.buf.workspace_symbol()
			end, opts)
			vim.keymap.set("n", "gD", function()
				vim.diagnostic.open_float()
			end, opts)
			vim.keymap.set("n", "gc", function()
				vim.lsp.buf.code_action()
			end, opts)
			vim.keymap.set("n", "gr", function()
				vim.lsp.buf.references()
			end, opts)
			vim.keymap.set("n", "gR", function()
				vim.lsp.buf.rename()
			end, opts)
			vim.keymap.set("n", "gs", function()
				vim.lsp.buf.signature_help()
			end, opts)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_next()
			end, opts)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_prev()
			end, opts)
		end,
	})

	local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end
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
			"onsails/lspkind.nvim",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local lspconfig = require("lspconfig")

			-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
			local servers = { "clangd", "rust_analyzer", "pyright", "tsserver", "lua_ls" }
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					-- on_attach = my_custom_on_attach,
					capabilities = capabilities,
				})
			end

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
