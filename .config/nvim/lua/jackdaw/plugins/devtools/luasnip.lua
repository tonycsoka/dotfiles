return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").config.setup({ store_selection_keys = "<Tab>" })
		end,
	},
}
