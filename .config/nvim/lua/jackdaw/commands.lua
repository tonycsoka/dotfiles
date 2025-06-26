vim.api.nvim_create_user_command("Lazydot", function(opts)
	Snacks.terminal.open("lazygit -g $HOME/.dotfiles -w $HOME")
end, {})
vim.api.nvim_create_user_command("Lazydocker", function(opts)
	Snacks.terminal.open("lazydocker")
end, {})
vim.api.nvim_create_user_command("GHDash", function(opts)
	Snacks.terminal.open("gh dash")
end, {})

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- strip spaces
local buff = augroup("buffer_rewite", {})
autocmd("BufWritePre", {
	group = buff,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- highlight yanks
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

-- LSP stuff
local lsp_attach = augroup("lsp_attach", {})
autocmd("LspAttach", {
	group = lsp_attach,
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

		if client.server_capabilities.codeLensProvider then
			vim.lsp.codelens.refresh({ bufnr = 0 })
		end

		set_keys("gd", function()
			vim.lsp.buf.definition()
		end, "Goto Definition")

		set_keys("gf", function()
			vim.lsp.buf.declaration()
		end, "Goto Declaration")

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
