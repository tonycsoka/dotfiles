return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		setup = function()
			require("gitsigns").setup()
		end,
	},
}
