return {
	{
		"wakatime/vim-wakatime",
		lazy = false,
		enabled = (vim.uv.fs_stat(os.getenv("HOME") .. "/.wakatime.cfg") ~= nil),
	},
}
