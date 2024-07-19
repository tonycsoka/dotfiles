require("jackdaw.postfix").add(function()
	local harpoon = require("harpoon")

	-- REQUIRED
	harpoon:setup()
	-- REQUIRED

	vim.keymap.set("n", "<leader>a", function()
		harpoon:list():add()
	end, { desc = "Harpoon add" })
	vim.keymap.set("n", "<C-e>", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end, { desc = "Harpoon menu" })

	vim.keymap.set("n", "<C-h>", function()
		harpoon:list():select(1)
	end, { desc = "Harpoon b1" })
	vim.keymap.set("n", "<C-t>", function()
		harpoon:list():select(2)
	end, { desc = "Harpoon b2" })
	vim.keymap.set("n", "<C-n>", function()
		harpoon:list():select(3)
	end, { desc = "Harpoon b3" })
	vim.keymap.set("n", "<C-s>", function()
		harpoon:list():select(4)
	end, { desc = "Harpoon b4" })

	-- Toggle previous & next buffers stored within Harpoon list
	vim.keymap.set("n", "<C-S-P>", function()
		harpoon:list():prev()
	end, { desc = "Hapoon prev" })
	vim.keymap.set("n", "<C-S-N>", function()
		harpoon:list():next()
	end, { desc = "Harpoon next" })
end)
return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
