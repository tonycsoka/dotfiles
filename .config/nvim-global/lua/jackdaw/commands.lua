vim.api.nvim_create_user_command("VPNStart", '!scutil --nc start "Global VPN Breakglass"', {})
vim.api.nvim_create_user_command("VPNStop", '!scutil --nc stop "Global VPN Breakglass"', {})

local Terminal = require("toggleterm.terminal").Terminal

local git_tui = "lazydocker"
-- local git_tui = "gitui"

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
