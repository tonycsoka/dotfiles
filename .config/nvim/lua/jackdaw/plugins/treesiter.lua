return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({ ---@diagnostic disable-line: missing-fields
				-- A list of parser names, or "all"
				ensure_installed = {
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
					"yaml",
					"json",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
				auto_install = true,

				indent = {
					enable = true,
				},

				highlight = {
					-- `false` will disable the whole extension
					enable = false,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					-- additional_vim_regex_highlighting = { "markdown" },
				},
			})
			require("nvim-treesitter.configs").setup({ ---@diagnostic disable-line: missing-fields
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,
		config = function()
			require("nvim-treesitter.configs").setup({ ---@diagnostic disable-line: missing-fields
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
							["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
							["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
							["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

							-- works for javascript/typescript files (custom captures I created in after/queries/ecma/textobjects.scm)
							["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
							["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
							["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
							["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

							["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
							["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

							["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
							["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

							["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
							["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

							["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
							["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

							["am"] = {
								query = "@function.outer",
								desc = "Select outer part of a method/function definition",
							},
							["im"] = {
								query = "@function.inner",
								desc = "Select inner part of a method/function definition",
							},

							["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },

							["a/"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
							["i/"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
							["<leader>n:"] = "@property.outer", -- swap object property with next
							["<leader>nm"] = "@function.outer", -- swap function with next
						},
						swap_previous = {
							["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
							["<leader>p:"] = "@property.outer", -- swap object property with prev
							["<leader>pm"] = "@function.outer", -- swap function with previous
						},
					},
				},
			})
		end,
	},
}
