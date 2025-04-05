require("jackdaw.options")
require("jackdaw.lazy")
require("jackdaw.keymap")
require("jackdaw.postfix").doit()

vim.cmd.colorscheme("catppuccin")

require("jackdaw.postfix").doit_highlights()

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none", ctermbg = "none" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none", ctermbg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", ctermbg = "none" })
-- vim.api.nvim_set_hl(0, "NonText", { bg = "none", ctermbg = "none" })
-- vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none", ctermbg = "none" })
-- vim.api.nvim_set_hl(0, "StatusLine", { bg = "none", ctermbg = "none" })

local augroup = vim.api.nvim_create_augroup
local yank_group = augroup("HighlightYank", {})

local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

require("jackdaw.commands")
require("jackdaw.deep_shell")
