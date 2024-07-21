local M = {}

M.calls = {}
M.highlights = {}

function M.add(func)
	table.insert(M.calls, func)
end

function M.add_highlights(func)
	table.insert(M.highlights, func)
end

function M.doit()
	for _, func in ipairs(M.calls) do
		func()
	end
end

function M.doit_highlights()
	for _, func in ipairs(M.highlights) do
		func()
	end
end

return M
