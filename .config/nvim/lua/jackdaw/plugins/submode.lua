require("jackdaw.postfix").add(function()
	local layers = require("layers").setup({})
	local mode = layers.mode.new()

	mode:auto_show_help()

	vim.keymap.set("n", "<leader>r", function()
		mode.window.config.title = "Refactor Mode"
		mode:activate()
	end, { desc = "Refactor Mode" })

	mode:keymaps({
		n = {
			{
				"n",
				function()
					vim.diagnostic.goto_next()
				end,
				{ desc = "Next diagnostic" },
			},
			{
				"p",
				function()
					vim.diagnostic.goto_prev()
				end,
				{ desc = "Previous diagnostic" },
			},
			{
				"w",
				"gww",
				{ desc = "Format comments" },
			},
			{
				"q",
				function()
					mode:deactivate()
				end,
				{ desc = "quit" },
			},
		},
	})
end)

return {
	{
		"debugloop/layers.nvim",
		opts = {}, -- see :help Layers.config
	},
}
