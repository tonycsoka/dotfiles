require("jackdaw.postfix").add(function()
	require("oil").setup({
		default_file_explorer = true,
		keymaps = {
			["q"] = "actions.close",
		},
	})
end)

return {
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		-- dependencies = { "echasnovski/mini.icons" },
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	},
}
