return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
		},
		config = function()
			local types = require("luasnip.util.types")
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").config.setup({
				keep_roots = true,
				link_roots = true,
				link_children = true,
				exit_roots = false,
				cut_selection_keys = "<Tab>",
				ext_opts = {
					[types.choiceNode] = {
						active = {
							virt_text = { { "●", "BlinkIndentOrange" } },
						},
					},
					[types.insertNode] = {
						active = {
							virt_text = { { "●", "BlinkIndentBlue" } },
						},
					},
				},
			})
		end,
	},
}
