return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "n",
			desc = "Format buffer",
		},
	},
	-- Everything in opts will be passed to setup()
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { { "prettierd", "prettier" } },
		},
		-- Set up format-on-save
		format_on_save = {
			timeout_ms = 5000,
			lsp_format = "fallback",
			-- async = false,
			-- quiet = false,
		},
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
			black = {
				prepend_args = { "--fast" },
			},
		},
	},
	-- init = function()
	-- 	-- If you want the formatexpr, here is the place to set it
	-- 	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	-- end,
}
