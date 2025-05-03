vim.api.nvim_create_user_command("VPN", function(opts)
	if string.find("start", opts.args) then
		local get_password = function()
			local openPop = assert(io.popen("pass work/global"))
			local token = openPop:read("*all"):sub(1, -2)
			openPop:close()
			return token
		end

		local pword = get_password()
		vim.system({
			"scutil",
			"--nc",
			opts.args,
			"Global VPN Breakglass",
			"--password",
			pword,
		}, {}, function()
			print("VPN : " .. opts.args)
		end)
	elseif string.find("stop", opts.args) then
		vim.system({
			"scutil",
			"--nc",
			opts.args,
			"Global VPN Breakglass",
		}, {}, function()
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
