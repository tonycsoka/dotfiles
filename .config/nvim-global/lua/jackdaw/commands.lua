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
	if string.find("start stop", opts.args) then
		vim.system({ "scutil", "--nc", opts.args, "Global VPN Breakglass" }, {}, function()
			print("VPN : " .. opts.args)
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
