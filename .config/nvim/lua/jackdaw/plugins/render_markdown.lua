return {
	{
		-- Make sure to set this up properly if you have lazy=true
		"MeanderingProgrammer/render-markdown.nvim",
		-- ft = { "markdown" },
		config = function()
			require("render-markdown").setup({
				disable_background = true,
				width = "block",
				completions = { blink = { enabled = true } },
			})
		end,
	},
}
