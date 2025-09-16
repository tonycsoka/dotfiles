return {
	{
		"rmagatti/auto-session",
		lazy = false,
		keys = {
			-- Will use Telescope if installed or a vim.ui.select picker otherwise
			{ "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
			{ "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
			{ "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
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
						preview = false,
						preset = "dropdown",
						border = true,
						layout_config = {
							height = 0.4,
							width = 0.6,
						},
					},
					previewer = false,
				},
				suppressed_dirs = { "~/" },
			})
		end,
	},
}
