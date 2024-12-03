local Terminal = require("toggleterm.terminal").Terminal

local git_tui = "lazydocker"

local git_client = Terminal:new({
	cmd = git_tui,
	hidden = true,
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "double",
	},
})

vim.api.nvim_create_user_command("LazyDocker", function()
	git_client:toggle()
end, {})

vim.api.nvim_create_user_command("VPN", function(opts)
	if opts.args == "stop" then
		vim.system({ "scutil", "--nc", "stop", "Global VPN Breakglass" }, {}, function()
			print("VPN Stopped")
		end)
	elseif opts.args == "start" then
		vim.system({ "scutil", "--nc", "start", "Global VPN Breakglass" }, {}, function()
			print("VPN Started")
		end)
	else
		print("Unknown arg: " .. opts.args .. ". Expect 'start' or 'stop'")
	end
end, {
	nargs = 1,
	complete = function(ArgLead, CmdLine, CursorPos)
		return { "stop", "start" }
	end,
})
