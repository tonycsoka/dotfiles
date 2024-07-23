local excluded_filetypes_array = {
	"",
	"DressingSelect",
	"ImportManager",
	"Jaq",
	"NeogitCommitMessage",
	"Outline",
	"Trouble",
	"aerial",
	"alpha",
	"checkhealth",
	"dap-repl",
	"dashboard",
	"dbui",
	"floaterm",
	"fugitive",
	"git",
	"harpoon",
	"help",
	"lab",
	"lazy",
	"lir",
	"lsp-installer",
	"lspinfo",
	"man",
	"neogitstatus",
	"neotest-summary",
	"netrw",
	"noice",
	"notify",
	"packer",
	"qf",
	"spectre_panel",
	"spectre_panel_write",
	"startify",
	"toggleterm",
	"trouble",
}
local excluded_filetypes_table = {}
for _, value in ipairs(excluded_filetypes_array) do
	excluded_filetypes_table[value] = 1
end

return {
	{
		"nvim-lualine/lualine.nvim", -- Neovim status line
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"SmiteshP/nvim-navic",
			"mfussenegger/nvim-lint",
		},
		lazy = false,
		priority = 999,
		config = function()
			local lualine = require("lualine")
			local nvim_navic = require("nvim-navic")
			nvim_navic.setup({
				seperator = " > ",
				highlight = false,
				lsp = {
					auto_attach = true,
				},
			})
			local create_symbol_bar = function()
				if not nvim_navic.is_available() then
					return ""
				end
				return nvim_navic.get_location({
					separator = " -> ",
					highlight = true,
					icons = {
						File = " ",
						Module = " ",
						Namespace = " ",
						Package = " ",
						Class = " ",
						Method = " ",
						Property = " ",
						Field = " ",
						Constructor = " ",
						Enum = " ",
						Interface = " ",
						Function = " ",
						Variable = " ",
						Constant = " ",
						String = " ",
						Number = " ",
						Boolean = " ",
						Array = " ",
						Object = " ",
						Key = " ",
						Null = " ",
						EnumMember = " ",
						Struct = " ",
						Event = " ",
						Operator = " ",
						TypeParameter = " ",
					},
				})
			end
			local get_buf_filetype = function()
				return vim.api.nvim_get_option_value("filetype", { buf = 0 })
			end
			local format_name = function(output)
				if excluded_filetypes_table[get_buf_filetype()] then
					return ""
				end
				return output
			end
			local branch_max_width = 40
			local branch_min_width = 10
			lualine.setup({ ---@diagnostic disable-line: redundant-parameter
				options = {
					theme = "palenight",
					disabled_filetypes = { "dap-repl", winbar = excluded_filetypes_array },
					globalstatus = true,
				},
				sections = {
					lualine_a = {
						-- "mode",
						{
							require("noice").api.status.command.get,
							cond = require("noice").api.status.command.has,
						},
						{
							require("noice").api.status.mode.get,
							cond = require("noice").api.status.mode.has,
						},
						{
							require("noice").api.status.search.get,
							cond = require("noice").api.status.search.has,
						},
						{
							"branch",
							fmt = function(output)
								local win_width = vim.o.columns
								local max = branch_max_width
								if win_width * 0.25 < max then
									max = math.floor(win_width * 0.25)
								end
								if max < branch_min_width then
									max = branch_min_width
								end
								if max % 2 ~= 0 then
									max = max + 1
								end
								if output:len() >= max then
									return output:sub(1, (max / 2) - 1) .. "..." .. output:sub(-1 * ((max / 2) - 1), -1)
								end
								return output
							end,
						},
					},
					lualine_b = {
						{
							"filename",
							file_status = false,
							path = 1,
							fmt = format_name,
						},
						{
							"diagnostics",
							update_in_insert = true,
						},
					},
					lualine_c = {},
					lualine_x = {
						"import",
					},
					-- Combine x and y
					lualine_y = {
						{
							function()
								local lsps = vim.lsp.get_clients({ bufnr = vim.fn.bufnr() })
								local icon = require("nvim-web-devicons").get_icon_by_filetype(
									vim.api.nvim_get_option_value("filetype", { buf = 0 })
								)
								if lsps and #lsps > 0 then
									local names = {}
									for _, lsp in ipairs(lsps) do
										table.insert(names, lsp.name)
									end
									return string.format("%s %s", table.concat(names, ", "), icon)
								else
									return icon or ""
								end
							end,
							on_click = function()
								vim.api.nvim_command("LspInfo")
							end,
							color = function()
								local _, color = require("nvim-web-devicons").get_icon_cterm_color_by_filetype(
									vim.api.nvim_get_option_value("filetype", { buf = 0 })
								)
								return { fg = color }
							end,
						},
						{
							function()
								local linters = require("lint").get_running()
								if #linters == 0 then
									return "󰦕"
								end
								return "󱉶 " .. table.concat(linters, ", ")
							end,
						},
						"encoding",
						"progress",
					},
					lualine_z = {
						"location",
						{
							function()
								local starts = vim.fn.line("v")
								local ends = vim.fn.line(".")
								local count = starts <= ends and ends - starts + 1 or starts - ends + 1
								return count .. "V"
							end,
							cond = function()
								return vim.fn.mode():find("[Vv]") ~= nil
							end,
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						{
							"filetype",
							icon_only = true,
						},
						{
							"filename",
							path = 1,
							fmt = format_name,
						},
					},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				winbar = {
					lualine_a = {

						{ "filetype", icon_only = true, icon = { align = "left" } },
						{ "filename", file_status = false, path = 0 },
					},
					lualine_b = {},
					lualine_c = { { create_symbol_bar } },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_winbar = {
					lualine_a = {
						{ "filetype", icon_only = true, icon = { align = "left" } },
						{ "filename", file_status = false, path = 0 },
					},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
}
