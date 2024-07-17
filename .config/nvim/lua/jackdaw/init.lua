vim.cmd("let g:netrw_liststyle = 3")

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.cmdheight = 0
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 4
vim.opt.foldlevelstart = 1
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

require("jackdaw.lazy")
require("jackdaw.keymap")

vim.cmd.colorscheme("catppuccin")
vim.api.nvim_set_hl(0, "Normal", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", ctermbg = "none" })

require("jackdaw.lazy")
require("jackdaw.keymap")

local augroup = vim.api.nvim_create_augroup
local jackdaw = augroup("Jackdaw", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

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

autocmd({ "BufWritePre" }, {
	group = jackdaw,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
	group = jackdaw,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "dw", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "gD", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "gc", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "gr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "gR", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "gs", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
	end,
})

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require("oil").setup({
	default_file_explorer = true,
	keymaps = {
		["q"] = "actions.close",
	},
})

require("mini.pairs").setup()

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

local python_path = table
	.concat({ vim.fn.stdpath("data"), "mason", "packages", "debugpy", "venv", "bin", "python" }, "/")
	:gsub("//+", "/")
require("dap-python").setup(python_path)
require("dapui").setup()

require("neotest").setup({ ---@diagnostic disable-line: missing-fields
	adapters = {
		require("neotest-python"),
	},
})

require("notify").setup({ ---@diagnostic disable-line: missing-fields
	background_colour = "#000000",
})

require("mini.surround").setup()

require("gitsigns").setup()

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
end)
vim.keymap.set("n", "<C-S-N>", function()
	harpoon:list():next()
end)

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
