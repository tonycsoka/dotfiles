vim.lsp.config["dictionary"] = {
	cmd = function()
		return {
			request = function(m, p, c, n)
				if m == "initialize" then
					c(nil, {
						capabilities = {
							hoverProvider = true,
						},
					})
				end
				if m == "textDocument/hover" then
					local cword = vim.fn.expand("<cword>")
					local word = require("blink-cmp-words.wordnet").get_similar_words_for_word(cword, 4)[1]
					local defn = require("blink-cmp-words.wordnet").get_definition_for_word(word, {})
					c(nil, {
						contents = defn,
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

vim.lsp.enable("dictionary")
