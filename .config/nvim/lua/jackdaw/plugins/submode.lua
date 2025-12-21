return {
	{
		"debugloop/layers.nvim",
		config = function()
			local layers = require("layers").setup({})

			local make_mode = function(opts)
				local mode = layers.mode.new()

				mode:auto_show_help()

				vim.keymap.set("n", opts.mode_key, function()
					mode.window.config.title = opts.title
					if mode:active() then
						mode:deactivate()
					else
						mode:activate()
					end
				end, { desc = "Toggle " .. opts.title })

				mode:keymaps(opts.keymaps)
			end

			make_mode({
				mode_key = "<leader>d",
				title = "Debug Mode",
				keymaps = {
					n = {
						{
							"c",
							function()
								require("dap").continue()
							end,
							{ desc = "Continue" },
						},
						{
							"x",
							function()
								require("dap").close()
							end,
							{ desc = "Stop" },
						},
						{
							"r",
							function()
								require("dap").run_last()
							end,
							{ desc = "Run last" },
						},
						{
							"b",
							function()
								require("dap").toggle_breakpoint()
							end,
							{ desc = "Toggle breakpoint" },
						},
						{
							"i",
							function()
								require("dap").step_into()
							end,
							{ desc = "Step into" },
						},
						{
							"o",
							function()
								require("dap").step_over()
							end,
							{ desc = "Step over" },
						},
						{
							"u",
							function()
								require("dap-view").toggle()
							end,
							{ desc = "Toggle UI" },
						},
						{
							"t",
							function()
								require("neotest").run.run()
							end,
							{ desc = "Run nearest test" },
						},
						{
							"T",
							function()
								require("neotest").run.run({ strategy = "dap" }) ---@diagnostic disable-line: missing-fields
							end,
							{ desc = "Debug nearest test" },
						},
						{
							"f",
							function()
								require("neotest").run.run()
							end,
							{ desc = "Run all tests" },
						},
						{
							"F",
							function()
								require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) ---@diagnostic disable-line: missing-fields
							end,
							{ desc = "Debug all tests" },
						},
						{
							"s",
							function()
								require("neotest").summary.toggle() ---@diagnostic disable-line: missing-fields
							end,
							{ desc = "Test Summary Toggle" },
						},
					},
				},
			})
		end,
	},
}
