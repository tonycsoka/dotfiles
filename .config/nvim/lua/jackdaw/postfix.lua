local M = {}

M.calls = {}

function M.add(func)
	table.insert(M.calls, func)
end

function M.doit()
	for _, func in ipairs(M.calls) do
		func()
	end
end

return M
