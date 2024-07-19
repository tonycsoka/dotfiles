require("jackdaw.postfix").add(function()
	require("notify").setup({ ---@diagnostic disable-line: missing-fields
		background_colour = "#000000",
	})

	require("gitsigns").setup()
end)

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
