return {
	{
		"rmagatti/auto-session",
		lazy = false,
		keys = {
			-- Will use Telescope if installed or a vim.ui.select picker otherwise
			{ "<leader>wr", "<cmd>SessionSearch<CR>", desc = "Session search" },
			{ "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session" },
			{ "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
		},

		config = function()
			require("auto-session").setup({
				session_lens = {
					-- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
					load_on_setup = false,
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
