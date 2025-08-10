return {
	{
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = true,
			keymaps = {
				["q"] = "actions.close",
			},
			lsp_file_methods = {
				enabled = true,
				timeout_ms = 1000,
				autosave_changes = true,
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
		keys = {
			{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
			{ "<leader>e", "<CMD>Oil --float<CR>", desc = "Open parent directory" },
		},
	},
}
