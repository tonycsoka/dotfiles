return {
	{
		"rmagatti/auto-session",
		dependencies = {
			"nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
		},
		config = function()
			require("auto-session").setup({
				session_lens = {
					-- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
					load_on_setup = true,
					theme_conf = { border = true },
					previewer = false,
					mappings = {
						-- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
						delete_session = { "i", "<C-D>" },
						alternate_session = { "i", "<C-S>" },
					},
				},
			})
		end,
	},
}
