vim.lsp.config["dictionary"] = {
	cmd = function()
		return {
			request = function(m, p, c, n)
				print(m)
				if m == "initialize" then
					c(nil, {
						capabilities = {
							hoverProvider = true,
						},
					})
				end
				if m == "textDocument/hover" then
					local cword = vim.fn.expand("<cword>")
					-- lookup in the dict
					c(nil, {
						contents = cword .. ": Here's a definition for you",
					})
				end
			end,
			notify = function(m, p) end,
			is_closing = function()
				return false
			end,
			terminate = function() end,
		}
	end,
	filetypes = { "markdown" },
}

-- vim.lsp.enable("dictionary")
