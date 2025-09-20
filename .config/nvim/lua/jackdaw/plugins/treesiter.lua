local languages = {
	"vim",
	"regex",
	"vimdoc",
	"javascript",
	"typescript",
	"c",
	"lua",
	"rust",
	"jsdoc",
	"bash",
	"cpp",
	"python",
	"xml",
	"html",
	"yaml",
	"json",
	"http",
	"go",
	"sql",
	"gherkin",
	"markdown",
	"markdown_inline",
	"typst",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "TSUpdate",
				callback = function()
					require("nvim-treesitter.parsers").gherkin = {
						---@diagnostic disable-next-line missing-fields
						install_info = {
							url = "https://github.com/tonycsoka/tree-sitter-gherkin",
							queries = "queries",
						},

						tier = 2,
					}
				end,
			})
			vim.treesitter.language.register("gherkin", { "cucumber" })
		end,
	},
	{
		"MeanderingProgrammer/treesitter-modules.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			ensure_installed = languages,
			fold = { enable = true },
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-CR>",
					node_incremental = "<C-CR>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		},
	},
}
