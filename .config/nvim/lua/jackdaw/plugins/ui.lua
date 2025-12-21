return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				presets = {
					lsp_doc_border = true,
				},
				routes = {
					{
						filter = { event = "msg_show", kind = { "shell_out", "shell_err" } },
						view = "notify",
						opts = {
							level = "info",
							skip = false,
							replace = false,
						},
					},
				},
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
}
