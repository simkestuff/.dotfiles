return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				latte = { -- latte sa bijelom pozadinom
					rosewater = "#cc7983",
					flamingo = "#bb5d60",
					pink = "#d54597",
					mauve = "#a65fd5",
					red = "#b7242f",
					maroon = "#db3e68",
					peach = "#e46f2a",
					yellow = "#bc8705",
					green = "#1a8e32",
					teal = "#00a390",
					sky = "#089ec0",
					sapphire = "#0ea0a0",
					blue = "#017bca",
					lavender = "#8584f7",
					text = "#444444",
					subtext1 = "#555555",
					subtext0 = "#666666",
					overlay2 = "#777777",
					overlay1 = "#888888",
					overlay0 = "#999999",
					surface2 = "#aaaaaa",
					surface1 = "#bbbbbb",
					surface0 = "#cccccc",
					base = "#ffffff",
					mantle = "#eeeeee",
					crust = "#dddddd",
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	-- {
	-- 	"miikanissi/modus-themes.nvim",
	-- 	priority = 1000,
	-- 	opts = function(_, opts)
	-- 		vim.cmd.colorscheme("modus")
	-- 		return opts
	-- 	end,
	-- },
}
