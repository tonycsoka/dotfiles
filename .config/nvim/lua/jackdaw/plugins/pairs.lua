return {
	{
		"echasnovski/mini.pairs",
		version = "*",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"tronikelis/ts-autotag.nvim",
		opts = {
			auto_rename = {
				enabled = true,
			},
		},
	},
}
