return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon"):setup()
		end,
		keys = {
			{
				"<leader>a",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Harpoon Add",
			},
			{
				"<c-e>",
				function()
					require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
				end,
				desc = "Harpoon Menu",
			},
			{
				"<leader>1",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Harpoon Buffer 1",
			},
			{
				"<leader>2",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Harpoon Buffer 2",
			},
			{
				"<leader>3",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Harpoon Buffer 3",
			},
			{
				"<leader>4",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Harpoon Buffer 4",
			},
			{
				"<c-s-p>",
				function()
					require("harpoon"):list():prev()
				end,
				desc = "Harpoon Prev",
			},
			{
				"<c-s-n>",
				function()
					require("harpoon"):list():next()
				end,
				desc = "Harpoon Next",
			},
		},
	},
}
