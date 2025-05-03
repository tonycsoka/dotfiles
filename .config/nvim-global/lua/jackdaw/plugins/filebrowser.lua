return {
	{
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = true,
			keymaps = {
				["q"] = "actions.close",
			},
		},
		-- Optional dependencies
		-- dependencies = { "echasnovski/mini.icons" },
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	},
}
