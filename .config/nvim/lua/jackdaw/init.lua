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

autocmd("LspAttach", {
	group = jackdaw,
	callback = function(e)
		local function set_keys(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = e.buf, desc = desc })
		end

		local client = vim.lsp.get_client_by_id(e.data.client_id)
		if client == nil then
			return
		end
		if client.name == "ruff" then
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end

		set_keys("gd", function()
			vim.lsp.buf.definition()
		end, "Goto Definition")

		set_keys("gf", function()
			vim.lsp.buf.declaration()
		end, "Goto Declaration")

		set_keys("K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, "Hover")

		set_keys("gS", function()
			vim.lsp.buf.workspace_symbol()
		end, "Workspace Symbol")

		set_keys("gD", function()
			vim.diagnostic.open_float()
		end, "Open Diagnostics")

		set_keys("gc", function()
			vim.lsp.buf.code_action()
		end, "Code Actions")

		set_keys("gr", function()
			vim.lsp.buf.references()
		end, "References")

		set_keys("gR", function()
			vim.lsp.buf.rename()
		end, "Rename")

		set_keys("gs", function()
			vim.lsp.buf.signature_help()
		end, "Signature Help")

		set_keys("]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, "Next Diagnostic")

		set_keys("[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, "Previous Diagnostic")
	end,
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
