local utils = require("jackdaw.utils")
return {
	{
		dir = "~/Work/Personal/jira.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("jira-nvim").setup({
				base_url = utils.get_token("jira/url"),
				email = utils.get_token("jira/email"),
				api_token = utils.get_token("jira/token"),
				-- board = "TSR board",
			})
		end,
	},
}
