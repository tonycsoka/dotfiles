return {
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		lazy = false,
		branch = "regexp", -- This is the regexp branch, use this for the new version
		config = function()
			require("venv-selector").setup({})
		end,
		keys = {
			{ "<leader>v", "<cmd>VenvSelect<cr>" },
		},
	},
}
