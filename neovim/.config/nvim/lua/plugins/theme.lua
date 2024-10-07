return {
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	config = function()
	-- 		vim.cmd.colorscheme("carbonfox")
	-- 		--vim.cmd.colorscheme("carbonfox")
	-- 	end,
	-- },
	{
		"miikanissi/modus-themes.nvim",
		priority = 1000,
		opts = function(_, opts)
			vim.cmd.colorscheme("modus")
			return opts
		end,
	},
}
