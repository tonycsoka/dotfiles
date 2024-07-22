return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.5",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("telescope").setup({}) ---@diagnostic disable-line: redundant-parameter

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope Find File" })
		vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Telescope Find Git Files" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope Find Buffer" })
		vim.keymap.set("n", "<leader>ft", builtin.live_grep, { desc = "Telescope Grep" })
		vim.keymap.set("n", "<leader>fw", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end, { desc = "Telescope Find word" })
		vim.keymap.set("n", "<leader>fW", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end, { desc = "Telescope Find wORD" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope Help Tags" })
	end,
}
