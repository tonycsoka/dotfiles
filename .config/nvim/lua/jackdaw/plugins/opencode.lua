return {
	{
		"sudo-tee/opencode.nvim",
		opts = {
			preferred_picker = "snacks",
			preferred_completion = "blink",
			default_global_keymaps = true,
			default_mode = "plan",
			keymap_prefix = "<leader>a",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					anti_conceal = { enabled = false },
					file_types = { "markdown", "opencode_output" },
				},
				ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
			},
			"saghen/blink.cmp",
			"folke/snacks.nvim",
		},
	},
}
