require("jackdaw.options")
require("jackdaw.lazy")
require("jackdaw.keymap")

local augroup = vim.api.nvim_create_augroup
local jackdaw = augroup("Jackdaw", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd({ "BufWritePre" }, {
	group = jackdaw,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = "󰋼 ",
			[vim.diagnostic.severity.HINT] = "󰌵 ",
		},
	},
})

vim.cmd.colorscheme("catppuccin")

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk", { bg = "none", ctermbg = "none" })

augroup = vim.api.nvim_create_augroup
local yank_group = augroup("HighlightYank", {})

autocmd = vim.api.nvim_create_autocmd

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
