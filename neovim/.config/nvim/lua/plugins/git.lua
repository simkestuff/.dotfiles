return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
			-- "ibhagwan/fzf-lua", -- optional
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				integrations = {
					telescope = true,
					diffview = true,
				},
				vim.keymap.set("n", "<leader>g", "<cmd>Neogit<CR>", { desc = "Git status" }),
			})
		end,
	},
	{
		"tpope/vim-fugitive",
	},
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			on_attach = function(bufnr)
				-- Navigation
				vim.keymap.set(
					"n",
					"[c",
					require("gitsigns").prev_hunk,
					{ buffer = bufnr, desc = "Go to Previous Hunk" }
				)
				vim.keymap.set("n", "]c", require("gitsigns").next_hunk, { buffer = bufnr, desc = "Go to Next Hunk" })
			end,
		},
	},
}
