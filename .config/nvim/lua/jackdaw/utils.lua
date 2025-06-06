local M = {}

M.get_token = function(key)
	local openPop = assert(io.popen("pass " .. key))
	local token = openPop:read("*all"):sub(1, -2)
	openPop:close()
	return token
end

return M
