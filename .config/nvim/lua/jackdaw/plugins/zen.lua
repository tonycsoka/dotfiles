require("jackdaw.postfix").add_highlights(function()
	vim.api.nvim_set_hl(0, "ZenBg", { ctermbg = 0 })
end)

return {
	{
		"folke/zen-mode.nvim",
		opts = {
			window = {
				backdrop = 0, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
				-- height and width can be:
				-- * an absolute number of cells when > 1
				-- * a percentage of the width / height of the editor when <= 1
				-- * a function that returns the width or the height
				width = 0.85, -- width of the Zen window
				height = 0.85, -- height of the Zen window
				-- by default, no options are changed for the Zen window
				-- uncomment any of the options below, or add other vim.wo options you want to apply
				options = {
					signcolumn = "no", -- disable signcolumn
					number = false, -- disable number column
					relativenumber = false, -- disable relative numbers
					cursorline = false, -- disable cursorline
					cursorcolumn = false, -- disable cursor column
					foldcolumn = "0", -- disable fold column
					list = false, -- disable whitespace characters
				},
			},
			plugins = {
				options = {
					laststatus = 0,
				},
				wezterm = {
					enabled = true,
					-- can be either an absolute font size or the number of incremental steps
					font = "+2", -- (10% increase per step)
				},
			},
		},
	},
}
