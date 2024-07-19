require("jackdaw.postfix").add(function()
	require("toggleterm").setup({
		size = 20,
		open_mapping = [[<c-\>]],
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = -30,
		shading_ratio = -3,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 0,
		},
	})
end)

return {
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
}
