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
					load_on_setup = false,
					mappings = {
						alternate_session = { "i", "<C-S>" },
						delete_session = { "i", "<C-D>" },
					},
					picker_opts = {
						border = true,
						layout_config = {
							height = 0.4,
							width = 0.6,
						},
					},
					previewer = false,
				},
			})
		end,
	},
}
